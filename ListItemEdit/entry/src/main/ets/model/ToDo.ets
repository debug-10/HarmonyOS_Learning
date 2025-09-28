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

// 导入工具库，用于生成UUID
import { util } from '@kit.ArkTS'

/**
 * 待办事项数据模型类
 *
 * 这个类定义了待办事项的数据结构和基本行为
 * 使用@Observed装饰器使其成为可观察对象，当属性发生变化时
 * 能够自动通知UI组件进行更新
 *
 * 主要属性：
 * - key: 唯一标识符，用于区分不同的待办事项
 * - name: 待办事项的名称/内容
 * - isCompleted: 完成状态，true表示已完成，false表示未完成
 */
@Observed
export class ToDo {
  /**
   * 唯一标识符
   * 使用util.generateRandomUUID(true)生成带连接符的UUID
   * 这确保每个待办事项都有一个全局唯一的标识符
   */
  key: string = util.generateRandomUUID(true);

  /**
   * 待办事项名称
   * 存储用户输入的待办事项内容
   */
  name: string;

  /**
   * 完成状态
   * false: 未完成（默认状态）
   * true: 已完成
   */
  isCompleted: boolean = false;

  /**
   * 构造函数
   * 创建新的待办事项实例
   *
   * @param name - 待办事项的名称，由用户提供
   */
  constructor(name: string) {
    this.name = name;
  }

  /**
   * 切换完成状态
   * 便捷方法，用于在完成/未完成状态之间切换
   */
  toggleCompleted(): void {
    this.isCompleted = !this.isCompleted;
  }

  /**
   * 获取显示文本
   * 根据完成状态返回不同的显示效果
   *
   * @returns 格式化后的显示文本
   */
  getDisplayText(): string {
    return this.isCompleted ? `✓ ${this.name}` : this.name;
  }

  /**
   * 克隆当前对象
   * 创建一个新的ToDo实例，具有相同的属性值但不同的key
   *
   * @returns 新的ToDo实例
   */
  clone(): ToDo {
    const newTodo = new ToDo(this.name);
    newTodo.isCompleted = this.isCompleted;
    return newTodo;
  }
}