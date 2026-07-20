import { StatusCard } from '../components/StatusCard'
import { TrafficCard } from '../components/TrafficCard'
import { BottomTab } from '../components/BottomTab'
import { appStore } from '../store/AppStore'


@Entry
@Component
struct Index {

  @State running: boolean = false
  @State uploadSpeed: number = 0
  @State downloadSpeed: number = 0

  aboutToAppear() {
    this.running = appStore.syncStatus()
    this.uploadSpeed = appStore.state.uploadSpeed
    this.downloadSpeed = appStore.state.downloadSpeed
  }

  private showMessage(message: string) {
    try {
      this.getUIContext().getPromptAction().showToast({ message: message })
    } catch (e) {
      console.error('HarmonyProxy: showToast failed', JSON.stringify(e))
    }
  }

  private toggleProxy() {

    if (this.running) {
      const stopped = appStore.stop()
      if (stopped) {
        this.running = false
        this.showMessage('代理已停止')
      } else {
        this.showMessage('停止失败，请查看日志')
      }
      return
    }

    const started = appStore.start()
    if (started) {
      this.running = true
      this.showMessage('代理已启动')
    } else {
      this.running = false
      this.showMessage('启动失败，请确认 libbox.so 已编译')
    }
  }

  build() {

    Column() {

      Text("HarmonyProxy")
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 40 })

      StatusCard({
        running: this.running
      })

      TrafficCard({
        upload: this.uploadSpeed,
        download: this.downloadSpeed
      })

      Button(
        this.running ?
          "停止代理" :
          "启动代理"
      )
        .margin({ top: 30 })
        .onClick(() => {
          this.toggleProxy()
        })

      Blank()

      BottomTab()
    }
    .width("100%")
    .height("100%")
  }
}
