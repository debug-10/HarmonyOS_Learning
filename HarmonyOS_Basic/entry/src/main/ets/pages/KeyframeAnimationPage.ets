@Entry
@Component
struct KeyframeAnimationPage {
  @State offsetY: number = 200 // 初始位置：地平线下（0%状态）
  @State _opacity: number = 0.5 // 初始半透明
  @State _scale: number = 0.8 // 初始稍小
  @State _fillColor: string = '#FFEB3B' // 初始黄色（地平线下）

  build(): void { // 显式声明build方法返回类型为void
    Navigation() {
      Column({ space: 20 }) {
        // 太阳圆形：颜色+位置+大小+透明度动画
        Circle({ width: 100, height: 100 })
          .fill(this._fillColor)
          .translate({ x: 0, y: this.offsetY })
          .scale({ x: this._scale, y: this._scale })
          .opacity(this._opacity)
          .animation({ duration: 1000, curve: Curve.EaseInOut })

        Button('播放太阳升起动画')
          .width(200)
          .height(50)
          .backgroundColor('#2196F3')
          .fontSize(14)
          .onClick(() => this.playSunAnimation())
      }
      .padding(16)
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F7FA') // 淡蓝色背景模拟天空
    }
    .title('关键帧动画-太阳升起')
    .titleMode(NavigationTitleMode.Mini)
    .hideBackButton(false)
    .navBarPosition(NavBarPosition.Start)
  }

  /**
   * 完整太阳升起动画：4个关键帧过渡
   * 显式声明返回类型为void（无返回值）
   */
  private playSunAnimation(): void {
    // 重置初始状态
    this.resetInitialState();

    // 关键帧1：25%（太阳刚露头，晨光初现）- 1000ms后触发
    setTimeout(() => {
      this.offsetY = 100;
      this._scale = 1.0;
      this._opacity = 0.8;
      this._fillColor = '#FFC107'; // 淡黄→亮黄
    }, 1000);

    // 关键帧2：50%（太阳升中天，晨光增强）- 2000ms后触发
    setTimeout(() => {
      this.offsetY = 30;
      this._scale = 1.1;
      this._opacity = 0.9;
      this._fillColor = '#FF9800'; // 亮黄→橙黄
    }, 2000);

    // 关键帧3：75%（太阳到正午，强光直射）- 3000ms后触发
    setTimeout(() => {
      this.offsetY = -50;
      this._scale = 1.2;
      this._opacity = 1.0;
      this._fillColor = '#FF5722'; // 橙黄→橙红
    }, 3000);

    // 关键帧4：100%（太阳西落，逐渐淡出）- 4200ms后触发
    setTimeout(() => {
      this.offsetY = -120;
      this._scale = 1.0;
      this._opacity = 0;
      this._fillColor = '#FFEB3B'; // 恢复初始黄色
    }, 4200);
  }

  /**
   * 重置太阳初始状态（地平线下）
   * 显式声明返回类型为void（无返回值）
   */
  private resetInitialState(): void {
    this.offsetY = 200;
    this._scale = 0.8;
    this._opacity = 0.5;
    this._fillColor = '#FFEB3B';
  }
}