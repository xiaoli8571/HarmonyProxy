package api

import (
	"harmonyproxy/engine"
)

func StartProxy() {
	engine.Start()
}

func StopProxy() {
	engine.Stop()
}

func Status() bool {
	return engine.Status()
}
