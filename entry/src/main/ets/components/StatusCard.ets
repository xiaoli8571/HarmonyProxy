@Component
export struct StatusCard {

  @Prop running:boolean = false

  build(){

    Column(){

      Text("代理状态")
        .fontSize(18)
        .fontWeight(FontWeight.Bold)


      Text(
        this.running ?
          "● 已启动" :
          "● 未连接"
      )
        .fontSize(16)
        .margin({top:10})

    }
    .width("90%")
    .padding(20)
    .backgroundColor("#FFFFFF")
    .borderRadius(16)

  }
}