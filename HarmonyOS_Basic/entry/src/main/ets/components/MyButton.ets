@Component
@Preview
export struct  MyButton {
  @Prop buttonName: string = "确认"
  @Prop buttonColor: string = "#ff1fb714"

  build() {
    Row({space: 10}) {

      Button(this.buttonName)
        .type(ButtonType.Normal)
        .backgroundColor(this.buttonColor)
        .onClick(() => {
          if (this.buttonColor === '#ff1fb714') {
          this.buttonColor = '#ffcb1010';
          } else {
            this.buttonColor = '#ff1fb714';
          }
        })

      // Button('主要按钮')
      //   .type(ButtonType.Normal)
      //   .backgroundColor('#ff1fb714')
      //
      // Button('次要按钮')
      //   .type(ButtonType.Normal)
      //   .backgroundColor('#ffe9cb10')
      //
      //
      // Button('危险按钮')
      //   .type(ButtonType.Normal)
      //   .backgroundColor('#ffcb1010')
    }
  }
}