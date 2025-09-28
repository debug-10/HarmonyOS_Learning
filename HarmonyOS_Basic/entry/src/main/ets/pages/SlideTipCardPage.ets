@Entry
@Component
struct SlideTipCardPage {
  @State isExpanded: boolean = false
  @State tasks: string[] = ['完成作业', '阅读书籍', '运动锻炼']

  build() {
    Navigation() {
      Column() {
        Text('动画练习3：滑动提示卡片')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 20, bottom: 20 })

        Column() {}
        .width('100%')
        .layoutWeight(1) // 使用权重分配空间
        .justifyContent(FlexAlign.Center)

        Column({ space: 12 }) {
          Row() {
            Text('今日待办')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .padding(16)

          // 任务列表
          if (this.isExpanded) {
            Column({ space: 8 }) {
              ForEach(this.tasks, (task: string, index: number) => {
                Row() {
                  Text(`${index + 1}. ${task}`)
                    .fontSize(16)
                    .fontColor(Color.White)
                }
                .width('100%')
                .padding(12)
                .backgroundColor('#4CAF50')
                .borderRadius(8)
              })
            }
            .width('100%')
            .padding({ left: 16, right: 16, bottom: 16 })
          }
        }
        .width('90%')
        .backgroundColor('#F5F5F5')
        .borderRadius(16)
        .shadow({ radius: 8, color: '#40000000', offsetX: 0, offsetY: 2 })
        .margin({
          bottom: 20
        })
        .translate({
          y: this.isExpanded ? -200 : 0 // 使用translate控制上下移动
        })
        .animation({
          duration: 800,
          curve: Curve.EaseInOut
        })
        .onClick(() => {
          this.isExpanded = !this.isExpanded
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
    }
    .title('滑动提示卡片')
    .titleMode(NavigationTitleMode.Mini)
  }
}