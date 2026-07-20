import { NativeProxy } from './NativeProxy'
import { DEFAULT_SINGBOX_CONFIG } from '../common/Constants'


export class ProxyService {

  static start(config: string = DEFAULT_SINGBOX_CONFIG): boolean {
    return NativeProxy.start(config)
  }

  static stop(): boolean {
    return NativeProxy.stop()
  }

  static status(): boolean {
    return NativeProxy.status()
  }
}
