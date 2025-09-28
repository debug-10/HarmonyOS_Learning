import router from '@ohos.router';

// 1. 关键修复：接口必须声明在@Component外部（@Entry组件内禁止嵌套类型声明）
interface Product {
  id: number;
  name: string;
  imageResName: string; // 存储图片资源名（字符串，支持路由序列化）
  price: string;
}

@Entry
@Component
struct ProductList {
  // 2. 关键修复：用“资源名”替代直接存储Resource（Resource不可路由传递）
  private products: Product[] = [
    {
      id: 1,
      name: "鸿蒙手机",
      imageResName: "saki", // 仅存media文件夹中的图片名（如saki.png/saki.jpg）
      price: "￥3999"
    },
    {
      id: 2,
      name: "智慧手表",
      imageResName: "saki",
      price: "￥1999"
    },
    {
      id: 3,
      name: "平板电脑",
      imageResName: "saki",
      price: "￥2999"
    }
  ];

  // 3. 关键修复：build方法显式声明返回类型为void（符合ArkTS强类型规范）
  build(): void {
    Column() {
      // 标题组件
      Text("商品列表")
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 });

      // 商品列表
      List() {
        ForEach(
          this.products,
          (item: Product) => { // 遍历商品数据
            ListItem() {
              Row({ space: 12 }) { // 商品项：图片+信息+按钮
                // 4. 关键修复：通过资源名动态构造Resource（$r(`app.media.${资源名}`)）
                Image($r(`app.media.${item.imageResName}`))
                  .width(80)
                  .height(80)
                  .borderRadius(12)
                  .sharedTransition(`prod_${item.id}`, { duration: 400 }); // 保留共享转场

                // 商品名称+价格
                Column({ space: 6 }) {
                  Text(item.name)
                    .fontSize(20)
                    .fontWeight(FontWeight.Medium);
                  Text(item.price)
                    .fontSize(16)
                    .fontColor(Color.Gray);
                }

                Blank(); // 占位，将按钮推到右侧

                // 详情按钮（跳转逻辑修复）
                Button("详情")
                  .width(80)
                  .height(36)
                  .fontSize(14)
                  .backgroundColor("#3182CE")
                  .fontColor(Color.White)
                  .borderRadius(8)
                  .onClick(() => {
                    // 5. 关键修复：路由传递“资源名”（字符串），而非Resource
                    router.pushUrl({
                      url: "pages/ProductDetail", // 确保该页面路径在main_pages.json中注册
                      params: {
                        id: item.id,
                        name: item.name,
                        imageResName: item.imageResName, // 传递资源名（可序列化）
                        price: item.price
                      }
                    });
                  });
              }
              .padding(12)
              .width("100%")
              // 列表项下划线（优化视觉）
              // .border({ bottom: { width: 1, color: "#F5F5F5" } });
            }
          },
          (item: Product) => item.id.toString() // 列表项唯一键（避免渲染异常）
        );
      }
      .listDirection(Axis.Vertical) // 垂直列表（默认，显式声明更清晰）
      .width("100%");

    }
    .padding(20)
    .height("100%")
    .width("100%")
    .backgroundColor("#F5F7FA"); // 淡灰背景（比纯白更护眼）
  }

  // 6. 关键修复：pageTransition方法显式声明返回类型为void
  pageTransition(): void {
    PageTransitionEnter({ duration: 300 })
      .slide(SlideEffect.Left); // 进入页面：从左侧滑入
    PageTransitionExit({ duration: 300 })
      .slide(SlideEffect.Left); // 退出页面：向左侧滑出
  }
}