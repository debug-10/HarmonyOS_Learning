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

/**
 * 样式配置常量
 *
 * 这个配置对象包含了应用中所有UI组件的尺寸、间距、动画等样式参数
 * 使用Record<string, number>类型确保所有值都是数字类型
 * 集中管理样式常量有以下优势：
 * 1. 便于维护和修改
 * 2. 确保UI风格的一致性
 * 3. 避免魔法数字分散在代码中
 * 4. 便于主题切换和动态样式调整
 */
export const STYLE_CONFIG: Record<string, number> = {
  // 图片和图标尺寸相关
  'IMAGE_SIZE': 32,              // 普通图片的标准尺寸（像素）
  'IMAGE_MARGIN': 4,             // 图片的外边距
  'ICON_GUTTER': 4,              // 图标之间的间距
  'MENU_IMAGE_SIZE': 24,         // 菜单中图标的尺寸
  'IMAGE_ICON_OK_SIZE': 15,      // 完成状态图标的尺寸
  'CUSTOM_CHECKBOX_SIZE': 20,    // 自定义复选框的尺寸

  // 按钮和操作区域相关
  'OPERATION_BUTTON_PADDING': 4, // 操作按钮的内边距
  'MENU_HEIGHT': 56,             // 菜单栏的高度

  // 列表和布局相关
  'LIST_ITEM_GUTTER': 12,        // 列表项之间的间距
  'TODO_ITEM_HEIGHT': 80,        // 待办事项条目的高度
  'TODO_ITEM_PADDING_VERTICAL': 4, // 待办事项条目的垂直内边距
  'TEXT_MARGIN_LEFT': 40,        // 文本左边距
  'IMAGE_MARGIN_RIGHT': 30,      // 图片右边距

  // 边框和装饰相关
  'BORDER_WIDTH': 3,             // 边框宽度

  // 动画相关
  'ANIMATION_DURATION': 600,     // 动画持续时间（毫秒）
};

/**
 * 通用常量类
 *
 * 包含应用中使用的百分比、字符串等常量
 * 使用static readonly确保常量不可修改
 */
export class Constant {
  /**
   * 百分比常量 - 12%
   * 通常用于头部区域或小比例布局
   */
  static readonly PERCENT_12: string = '12%';

  /**
   * 百分比常量 - 100%
   * 表示占满父容器的完整尺寸
   */
  static readonly PERCENT_FULL: string = '100%';

  /**
   * 百分比常量 - 90%
   * 常用于内容区域，留出一定边距
   */
  static readonly PERCENT_90: string = '90%';

  /**
   * 百分比常量 - 80%
   * 用于更紧凑的布局
   */
  static readonly PERCENT_80: string = '80%';

  /**
   * Z轴层级常量
   * 用于控制组件的显示层级
   */
  static readonly Z_INDEX_DEFAULT: number = 1;
  static readonly Z_INDEX_POPUP: number = 100;
  static readonly Z_INDEX_TOAST: number = 999;

  /**
   * 动画曲线常量
   * 定义不同类型的动画效果
   */
  static readonly ANIMATION_CURVE_EASE: string = 'ease';
  static readonly ANIMATION_CURVE_LINEAR: string = 'linear';
  static readonly ANIMATION_CURVE_EASE_IN_OUT: string = 'ease-in-out';

  /**
   * 延迟时间常量（毫秒）
   */
  static readonly DELAY_SHORT: number = 200;
  static readonly DELAY_MEDIUM: number = 500;
  static readonly DELAY_LONG: number = 1000;

  /**
   * 透明度常量
   */
  static readonly OPACITY_TRANSPARENT: number = 0;
  static readonly OPACITY_HALF: number = 0.5;
  static readonly OPACITY_FULL: number = 1;

  /**
   * 圆角半径常量
   */
  static readonly BORDER_RADIUS_SMALL: number = 4;
  static readonly BORDER_RADIUS_MEDIUM: number = 8;
  static readonly BORDER_RADIUS_LARGE: number = 16;
  static readonly BORDER_RADIUS_ROUND: number = 50;
}

/**
 * 业务逻辑常量
 * 包含应用业务相关的常量定义
 */
export class BusinessConstant {
  /**
   * 列表操作类型
   */
  static readonly OPERATION_ADD: string = 'add';
  static readonly OPERATION_DELETE: string = 'delete';
  static readonly OPERATION_EDIT: string = 'edit';
  static readonly OPERATION_TOGGLE: string = 'toggle';

  /**
   * 数据存储键名
   */
  static readonly STORAGE_KEY_TODOS: string = 'todo_list_data';
  static readonly STORAGE_KEY_SETTINGS: string = 'app_settings';

  /**
   * 最大数据限制
   */
  static readonly MAX_TODO_ITEMS: number = 100;
  static readonly MAX_TODO_NAME_LENGTH: number = 50;

  /**
   * 默认数据
   */
  static readonly DEFAULT_TODO_ITEMS: string[] = [
    '晨练',
    '准备早餐',
    '阅读经典',
    '学习ArkTS',
    '看电视放松'
  ];
}