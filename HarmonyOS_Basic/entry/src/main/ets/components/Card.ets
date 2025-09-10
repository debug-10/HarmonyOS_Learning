@Component
@Preview
export struct Card {
  @Prop name: string = "gk"
  @Prop avatar: string = "https://guke-bucket.oss-cn-nanjing.aliyuncs.com/images/yz.jpg"

  build() {
    Column() {
      // Text("个人信息卡片")
      //   .fontSize(20)
      //   .fontWeight(FontWeight.Bold)
      Image(this.avatar)
        .width(100)
        .height(100)
        .borderRadius(50)
      Text("我的姓名: " + this.name)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
    }
    .padding(20)
    .backgroundColor('#ffffff')
    .borderRadius(10)
    .shadow({ radius: 10, color: '#000000' })
    .width('100%')
  }
}
