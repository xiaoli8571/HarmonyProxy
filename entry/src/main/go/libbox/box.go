package main

/*
#include <stdlib.h>
*/
import "C"

import (
	"fmt"
	"os"
	"runtime"
	"runtime/debug"
	"strconv"
	"sync"
)

func init() {
	// HarmonyOS compatibility: disable async preemption (avoids SIGURG issues)
	os.Setenv("GODEBUG", "asyncpreemptoff=1")

	// Limit to single CPU to avoid excessive thread creation on constrained system
	runtime.GOMAXPROCS(1)

	// More aggressive GC for lower memory footprint
	debug.SetGCPercent(50)
}

var (
	running   bool
	mutex     sync.Mutex
	lastError string
)

//export BoxStart
func BoxStart(config *C.char) int {
	mutex.Lock()
	defer mutex.Unlock()

	// Diagnostic: log Go runtime info
	fmt.Fprintf(os.Stderr, "[Go] BoxStart: Go %s | OS=%s ARCH=%s CPUs=%d\n",
		runtime.Version(), runtime.GOOS, runtime.GOARCH, runtime.NumCPU())

	if running {
		fmt.Fprintf(os.Stderr, "[Go] BoxStart: already running, skip\n")
		return 0
	}

	if config == nil {
		lastError = "config is nil"
		fmt.Fprintf(os.Stderr, "[Go] BoxStart ERROR: %s\n", lastError)
		return -1
	}

	jsonConfig := C.GoString(config)
	fmt.Fprintf(os.Stderr, "[Go] BoxStart: config len=%d\n", len(jsonConfig))

	err := StartService(jsonConfig)
	if err != nil {
		lastError = err.Error()
		fmt.Fprintf(os.Stderr, "[Go] BoxStart ERROR: %s\n", lastError)
		return -1
	}

	running = true
	fmt.Fprintf(os.Stderr, "[Go] BoxStart: success\n")
	return 0
}

//export BoxStop
func BoxStop() int {
	mutex.Lock()
	defer mutex.Unlock()

	if !running {
		return 0
	}

	StopService()
	running = false
	return 0
}

//export BoxStatus
func BoxStatus() int {
	mutex.Lock()
	defer mutex.Unlock()

	if running {
		return 1
	}
	return 0
}

//export BoxVersion
func BoxVersion() *C.char {
	info := "HarmonyProxy libbox 1.0.0 | Go " + runtime.Version() + " | " + runtime.GOOS + "/" + runtime.GOARCH + " CPUs=" + strconv.Itoa(runtime.NumCPU())
	return C.CString(info)
}

//export BoxGetLastError
func BoxGetLastError() *C.char {
	return C.CString(lastError)
}

// required for c-shared build
func main() {}
