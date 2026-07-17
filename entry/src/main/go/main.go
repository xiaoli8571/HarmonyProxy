package main

import (
	"fmt"
	"harmonyproxy/api"
)

func main() {

	api.StartProxy()

	fmt.Println(
		api.Status(),
	)

}
