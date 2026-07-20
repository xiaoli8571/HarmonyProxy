package main

import (
	"context"

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

	baseCtx := box.Context(
		context.Background(),
		include.InboundRegistry(),
		include.OutboundRegistry(),
		include.EndpointRegistry(),
	)

	options, err := json.UnmarshalExtendedContext[option.Options](baseCtx, []byte(config))
	if err != nil {
		return err
	}

	ctx, cancel = context.WithCancel(baseCtx)

	instance, err = box.New(box.Options{
		Context: ctx,
		Options: options,
	})
	if err != nil {
		cancel()
		cancel = nil
		ctx = nil
		return err
	}

	return instance.Start()
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
