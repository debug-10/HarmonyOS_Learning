/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// 导入常量配置
import { STYLE_CONFIG, Constant } from '../common/Constants';
// 导入数据模型
import { ToDo } from '../model/ToDo';

/**
 * 待办事项列表项组件
 *
 * 这是一个功能完整的列表项组件，包含以下特性：
 * 1. 自定义复选框，支持完成状态切换
 * 2. 在线编辑功能，可直接修改任务名称
 * 3. 状态相关的视觉效果（删除线、透明度等）
 * 4. 平滑的动画过渡效果
 * 5. 响应式布局，适配不同屏幕尺寸
 *
 * 组件使用了多种状态管理装饰器：
 * - @Link: 与父组件双向绑定的数组数据
 * - @ObjectLink: 监听对象属性变化
 * - @State: 组件内部状态管理
 */
@Component
export struct ToDoListItem {
  /**
   * UI上下文对象
   * 用于获取界面相关的API，如动画、对话框等
   */
  UIContext = this.getUIContext();

  /**
   * 已完成任务数组的引用
   * 使用@Link装饰器与父组件双向绑定
   * 当这个数组发生变化时，父组件也会同步更新
   */
  @Link achieveData: ToDo[];

  /**
   * 未完成任务数组的引用
   * 使用@Link装饰器与父组件双向绑定
   */
  @Link toDoData: ToDo[];

  /**
   * 当前任务对象的引用
   * 使用@ObjectLink装饰器监听对象属性变化
   * 当ToDo对象的任何属性发生变化时，UI会自动更新
   */
  @ObjectLink toDoItem: ToDo;

  /**
   * 编辑状态标识
   * 控制组件是否处于编辑模式
   * false: 显示模式，只能查看和切换完成状态
   * true: 编辑模式，可以修改任务名称
   */
  @State isEdited: boolean = false;

  /**
   * 添加/移除已完成任务的方法
   *
   * 这个方法负责处理任务状态的切换逻辑：
   * 1. 切换任务的完成状态
   * 2. 使用动画效果在不同列表间移动任务
   * 3. 更新父组件的数据数组
   *
   * 动画实现：
   * - 使用UIContext.animateTo创建平滑过渡效果
   * - 动画持续时间由STYLE_CONFIG.ANIMATION_DURATION控制
   * - 在动画回调中执行数据操作，确保视觉效果连贯
   */
  addAchieveData() {
    // 第一步：切换任务的完成状态
    this.toDoItem.isCompleted = !this.toDoItem.isCompleted;

    // 第二步：使用动画效果执行数据迁移
    this.UIContext.animateTo({
      duration: STYLE_CONFIG.ANIMATION_DURATION,  // 动画持续时间
      curve: Curve.EaseInOut,                     // 动画曲线
      iterations: 1,                              // 动画次数
      playMode: PlayMode.Normal                   // 播放模式
    }, () => {
      // 动画回调函数：在动画执行期间进行数据操作

      if (this.toDoItem.isCompleted) {
        // 任务标记为完成：从未完成列表移动到已完成列表

        // 从未完成列表中过滤掉当前任务
        let tempData = this.toDoData.filter(item => item.key !== this.toDoItem.key);
        this.toDoData = tempData;

        // 将当前任务添加到已完成列表的末尾
        this.achieveData.push(this.toDoItem);

      } else {
        // 任务取消完成：从已完成列表移动回未完成列表

        // 从已完成列表中过滤掉当前任务
        let tempData = this.achieveData.filter(item => item.key !== this.toDoItem.key);
        this.achieveData = tempData;

        // 将当前任务重新添加到未完成列表的末尾
        this.toDoData.push(this.toDoItem);
      }
    });
  }

  /**
   * 组件构建方法
   * 定义了组件的UI结构和布局
   */
  build() {
    // 使用Flex布局作为根容器
    Flex({
      justifyContent: FlexAlign.SpaceBetween,  // 主轴两端对齐
      alignItems: ItemAlign.Center             // 交叉轴居中对齐
    }) {
      // 主要内容区域：水平排列的复选框、文本和编辑按钮
      Row({ space: STYLE_CONFIG.ICON_GUTTER }) {

        // 条件渲染：根据编辑状态显示不同内容
        if (!this.isEdited) {
          // 显示模式的内容

          // 自定义复选框容器
          Row() {
            // 条件渲染：根据完成状态显示对勾图标
            if (this.toDoItem.isCompleted) {
              Image($r('app.media.ic_public_ok_filled'))
                .width(STYLE_CONFIG.IMAGE_ICON_OK_SIZE)    // 图标宽度
                .aspectRatio(1)                            // 保持1:1宽高比
                .borderRadius(STYLE_CONFIG.IMAGE_ICON_OK_SIZE) // 圆形图标
                .fillColor(Color.White)                    // 图标颜色为白色
                .transition(TransitionEffect.IDENTITY)     // 过渡效果
            }
            // 注意：未完成状态下不显示任何图标，只显示空的圆形边框
          }
          .width(STYLE_CONFIG.CUSTOM_CHECKBOX_SIZE)        // 复选框容器宽度
          .justifyContent(FlexAlign.Center)                // 内容居中
          .aspectRatio(1)                                  // 保持1:1宽高比（圆形）
          .borderRadius(STYLE_CONFIG.CUSTOM_CHECKBOX_SIZE) // 圆形边框
          // 动态背景色：完成状态下显示系统主题色，未完成状态下透明
          .backgroundColor(this.toDoItem.isCompleted ?
            $r('sys.color.ohos_id_color_floating_button_bg_normal') :
            Color.Transparent)
          .borderWidth(1)                                  // 边框宽度
          .borderColor($r('sys.color.ohos_id_color_focused_content_tertiary')) // 边框颜色
          .onClick(() => {
            // 点击复选框切换完成状态
            this.addAchieveData();
          })

          // 任务名称文本显示
          Text(`${this.toDoItem.name}`)
            .maxLines(1)                                   // 最大显示行数
            .fontSize($r('sys.float.ohos_id_text_size_headline9')) // 系统标准字体大小
            .layoutWeight(1)                               // 占用剩余空间
            // 动态文本装饰：完成状态下添加删除线
            .decoration({
              type: this.toDoItem.isCompleted ?
                TextDecorationType.LineThrough :
                TextDecorationType.None
            })
            .fontColor(this.toDoItem.isCompleted ?
              $r('sys.color.ohos_id_color_text_secondary') :
              $r('sys.color.ohos_id_color_text_primary'))  // 动态文字颜色

        } else {
          // 编辑模式的内容

          // 文本输入框，用于编辑任务名称
          TextInput({
            text: `${this.toDoItem.name}`,                 // 初始文本内容
            placeholder: '请输入任务名称'                   // 占位符文本
          })
            .maxLines(1)                                   // 最大行数
            .fontSize($r('sys.float.ohos_id_text_size_headline9')) // 字体大小与显示模式保持一致
            .layoutWeight(1)                               // 占用剩余空间
            .backgroundColor(Color.Transparent)           // 透明背景
            .borderWidth(0)                                // 无边框
            .id('textEdit')                                // 设置组件ID，用于焦点控制
            .onChange((value: string) => {
              // 输入内容变化时的回调
              // 实时更新ToDo对象的name属性
              this.toDoItem.name = value;

              // 可以在这里添加输入验证逻辑
              if (value.length > 50) {
                // 如果输入超过50个字符，可以截断或提示
                console.warn('任务名称过长，建议控制在50字符以内');
              }
            })
            .onAppear(() => {
              // 组件出现时的回调
              // 自动请求输入焦点，方便用户立即编辑
              focusControl.requestFocus('textEdit');
            })
            .onBlur(() => {
              // 失去焦点时自动退出编辑模式
              this.isEdited = false;
            })
        }

        // 空白填充区域，将编辑按钮推到右侧
        Blank()

        // 条件渲染：编辑状态下显示确认按钮，否则显示编辑按钮
        if (this.isEdited) {
          // 编辑模式：确认按钮
          Image($r('app.media.ic_public_ok_filled'))
            .width(STYLE_CONFIG.MENU_IMAGE_SIZE)           // 按钮图标尺寸
            .aspectRatio(1)                                // 保持1:1宽高比
            .fillColor($r('sys.color.ohos_id_color_primary')) // 主题色
            .onClick(() => {
              // 点击确认按钮，退出编辑模式
              this.isEdited = false;

              // 可以在这里添加保存逻辑
              console.info('任务编辑完成:', this.toDoItem.name);
            })

        } else {
          // 显示模式：编辑按钮
          Text($r('app.string.edit'))
            .fontColor($r('sys.color.ohos_id_color_text_secondary')) // 次要文本颜色
            .fontSize($r('sys.float.ohos_id_text_size_caption'))      // 较小字体
            .onClick(() => {
              // 点击编辑按钮，进入编辑模式
              this.isEdited = true;

              console.info('开始编辑任务:', this.toDoItem.name);
            })
        }
      }
      .width(Constant.PERCENT_FULL)                        // 行容器占满宽度
    }
    .width(Constant.PERCENT_FULL)                          // 主容器占满宽度
    .height(STYLE_CONFIG.TODO_ITEM_HEIGHT)                 // 固定高度
    .padding({
      left: $r('sys.float.ohos_id_default_padding_start'), // 系统标准左内边距
      right: $r('sys.float.ohos_id_default_padding_end'),  // 系统标准右内边距
      top: STYLE_CONFIG.TODO_ITEM_PADDING_VERTICAL,        // 垂直内边距
      bottom: STYLE_CONFIG.TODO_ITEM_PADDING_VERTICAL
    })
    .borderRadius($r('sys.float.ohos_id_corner_radius_default_m')) // 系统标准圆角
    .backgroundColor(Color.White)                          // 白色背景
    // 添加点击涟漪效果
    .stateStyles({
      pressed: {
        .backgroundColor($r('sys.color.ohos_id_color_click_effect')) // 按下时的背景色
      },
      normal: {
        .backgroundColor(Color.White)                      // 正常状态的背景色
      }
    })
  }
}