@Component
export struct SettingsPage {


  build(){

    Column(){

      Text("设置")
        .fontSize(26)
        .fontWeight(FontWeight.Bold)


      Text("核心版本\n0.1.0-alpha.1")

        .margin({top:30})

    }

    .width("100%")
    .height("100%")
    .padding(20)

  }

}