package engine

import "sync"

var (
	running bool
	mutex   sync.Mutex
)

func Start() {
	mutex.Lock()
	defer mutex.Unlock()

	running = true
}

func Stop() {
	mutex.Lock()
	defer mutex.Unlock()

	running = false
}

func Status() bool {
	mutex.Lock()
	defer mutex.Unlock()

	return running
}
