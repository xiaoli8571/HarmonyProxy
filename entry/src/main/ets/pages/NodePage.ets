@Entry
@Component
export struct NodePage {

  build(){

    Column(){

      Text("节点管理")
        .fontSize(26)
        .fontWeight(FontWeight.Bold)


      Text("暂无节点")
        .margin({top:30})
        .fontSize(18)

    }
    .width("100%")
    .height("100%")
    .padding(20)

  }

}