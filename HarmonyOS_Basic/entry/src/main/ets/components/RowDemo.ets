@Component
@Preview
export struct RowDemo {
  build() {
    Row({ space: 8 }){
      //1.图片 24*24
      Image($r('app.media.saki'))
        .width(24)
        .height(24)


      //2.文本框，占据剩余空间
      Text('鸿蒙开发')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        //布局权重
        .layoutWeight(1)


      //3.按钮
      Button('详情')
        .type(ButtonType.Capsule)
        .width(80)
        .height(20)
    }.padding({left: 20 , right: 20 })
    .width('100%')
    .height(60)
    .borderRadius(12)
    .backgroundColor('#ff5d91bf')
  }
}