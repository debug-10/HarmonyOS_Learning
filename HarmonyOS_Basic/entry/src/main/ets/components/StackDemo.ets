
@Component
@Preview
export struct StackDemo {
  @Prop avatarUrl: string = 'https://guke-bucket.oss-cn-nanjing.aliyuncs.com/images/yz.jpg'
  @Prop username: string = '有珠'
  @State hasNewMsg: boolean = true //是否有消息

  build() {
    Stack() {
      Stack({ alignContent: Alignment.TopEnd }) {
        // 底层：头像
        Image(this.avatarUrl || $r('app.media.saki'))
          .width(60)
          .height(60)
          .borderRadius(30)
          .border({
            width: 2,
            color: Color.Red
          })

        // 消息徽章背景，红色圆，定位到左上角
        if(this.hasNewMsg) {
          Circle({width: 18, height: 18})
            .fill(Color.Red)
            .position({ x:50 ,y:0 })
          Text('8')
            .fontSize(10)
            .fontColor(Color.White)
            .position({ x:55, y:4 }) //文字居中
        }

        //学生姓名
        Text(this.username)
          .fontSize(14)
          .fontColor(Color.Black)
          .position({ x:80, y:65 })
          .width(60)
          .textAlign(TextAlign.Center)
      }
    }
    .width(80)
    .height(90)
  }
}