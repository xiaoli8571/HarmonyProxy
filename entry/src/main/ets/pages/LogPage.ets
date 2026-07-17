@Component
export struct LogPage {


  build(){

    Column(){

      Text("运行日志")
        .fontSize(26)
        .fontWeight(FontWeight.Bold)


      Text("暂无日志")

        .margin({top:30})

    }

    .width("100%")
    .height("100%")
    .padding(20)

  }

}