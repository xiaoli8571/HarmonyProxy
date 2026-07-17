@Component
export struct SubscriptionPage {


  build(){

    Column(){

      Text("订阅管理")
        .fontSize(26)
        .fontWeight(FontWeight.Bold)


      Text("暂无订阅")

        .margin({top:30})

    }

    .width("100%")
    .height("100%")

    .padding(20)

  }

}