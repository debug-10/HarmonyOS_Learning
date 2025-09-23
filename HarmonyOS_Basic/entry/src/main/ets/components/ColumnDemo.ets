@Component
@Preview
export struct ColumnDemo {
  build() {
    Column({ space: 8 }){
      //1.文本签到
      Text('签到提醒')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)


      //2.文本框，提醒
      Text('上课前扫码签到')
        .fontSize($r('app.string.Font_size_media'))
        .fontWeight('#666')
        .maxLines(2)
          //布局权重
        .layoutWeight(1)


      //3.按钮
      Button('提醒')
        .margin({top:12})
        .onClick(() => {
          console.log('允许签到')
        })
    }
    .padding(10)
    .width('100%')
    .height(300)
    .backgroundColor('#ff5d91bf')
    .borderRadius(12)
    .shadow({radius: 8, color: '#f00'})
  }
}