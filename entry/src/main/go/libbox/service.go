package main

import (
	"context"
	"fmt"
	"os"

	box "github.com/sagernet/sing-box"
	"github.com/sagernet/sing-box/include"
	"github.com/sagernet/sing-box/option"
	"github.com/sagernet/sing/common/json"
)

var (
	instance *box.Box
	ctx      context.Context
	cancel   context.CancelFunc
)

func StartService(config string) error {
	fmt.Fprintf(os.Stderr, "[Go] StartService: building registry context...\n")

	baseCtx := box.Context(
		context.Background(),
		include.InboundRegistry(),
		include.OutboundRegistry(),
		include.EndpointRegistry(),
	)

	fmt.Fprintf(os.Stderr, "[Go] StartService: parsing config JSON...\n")
	options, err := json.UnmarshalExtendedContext[option.Options](baseCtx, []byte(config))
	if err != nil {
		return fmt.Errorf("config parse: %w", err)
	}

	fmt.Fprintf(os.Stderr, "[Go] StartService: config parsed OK, creating box instance...\n")
	ctx, cancel = context.WithCancel(baseCtx)

	instance, err = box.New(box.Options{
		Context: ctx,
		Options: options,
	})
	if err != nil {
		cancel()
		return fmt.Errorf("box.New: %w", err)
	}

	fmt.Fprintf(os.Stderr, "[Go] StartService: box created, starting...\n")
	err = instance.Start()
	if err != nil {
		cancel()
		return fmt.Errorf("box.Start: %w", err)
	}

	fmt.Fprintf(os.Stderr, "[Go] StartService: started OK\n")
	return nil
}

func StopService() {
	if instance != nil {
		instance.Close()
		instance = nil
	}
	if cancel != nil {
		cancel()
		cancel = nil
	}
	ctx = nil
}
