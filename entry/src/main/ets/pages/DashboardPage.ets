import { NativeProxy } from '../services/NativeProxy'
import { AppStore } from '../store/AppStore'


@Component
export struct DashboardPage {


  private store: AppStore = AppStore.getInstance()


  @State running: boolean = false

  @State statusText: string = '未启动'


  @State upload: string = '0 KB'

  @State download: string = '0 KB'



  /**
   * sing-box 测试配置
   *
   * 后续替换成订阅生成配置
   */
  private singBoxConfig: string = `{
    "log": {
      "level": "info"
    },

    "inbounds": [],

    "outbounds": [
      {
        "type": "direct",
        "tag": "direct"
      }
    ]
  }`



  aboutToAppear(){

    this.refreshStatus()

  }



  /**
   * 查询核心状态
   */
  refreshStatus(){

    try {

      this.running =
        NativeProxy.status()


      if(this.running){

        this.statusText = '运行中'

      }else{

        this.statusText = '已停止'

      }


    }catch(e){

      this.statusText='异常'

    }

  }




  /**
   * 启动 libbox
   */
  startProxy(){

    console.info(
      "HarmonyProxy: start button clicked"
    )


    let result =
      NativeProxy.start(
        this.singBoxConfig
      )


    console.info(
      "HarmonyProxy: NativeProxy result="
        + result
    )


    this.running = result


    if(result){

      this.statusText = "运行中"

    }else{

      this.statusText = "启动失败"

    }

  }




  /**
   * 停止 libbox
   */
  stopProxy(){


    let result =
      NativeProxy.stop()



    if(result){

      this.running=false

      this.statusText='已停止'


    }


  }




  build(){


    Column(){

      // 顶部标题

      Text('HarmonyProxy')

        .fontSize(28)

        .fontWeight(FontWeight.Bold)

        .margin({
          top:30,
          bottom:20
        })




      // 状态卡片

      Column(){


        Text('代理状态')

          .fontSize(18)



        Text(
          this.statusText
        )

          .fontSize(32)

          .margin({
            top:15
          })


        if(this.running){


          Text('sing-box core running')

            .fontSize(14)

            .margin({
              top:10
            })


        }



      }


      .width('90%')

      .padding(25)

      .borderRadius(16)

      .backgroundColor('#F5F5F5')





      // 控制按钮


      Row(){


        Button('启动代理')

          .width(130)

          .onClick(()=>{

            this.startProxy()

          })




        Button('停止代理')

          .width(130)

          .margin({
            left:20
          })

          .onClick(()=>{

            this.stopProxy()

          })


      }


      .margin({
        top:30
      })





      // 流量信息


      Column(){


        Text('流量统计')

          .fontSize(18)



        Row(){


          Column(){


            Text('上传')

            Text(
              this.upload
            )
              .fontSize(22)


          }



          .margin({
            right:60
          })



          Column(){


            Text('下载')


            Text(
              this.download
            )

              .fontSize(22)


          }


        }


        .margin({
          top:20
        })


      }


      .width('90%')

      .margin({
        top:30
      })

      .padding(20)

      .borderRadius(16)

      .backgroundColor('#F5F5F5')





      // 刷新按钮


      Button('刷新状态')

        .margin({
          top:30
        })


        .onClick(()=>{


          this.refreshStatus()


        })



    }


    .width('100%')


    .height('100%')


    .justifyContent(
      FlexAlign.Start
    )


  }

}