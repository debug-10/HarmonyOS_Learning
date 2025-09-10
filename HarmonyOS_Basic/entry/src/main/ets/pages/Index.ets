import {MyButton} from '../components/MyButton'
import {Card} from '../components/Card'
import {UserProfile} from '../components/UserProfile'
import {UserList} from '../components/UserList'
import { UserCard } from  '../components/UserCard'
// 导入路由模块
import router from '@ohos.router'
import { StateExample } from '../components/StateExample'
import { DataWatchExample } from '../components/DataWatchExample'
import { BestPracticesExample } from '../components/BestPracticesExample'
// import { PerformanceOptimizedComponent } from '../components/PerformanceOptimizedComponent'

@Entry
@Component
struct Index {
  @Prop isOnline: boolean = true

  // 定义页面跳转方法
  private navigateToPage(url: string, pageName: string) {
    router.pushUrl({
      url: url,
      params: { pageTitle: pageName }
    })
  }

  build() {
    Column({space : 20}){

      Button() {
        Text('进入商品页面')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
      }
      .type(ButtonType.Capsule)
      .backgroundColor('#3182CE')
      .width('75%')
      .height(58)
      .shadow({
        radius: 8,
        color: '#3182CE25',
        offsetX: 0,
        offsetY: 4
      })
      .onClick(() => {
        this.navigateToPage('pages/ProductListPage', '商品页面');
      });

      Button() {
        Text('进入设置页面')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
      }
      .type(ButtonType.Capsule)
      .backgroundColor('#3182CE')
      .width('75%')
      .height(58)
      .shadow({
        radius: 8,
        color: '#3182CE25',
        offsetX: 0,
        offsetY: 4
      })
      .onClick(() => {
        this.navigateToPage('pages/SettingsPage', '商品页面');
      });


      // Card()
      // MyButton()
      // UserProfile()
      // UserList()
      // UserCard()
      // StateExample()
      // DataWatchExample()
      // BestPracticesExample()
      // PerformanceOptimizedComponent()

    }
  }
}
