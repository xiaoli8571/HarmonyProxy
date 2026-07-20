import { ProxyState } from '../models/ProxyState'
import { NativeProxy } from '../services/NativeProxy'
import { DEFAULT_SINGBOX_CONFIG } from '../common/Constants'


@Observed
export class AppStore {

  private static instance: AppStore

  state: ProxyState = new ProxyState()

  private constructor() {}

  static getInstance(): AppStore {

    if (AppStore.instance === undefined || AppStore.instance === null) {
      AppStore.instance = new AppStore()
    }

    return AppStore.instance
  }

  syncStatus(): boolean {

    try {
      const running = NativeProxy.status()
      this.state.running = running
      this.state.connected = running
      return running
    } catch (e) {
      console.error('HarmonyProxy: syncStatus failed', JSON.stringify(e))
      this.state.running = false
      this.state.connected = false
      return false
    }
  }

  start(config: string = DEFAULT_SINGBOX_CONFIG): boolean {

    console.info('HarmonyProxy: AppStore.start called')

    try {
      const result = NativeProxy.start(config)
      this.state.running = result
      this.state.connected = result
      return result
    } catch (e) {
      console.error('HarmonyProxy: AppStore.start failed', JSON.stringify(e))
      this.state.running = false
      this.state.connected = false
      return false
    }
  }

  stop(): boolean {

    console.info('HarmonyProxy: AppStore.stop called')

    try {
      const result = NativeProxy.stop()
      if (result) {
        this.state.running = false
        this.state.connected = false
      }
      return result
    } catch (e) {
      console.error('HarmonyProxy: AppStore.stop failed', JSON.stringify(e))
      return false
    }
  }
}

export const appStore =
  AppStore.getInstance()
