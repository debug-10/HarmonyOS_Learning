@Entry
@Component
struct ExplictAnimationPage {
  @State isMoved: boolean=false
  @State btnWidth: number = 120
  @State color: string = "#2196F3"
  @State rotateAngle: number = 0
  @State _scale: number = 1

  build() {
    Navigation() {
      Column({ space: 16 }){
        Text('显式动画演示')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)

        Button('改变位置').onClick(()=>{
          this.isMoved=!this.isMoved
        })

        Circle({width: 60,height: 60})
          .fill("#ff4fa9e3")
          .translate({x:this.isMoved?100:0,y:0})
          .animation({
            duration: 1000,
            curve: Curve.Smooth
          })

        Button('点击改变文字大小和背景色')
          .width(this.btnWidth)
          .height(50)
          .backgroundColor(this.color)
          .onClick(() => {
            this.btnWidth = this.btnWidth === 120 ? 200 : 120
            this.color = this.color === '#2196F3' ? '#FF5722' : '#2196F3'
          })
          .animation({
            duration: 600,
            curve: Curve.EaseInOut,
            iterations: 3,
            playMode: PlayMode.Normal
          })

        // 角度变化的按钮
        Button('角度变化')
          .onClick(() => {
            this.rotateAngle = 180
          })
          .margin(50)
          .rotate({ angle: this.rotateAngle })
          .animation({
            duration: 1200, // 动画时长
            curve: Curve.Friction, // 阻尼动画
            delay: 500, // 延迟500，毫秒
            iterations: -1, // 表示无限循环
            playMode: PlayMode.Alternate,// 循环播放
            expectedFrameRateRange: {
              min: 20, // 最小帧率
              max: 120, // 最大帧率
              expected: 90, // 帧率90
            }
          })

        Text('心跳动画示例')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .padding(10)
        Image($r('app.media.heart'))
          .width(100)
          .height(100)
          .scale({ x: this._scale, y: this._scale })
          .animation({
            duration: 1000,
            curve: Curve.Friction, // 阻尼动画，先快后慢，模拟摩擦减速
            delay: 500, // 动画延迟 500ms 开始
            iterations: -1, // 无限循环
            playMode: PlayMode.Alternate, // 交替播放：放大 → 缩小 → 放大...
            expectedFrameRateRange: {
              min: 20, // 最低帧率 20fps（保证低端设备不卡死）
              max: 120, // 最高帧率 120fps（支持高刷屏）
              expected: 120 // 期望运行在 9
            }
          })
          .onAppear(() => {
            setInterval(() => {
              this._scale = this._scale === 1 ? 1.3 : 1
            }, 1200)
          })


      }
      .padding(16)
    }
    .title('显示动画')
    .titleMode(NavigationTitleMode.Mini)
    .hideBackButton(false)
    .navBarWidth('100%')
    .navBarPosition(NavBarPosition.Start)
  }
}