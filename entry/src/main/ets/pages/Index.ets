import { StatusCard } from '../components/StatusCard'
import { TrafficCard } from '../components/TrafficCard'
import { BottomTab } from '../components/BottomTab'
import { appStore } from '../store/AppStore'


@Entry
@Component
struct Index {


  build(){

    Column(){


      Text("HarmonyProxy")

        .fontSize(30)

        .fontWeight(FontWeight.Bold)

        .margin({top:40})


      StatusCard({

        running:
        appStore.state.running

      })


      TrafficCard({

        upload:
        appStore.state.uploadSpeed,

        download:
        appStore.state.downloadSpeed

      })


      Button(
        appStore.state.running
          ?
          "停止代理"
          :
          "启动代理"
      )

        .margin({top:30})

        .onClick(()=>{

          if(appStore.state.running){

            appStore.stop()

          }else{

            appStore.start()

          }

        })


      Blank()


      BottomTab()

    }

    .width("100%")

    .height("100%")

  }

}