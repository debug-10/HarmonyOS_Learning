import {UserProfile} from '../components/UserProfile'
import { UserInfo } from '../model/UserInfo'

@Entry
@Component
export struct UserList {
  @State userList: UserInfo[] = [
    {
      id: 1,
      name: '高松灯',
      age: 18,
      avatar: $r('app.media.deng'),
      email: "1111111@qq.com",
      active: true
    },
    {
      id: 2,
      name: '丰川祥子',
      age: 18,
      avatar: $r('app.media.saki'),
      email: "222222222222222@qq.com",
      active: false
    },
    {
      id: 3,
      name: '千早爱音',
      age: 18,
      avatar: $r('app.media.ai'),
      email: "3333333@qq.com",
      active: true
    }
  ]

  build() {
    Column() {
      List({ space: 20 }) {
        ForEach(this.userList, (user: UserInfo) => {
          ListItem() {
            UserProfile({ userInfo: user })
          }
        })
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Fade)
    }
  }
}
