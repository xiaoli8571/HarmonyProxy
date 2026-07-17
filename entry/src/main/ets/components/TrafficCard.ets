@Component
export struct TrafficCard {


  @Prop upload:number = 0

  @Prop download:number = 0


  build(){

    Row(){

      Column(){

        Text("↑ 上传")
        Text(
          `${this.upload} KB/s`
        )

      }


      Column(){

        Text("↓ 下载")

        Text(
          `${this.download} KB/s`
        )

      }

    }
    .justifyContent(
      FlexAlign.SpaceAround
    )
    .width("90%")
    .padding(20)
    .backgroundColor("#FFFFFF")
    .borderRadius(16)

  }

}