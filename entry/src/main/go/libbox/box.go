package main

/*
#include <stdlib.h>
*/
import "C"

import (
	"sync"
)

var (
	running bool
	mutex   sync.Mutex
)


//export BoxStart
func BoxStart(config *C.char) int {

	mutex.Lock()
	defer mutex.Unlock()

	if running {
		return 0
	}


	if config == nil {
		return -1
	}


	jsonConfig := C.GoString(config)


	err := StartService(jsonConfig)

	if err != nil {
		return -1
	}


	running = true


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

	version := C.CString(
		"HarmonyProxy libbox 1.0.0",
	)

	return version
}


// required for c-shared build
func main() {

}