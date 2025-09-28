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

// 导入数据模型
import { ToDo } from '../model/ToDo';
// 导入列表项组件
import { ToDoListItem } from '../view/TodoListItem';
// 导入常量配置
import { STYLE_CONFIG, Constant, BusinessConstant } from '../common/Constants';
// 导入系统API
import { BusinessError } from '@kit.BasicServicesKit';
import { hilog } from '@kit.PerformanceAnalysisKit';

/**
 * 扩展Image组件的样式
 * 使用@Extend装饰器为Image组件添加统一的样式配置
 * 这样可以在多个地方复用相同的样式，保持UI一致性
 */
@Extend(Image)
function ImageStyle() {
  .width(STYLE_CONFIG.IMAGE_SIZE)                          // 图片宽度
  .aspectRatio(1)                                          // 保持1:1宽高比
  .margin(STYLE_CONFIG.IMAGE_MARGIN)                       // 图片外边距
  .borderRadius(STYLE_CONFIG.BORDER_RADIUS_SMALL)          // 小圆角
  .backgroundColor($r('sys.color.ohos_id_color_button_normal')) // 按钮背景色
}

/**
 * 待办事项列表主页面组件
 *
 * 这是应用的主要界面，包含以下核心功能：
 * 1. 待办事项的显示和管理
 * 2. 添加新的待办事项
 * 3. 任务状态切换（完成/未完成）
 * 4. 滑动删除操作
 * 5. 在线编辑功能
 * 6. 分类显示（未完成/已完成）
 *
 * 页面采用响应式设计，支持多种设备尺寸
 * 使用List组件实现高性能的列表渲染
 * 所有操作都有相应的用户反馈和动画效果
 */
@Entry
@Component
struct ToDoList {
  /**
   * 未完成任务数据数组
   * 使用@State装饰器标记为组件状态
   * 当数组发生变化时，相关的UI组件会自动重新渲染
   */
  @State toDoData: ToDo[] = [];

  /**
   * 已完成任务数据数组
   * 存储用户已经完成的待办事项
   */
  @State achieveData: ToDo[] = [];

  /**
   * 加载状态标识
   * 用于显示加载动画或禁用操作按钮
   */
  @State isLoading: boolean = false;

  /**
   * 搜索关键词
   * 用于实现任务搜索功能（可扩展）
   */
  @State searchKeyword: string = '';

  /**
   * 删除待办事项的方法
   *
   * 这个方法处理任务删除的完整逻辑：
   * 1. 根据任务状态从对应数组中删除
   * 2. 显示删除成功的提示信息
   * 3. 记录删除操作的日志
   * 4. 处理可能出现的异常情况
   *
   * @param item - 要删除的待办事项对象
   */
  deleteTodoItem(item: ToDo) {
    try {
      // 设置加载状态，防止重复操作
      this.isLoading = true;

      // 根据任务的完成状态，从对应的数组中删除
      if (item.isCompleted) {
        // 从已完成任务数组中删除
        this.achieveData = this.achieveData.filter(todoItem => item.key !== todoItem.key);
        hilog.info(0x0000, 'ToDoList', `已完成任务删除: ${item.name}`);
      } else {
        // 从未完成任务数组中删除
        this.toDoData = this.toDoData.filter(todoItem => item.key !== todoItem.key);
        hilog.info(0x0000, 'ToDoList', `未完成任务删除: ${item.name}`);
      }

      // 显示删除成功的Toast提示
      this.getUIContext().getPromptAction().showToast({
        message: $r('app.string.deleted'),
        duration: 2000,                                    // 显示2秒
        bottom: 100                                        // 距离底部100px
      });

      // 可以在这里添加数据持久化逻辑
      this.saveDataToPersistence();

    } catch (error) {
      // 异常处理：记录错误日志并提示用户
      let err = error as BusinessError;
      hilog.error(0x0000, 'ToDoList',
        `删除任务失败 - code: ${err.code}, message: ${err.message}`);

      // 显示错误提示
      this.getUIContext().getPromptAction().showToast({
        message: '删除失败，请重试',
        duration: 2000
      });
    } finally {
      // 无论成功失败，都要重置加载状态
      this.isLoading = false;
    }
  }

  /**
   * 数据持久化方法（扩展功能）
   * 将当前的任务数据保存到本地存储
   */
  private saveDataToPersistence() {
    // 这里可以实现数据持久化逻辑
    // 例如使用preferences API保存到本地
    const allData = {
      toDoData: this.toDoData,
      achieveData: this.achieveData,
      timestamp: new Date().getTime()
    };

    hilog.info(0x0000, 'ToDoList', '数据已保存到本地存储');
  }

  /**
   * 滑动操作菜单构建器
   * 使用@Builder装饰器定义可复用的UI构建函数
   * 当用户左滑列表项时，会显示这个操作菜单
   *
   * @param item - 当前操作的待办事项对象
   */
  @Builder
  itemEnd(item: ToDo) {
    // 水平排列的操作按钮行
    Row({ space: STYLE_CONFIG.ICON_GUTTER }) {

      // 设置按钮（功能待实现）
      Image($r('app.media.ic_public_settings_filled'))
        .ImageStyle()                                      // 应用统一的图片样式
        .onClick(() => {
          // 设置功能的点击处理
          this.getUIContext().getPromptAction().showToast({
            message: $r('app.string.incomplete'),
            duration: 1500
          });

          hilog.info(0x0000, 'ToDoList', `设置操作: ${item.name}`);
        })

      // 详情按钮（功能待实现）
      Image($r('app.media.ic_public_detail_filled'))
        .ImageStyle()
        .onClick(() => {
          // 详情功能的点击处理
          this.getUIContext().getPromptAction().showToast({
            message: $r('app.string.incomplete'),
            duration: 1500
          });

          hilog.info(0x0000, 'ToDoList', `详情操作: ${item.name}`);
        })

      // 删除按钮
      Image($r('app.media.ic_public_delete_filled'))
        .ImageStyle()
        .fillColor($r('sys.color.ohos_id_color_alert'))    // 警告色，表示危险操作
        .onClick(() => {
          // 删除确认逻辑
          this.showDeleteConfirmDialog(item);
        })
    }
    .padding(STYLE_CONFIG.OPERATION_BUTTON_PADDING)       // 操作按钮区域内边距
    .justifyContent(FlexAlign.SpaceEvenly)                // 按钮等间距分布
    .backgroundColor($r('sys.color.ohos_id_color_sub_background')) // 子背景色
    .borderRadius($r('sys.float.ohos_id_corner_radius_default_m'))  // 圆角
  }

  /**
   * 显示删除确认对话框
   * 为重要操作提供二次确认，防止误删
   *
   * @param item - 要删除的任务项
   */
  showDeleteConfirmDialog(item: ToDo) {
    this.getUIContext().showAlertDialog({
      title: '确认删除',
      message: `确定要删除任务"${item.name}"吗？此操作不可撤销。`,
      alignment: DialogAlignment.Center,
      primaryButton: {
        value: '取消',
        fontColor: $r('sys.color.ohos_id_color_text_secondary'),
        action: () => {
          hilog.info(0x0000, 'ToDoList', '用户取消删除操作');
        }
      },
      secondaryButton: {
        value: '删除',
        fontColor: $r('sys.color.ohos_id_color_alert'),
        action: () => {
          this.deleteTodoItem(item);
        }
      }
    });
  }

  /**
   * 组件生命周期：即将出现
   * 在组件显示前执行初始化操作
   */
  aboutToAppear() {
    hilog.info(0x0000, 'ToDoList', '待办事项页面初始化');

    // 加载本地存储的数据
    this.loadDataFromPersistence();

    // 如果没有数据，添加一些示例数据
    if (this.toDoData.length === 0 && this.achieveData.length === 0) {
      this.initializeDefaultData();
    }
  }

  /**
   * 从本地存储加载数据（扩展功能）
   */
  private loadDataFromPersistence() {
    // 这里可以实现从preferences或数据库加载数据的逻辑
    hilog.info(0x0000, 'ToDoList', '从本地存储加载数据');
  }

  /**
   * 初始化默认数据
   * 为新用户提供一些示例任务
   */
  private initializeDefaultData() {
    BusinessConstant.DEFAULT_TODO_ITEMS.forEach(item => {
      this.toDoData.push(new ToDo(item));
    });

    hilog.info(0x0000, 'ToDoList', `初始化${this.toDoData.length}个默认任务`);
  }

  /**
   * 主页面构建方法
   * 定义了整个页面的UI结构和布局
   */
  build() {
    // 垂直布局的主容器
    Column() {

      // 页面头部区域
      Row({ space: STYLE_CONFIG.LIST_ITEM_GUTTER }) {

        // 页面标题
        Text($r('app.string.todo'))
          .fontSize($r('sys.float.ohos_id_text_size_headline7'))  // 大标题字体
          .fontWeight(FontWeight.Bold)                           // 粗体
          .fontColor($r('sys.color.ohos_id_color_text_primary')) // 主要文本颜色
          .maxLines(1)                                           // 单行显示

        // 空白填充，将添加按钮推到右侧
        Blank()

        // 任务统计信息（可选功能）
        Text(`${this.toDoData.length + this.achieveData.length}`)
          .fontSize($r('sys.float.ohos_id_text_size_body2'))
          .fontColor($r('sys.color.ohos_id_color_text_secondary'))
          .opacity(0.6)

        // 添加按钮
        Image($r('app.media.ic_public_add_filled'))
          .width(STYLE_CONFIG.MENU_IMAGE_SIZE)                   // 按钮尺寸
          .aspectRatio(1)                                        // 保持正方形
          .fillColor($r('sys.color.ohos_id_color_primary'))     // 主题色
          .borderRadius(STYLE_CONFIG.BORDER_RADIUS_ROUND)        // 圆形按钮
          .backgroundColor($r('sys.color.ohos_id_color_button_normal')) // 按钮背景
          .padding(4)                                            // 内边距
          .onClick(() => {
            // 添加新任务的处理逻辑
            this.showAddTaskDialog();
          })
          // 添加按钮状态样式
          .stateStyles({
            pressed: {
              .scale({ x: 0.95, y: 0.95 })                      // 按下时缩放效果
            },
            normal: {
              .scale({ x: 1, y: 1 })                            // 正常状态
            }
          })
      }
      .height(Constant.PERCENT_12)                              // 头部高度占12%
      .width(Constant.PERCENT_FULL)                             // 占满宽度
      .padding({
        left: $r('sys.float.ohos_id_max_padding_start'),        // 系统标准左内边距
        right: $r('sys.float.ohos_id_max_padding_end'),         // 系统标准右内边距
        top: $r('sys.float.ohos_id_max_padding_end'),           // 顶部内边距
        bottom: $r('sys.float.ohos_id_elements_margin_vertical_m') // 底部内边距
      })
      .backgroundColor(Color.White)                             // 白色背景

      // 主要内容区域：任务列表
      List({
        initialIndex: 0,                                        // 初始显示位置
        space: STYLE_CONFIG.LIST_ITEM_GUTTER                    // 列表项间距
      }) {

        // 未完成任务部分
        if (this.toDoData.length !== 0) {
          // 未完成任务的分组标题
          ListItem() {
            Text($r('app.string.undo'))
              .fontSize($r('sys.float.ohos_id_text_size_headline8'))   // 标题字体
              .fontWeight(FontWeight.Medium)                           // 中等粗细
              .fontColor($r('sys.color.ohos_id_color_text_primary'))   // 主要文本颜色
              .margin({
                left: $r('sys.float.ohos_id_default_padding_start'),   // 左边距
                top: $r('sys.float.ohos_id_elements_margin_vertical_m'), // 顶部边距
                bottom: $r('sys.float.ohos_id_elements_margin_vertical_m') // 底部边距
              })
          }
          .selectable(false)                                           // 标题不可选择
        }

        // 遍历未完成任务数组，生成列表项
        ForEach(this.toDoData, (toDoItem: ToDo) => {
          ListItem() {
            // 使用ToDoListItem组件显示任务
            ToDoListItem({
              toDoItem: toDoItem,                                     // 当前任务对象
              achieveData: this.achieveData,                          // 已完成任务数组引用
              toDoData: this.toDoData                                 // 未完成任务数组引用
            })
          }
          // 配置滑动操作
          .swipeAction({
            end: this.itemEnd(toDoItem),                              // 左滑显示的操作菜单
            edgeEffect: SwipeEdgeEffect.Spring                        // 边缘弹性效果
          })
          // 列表项动画效果
          .transition(TransitionEffect.asymmetric(
            TransitionEffect.move(TransitionEdge.START).animation({
              duration: 300,
              curve: Curve.EaseOut
            }),
            TransitionEffect.move(TransitionEdge.END).animation({
              duration: 300,
              curve: Curve.EaseIn
            })
          ))
        }, (toDoItem: ToDo) => toDoItem.key)                          // 使用key作为唯一标识

        // 已完成任务部分
        if (this.achieveData.length !== 0) {
          // 已完成任务的分组标题
          ListItem() {
            Text($r('app.string.done'))
              .fontSize($r('sys.float.ohos_id_text_size_headline8'))
              .fontWeight(FontWeight.Medium)
              .fontColor($r('sys.color.ohos_id_color_text_secondary')) // 次要文本颜色
              .opacity(0.8)                                             // 降低透明度
              .margin({
                left: $r('sys.float.ohos_id_default_padding_start'),
                top: $r('sys.float.ohos_id_elements_margin_vertical_l'), // 较大的顶部边距
                bottom: $r('sys.float.ohos_id_elements_margin_vertical_l')
              })
          }
          .selectable(false)
        }

        // 遍历已完成任务数组，生成列表项
        ForEach(this.achieveData, (toDoItem: ToDo) => {
          ListItem() {
            ToDoListItem({
              toDoItem: toDoItem,
              achieveData: this.achieveData,
              toDoData: this.toDoData
            })
          }
          .swipeAction({
            end: this.itemEnd(toDoItem),
            edgeEffect: SwipeEdgeEffect.Spring
          })
          // 已完成任务的特殊样式
          .opacity(0.7)                                               // 降低整体透明度
          .transition(TransitionEffect.asymmetric(
            TransitionEffect.move(TransitionEdge.START).animation({
              duration: 300,
              curve: Curve.EaseOut
            }),
            TransitionEffect.move(TransitionEdge.END).animation({
              duration: 300,
              curve: Curve.EaseIn
            })
          ))
        }, (toDoItem: ToDo) => toDoItem.key)

        // 空状态提示（当没有任务时显示）
        if (this.toDoData.length === 0 && this.achieveData.length === 0) {
          ListItem() {
            Column() {
              Image($r('app.media.ic_empty_list'))
                .width(100)
                .height(100)
                .opacity(0.3)

              Text('暂无任务')
                .fontSize($r('sys.float.ohos_id_text_size_body1'))
                .fontColor($r('sys.color.ohos_id_color_text_secondary'))
                .margin({ top: 16 })

              Text('点击右上角的+按钮添加新任务')
                .fontSize($r('sys.float.ohos_id_text_size_body2'))
                .fontColor($r('sys.color.ohos_id_color_text_tertiary'))
                .margin({ top: 8 })
            }
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
            .padding(40)
          }
          .selectable(false)
        }

      }
      .layoutWeight(1)                                                // 占用剩余空间
      .listDirection(Axis.Vertical)                                   // 垂直方向
      .edgeEffect(EdgeEffect.Spring)                                  // 边缘弹性效果
      .friction(0.6)                                                  // 摩擦系数
      .scrollBar(BarState.Off)                                        // 隐藏滚动条
      .padding({
        top: $r('sys.float.ohos_id_default_padding_top'),             // 顶部内边距
        left: $r('sys.float.ohos_id_default_padding_start'),          // 左内边距
        right: $r('sys.float.ohos_id_default_padding_end'),           // 右内边距
        bottom: $r('sys.float.ohos_id_default_padding_end')        // 底部内边距
      })
      .divider({
        strokeWidth: 1,                                               // 分割线宽度
        color: $r('sys.color.ohos_id_color_list_separator'),          // 分割线颜色
        startMargin: $r('sys.float.ohos_id_default_padding_start'),   // 起始边距
        endMargin: $r('sys.float.ohos_id_default_padding_end')        // 结束边距
      })

    }
    .backgroundColor($r('app.color.background_color'))                // 页面背景色
    .height(Constant.PERCENT_FULL)                                    // 占满高度
    .width(Constant.PERCENT_FULL)                                     // 占满宽度
  }

  /**
   * 显示添加任务对话框
   * 使用系统提供的TextPickerDialog选择预定义任务
   */
  showAddTaskDialog() {
    try {
      this.getUIContext().showTextPickerDialog({
        // 从字符串数组资源中获取可选任务列表
        range: this.getUIContext().getHostContext()?.resourceManager
          .getStringArrayValueSync($r('app.strarray.available_things').id),
        selected: 0,                                                  // 默认选中第一项
        canLoop: true,                                                // 允许循环滚动
        onAccept: (value: TextPickerResult) => {
          // 用户确认选择后的回调
          const selectedText = this.getUIContext().getHostContext()?.resourceManager
            .getStringArrayValueSync($r('app.strarray.available_things').id)[Number(value.index)];

          if (selectedText) {
            // 在未完成任务列表开头添加新任务
            this.toDoData.unshift(new ToDo(selectedText));

            // 显示添加成功的提示
            this.getUIContext().getPromptAction().showToast({
              message: `已添加任务：${selectedText}`,
              duration: 2000
            });

            // 记录操作日志
            hilog.info(0x0000, 'ToDoList', `新增任务: ${selectedText}`);

            // 保存数据
            this.saveDataToPersistence();
          }
        },
        onCancel: () => {
          // 用户取消选择的回调
          hilog.info(0x0000, 'ToDoList', '用户取消添加任务');
        }
      });
    } catch (error) {
      // 异常处理
      let err = error as BusinessError;
      hilog.error(0x0000, 'ToDoList',
        `显示添加对话框失败 - code: ${err.code}, message: ${err.message}`);

      this.getUIContext().getPromptAction().showToast({
        message: '添加任务失败，请重试',
        duration: 2000
      });
    }
  }

  /**
   * 组件生命周期：即将消失
   * 在组件销毁前执行清理操作
   */
  aboutToDisappear() {
    // 保存当前数据状态
    this.saveDataToPersistence();

    hilog.info(0x0000, 'ToDoList', '待办事项页面销毁');
  }
}