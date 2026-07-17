@Component
export struct DashboardPage {


  build(){

    Column(){

      Text("流量监控")
        .fontSize(26)
        .fontWeight(FontWeight.Bold)


      Text("连接数: 0")

        .margin({top:30})


    }

    .width("100%")
    .height("100%")
    .padding(20)

  }

}