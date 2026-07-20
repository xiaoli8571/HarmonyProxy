export interface NativeProxyModule {
  start(config: string): boolean;
  stop(): boolean;
  status(): boolean;
}

declare const proxyModule: NativeProxyModule;

export default proxyModule;
