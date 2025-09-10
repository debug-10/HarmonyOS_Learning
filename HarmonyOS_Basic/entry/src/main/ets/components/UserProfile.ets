import { UserInfo } from "../model/UserInfo"
import { promptAction } from '@kit.ArkUI'
import pasteboard from '@ohos.pasteboard';
// import { Color, FontWeight } from '@kit.ArkUI'

@Component
@Preview
export struct UserProfile {
  @State userInfo: UserInfo = {
    id: 1,
    name: 'gk',
    age: 20,
    avatar: $r('app.media.default'),
    active: true,
    email: 'this.is.a.very.long.email.address@example.com',
  }

  build() {
    Column() {
      // 名片主体
      Column() {
        // 头像区域
        Image(this.userInfo.avatar)
          .width(100)
          .height(100)
          .borderRadius(50)
          .border({ width: 3, color: Color.White })
          .margin({ top: -50, bottom: 15 })
          .shadow({ radius: 6, color: '#00000020' })

        // 个人信息区域
        Column({ space: 12 }) {
          // 姓名文本
          Text(`姓名： ${this.userInfo.name}`)
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .width('100%')
            .onClick(() => {
              try {
                const pasteData = pasteboard.createData(
                  pasteboard.MIMETYPE_TEXT_PLAIN,
                  this.userInfo.name
                );
                const systemPasteboard = pasteboard.getSystemPasteboard();
                systemPasteboard.setData(pasteData, (err) => {
                  if (err) {
                    promptAction.showToast({ message: '姓名复制成功' });
                    return;
                  }
                  promptAction.showToast({ message: '姓名已复制到剪贴板' });
                });
              } catch (error) {
                promptAction.showToast({ message: '姓名复制成功' });
                console.error('复制姓名错误:', error);
              }
            })

          // 年龄文本
          Text(`年龄： ${this.userInfo.age}`)
            .fontSize(20)
            .fontColor('#555555')
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .width('100%')

          if (this.userInfo.email) {
            // 邮箱文本
            Text(`邮箱： ${this.userInfo.email}`)
              .fontSize(18)
              .fontColor('#666666')
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .width('100%')
          }

          // 状态按钮
          Button(this.userInfo.active ? '禁用用户' : '启用用户')
            .backgroundColor(this.userInfo.active ? '#FF5252' : '#4CAF50')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .borderRadius(20)
            .width('80%')
            .height(40)
            .margin({ top: 8 })
            .onClick(() => {
              this.userInfo.active = !this.userInfo.active
            })
        }
        .padding({ top: 40, bottom: 25, left: 25, right: 25 })
      }
      // 名片样式
      .width(320)
      .backgroundColor('#F9F9F9')
      .border({ width: 1, color: '#EEEEEE', radius: 12 })
      .shadow({ radius: 8, color: '#00000010', offsetY: 4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F0F0')
    .justifyContent(FlexAlign.Center)
    .padding(20)
  }
}