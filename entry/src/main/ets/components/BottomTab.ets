@Component
export struct BottomTab {


  @State current:number = 0


  build(){

    Row(){

      this.item("首页",0)

      this.item("节点",1)

      this.item("订阅",2)

      this.item("日志",3)

      this.item("设置",4)

    }

    .width("100%")
    .height(60)
    .justifyContent(
      FlexAlign.SpaceAround
    )

  }



  @Builder
  item(
    text:string,
    index:number
  ){

    Text(text)
      .fontSize(14)
      .onClick(()=>{

        this.current=index

      })

  }

}