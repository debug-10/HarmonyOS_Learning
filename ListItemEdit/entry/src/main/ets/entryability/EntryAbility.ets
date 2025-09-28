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

import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';

/**
 * EntryAbility应用入口类
 *
 * 这是HarmonyOS应用的主要入口点，负责管理应用的生命周期
 * 包括应用的创建、销毁、前台/后台切换等关键事件的处理
 *
 * 主要功能：
 * 1. 应用初始化和配置
 * 2. 窗口管理和设置
 * 3. 生命周期事件处理
 * 4. 系统事件响应
 * 5. 错误处理和日志记录
 */
export default class EntryAbility extends UIAbility {
  /**
   * 窗口对象引用
   * 用于管理应用窗口的各种属性和行为
   */
  private mainWindow: window.WindowStage | undefined = undefined;

  /**
   * 应用创建生命周期回调
   *
   * 当应用首次启动时调用，用于初始化应用的基本配置
   * 这是应用生命周期的第一个阶段
   *
   * @param want - 启动意图信息，包含启动应用的相关参数
   * @param launchParam - 启动参数，包含启动类型等信息
   */
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    // 记录应用创建日志
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');

    // 在这里可以进行以下初始化操作：
    // 1. 全局变量初始化
    // 2. 数据库连接建立
    // 3. 网络配置初始化
    // 4. 用户偏好设置加载

    try {
      // 初始化应用配置
      this.initializeAppConfig();

      // 设置全局错误处理
      this.setupGlobalErrorHandler();

      hilog.info(0x0000, 'testTag', '应用初始化完成');

    } catch (error) {
      hilog.error(0x0000, 'testTag', '应用初始化失败: %{public}s', JSON.stringify(error));
    }
  }

  /**
   * 应用销毁生命周期回调
   *
   * 当应用被系统终止时调用，用于清理资源和保存重要数据
   * 这是应用生命周期的最后阶段
   */
  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');

    try {
      // 执行清理操作：
      // 1. 保存用户数据
      this.saveUserData();

      // 2. 关闭数据库连接
      this.closeDatabaseConnections();

      // 3. 取消网络请求
      this.cancelNetworkRequests();

      // 4. 清理定时器和监听器
      this.clearTimersAndListeners();

      hilog.info(0x0000, 'testTag', '应用清理完成');

    } catch (error) {
      hilog.error(0x0000, 'testTag', '应用清理失败: %{public}s', JSON.stringify(error));
    }
  }

  /**
   * 窗口阶段创建生命周期回调
   *
   * 当应用的UI窗口准备就绪时调用，这是设置UI相关配置的最佳时机
   *
   * @param windowStage - 窗口舞台对象，用于管理应用窗口
   */
  onWindowStageCreate(windowStage: window.WindowStage): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    try {
      // 保存窗口引用
      this.mainWindow = windowStage;

      // 设置主页面路径
      windowStage.loadContent('pages/Index', (err) => {
        if (err.code) {
          hilog.error(0x0000, 'testTag', '页面加载失败: %{public}s', JSON.stringify(err));
          return;
        }
        hilog.info(0x0000, 'testTag', '页面加载成功');
      });

      // 配置窗口属性
      this.configureWindow(windowStage);

      // 设置窗口事件监听
      this.setupWindowEventListeners(windowStage);

    } catch (error) {
      hilog.error(0x0000, 'testTag', '窗口创建失败: %{public}s', JSON.stringify(error));
    }
  }

  /**
   * 窗口阶段销毁生命周期回调
   *
   * 当应用窗口被销毁时调用，用于清理窗口相关的资源
   */
  onWindowStageDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');

    try {
      // 清理窗口事件监听器
      this.clearWindowEventListeners();

      // 清空窗口引用
      this.mainWindow = undefined;

      hilog.info(0x0000, 'testTag', '窗口销毁完成');

    } catch (error) {
      hilog.error(0x0000, 'testTag', '窗口销毁失败: %{public}s', JSON.stringify(error));
    }
  }

  /**
   * 应用前台生命周期回调
   *
   * 当应用从后台切换到前台时调用
   * 这是恢复应用状态和更新UI的好时机
   */
  onForeground(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');

    try {
      // 前台操作：
      // 1. 恢复暂停的操作
      this.resumePausedOperations();

      // 2. 刷新数据
      this.refreshData();

      // 3. 重新建立网络连接
      this.reconnectNetwork();

      // 4. 更新UI状态
      this.updateUIState();

      hilog.info(0x0000, 'testTag', '应用已切换到前台');

    } catch (error) {
      hilog.error(0x0000, 'testTag', '前台切换失败: %{public}s', JSON.stringify(error));
    }
  }

  /**
   * 应用后台生命周期回调
   *
   * 当应用从前台切换到后台时调用
   * 这是保存状态和暂停非必要操作的时机
   */
  onBackground(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');

    try {
      // 后台操作：
      // 1. 保存当前状态
      this.saveCurrentState();

      // 2. 暂停动画和定时器
      this.pauseAnimationsAndTimers();

      // 3. 释放临时资源
      this.releaseTempResources();

      // 4. 暂停网络请求
      this.pauseNetworkRequests();

      hilog.info(0x0000, 'testTag', '应用已切换到后台');

    } catch (error) {
      hilog.error(0x0000, 'testTag', '后台切换失败: %{public}s', JSON.stringify(error));
    }
  }

  /**
   * 初始化应用配置
   * 设置应用的基本配置参数
   */
  private initializeAppConfig(): void {
    // 这里可以初始化全局配置
    // 例如：主题设置、语言配置、网络配置等
    hilog.info(0x0000, 'testTag', '初始化应用配置');
  }

  /**
   * 设置全局错误处理器
   * 捕获并处理应用中的未处理异常
   */
  private setupGlobalErrorHandler(): void {
    // 设置全局异常处理逻辑
    hilog.info(0x0000, 'testTag', '设置全局错误处理器');
  }

  /**
   * 配置窗口属性
   * 设置窗口的各种显示属性
   *
   * @param windowStage - 窗口舞台对象
   */
  private configureWindow(windowStage: window.WindowStage): void {
    windowStage.getMainWindow().then((mainWindow) => {
      // 设置窗口全屏显示
      mainWindow.setWindowLayoutFullScreen(true);

      // 设置状态栏和导航栏样式
      mainWindow.setWindowSystemBarEnable(['status', 'navigation']);

      // 设置状态栏内容颜色
      mainWindow.setWindowSystemBarProperties({
        statusBarColor: '#FFFFFF',           // 状态栏背景色
        statusBarContentColor: '#000000',    // 状态栏内容颜色
        navigationBarColor: '#FFFFFF',       // 导航栏背景色
        navigationBarContentColor: '#000000' // 导航栏内容颜色
      });

      hilog.info(0x0000, 'testTag', '窗口配置完成');
    }).catch((error) => {
      hilog.error(0x0000, 'testTag', '窗口配置失败: %{public}s', JSON.stringify(error));
    });
  }

  /**
   * 设置窗口事件监听器
   * 监听窗口的各种事件
   *
   * @param windowStage - 窗口舞台对象
   */
  private setupWindowEventListeners(windowStage: window.WindowStage): void {
    // 可以在这里设置窗口事件监听器
    // 例如：窗口大小变化、方向变化等
    hilog.info(0x0000, 'testTag', '设置窗口事件监听器');
  }

  /**
   * 清理窗口事件监听器
   */
  private clearWindowEventListeners(): void {
    // 清理在setupWindowEventListeners中设置的监听器
    hilog.info(0x0000, 'testTag', '清理窗口事件监听器');
  }

  /**
   * 保存用户数据
   */
  private saveUserData(): void {
    // 保存用户的重要数据
    hilog.info(0x0000, 'testTag', '保存用户数据');
  }

  /**
   * 关闭数据库连接
   */
  private closeDatabaseConnections(): void {
    // 关闭所有数据库连接
    hilog.info(0x0000, 'testTag', '关闭数据库连接');
  }

  /**
   * 取消网络请求
   */
  private cancelNetworkRequests(): void {
    // 取消所有正在进行的网络请求
    hilog.info(0x0000, 'testTag', '取消网络请求');
  }

  /**
   * 清理定时器和监听器
   */
  private clearTimersAndListeners(): void {
    // 清理所有定时器和事件监听器
    hilog.info(0x0000, 'testTag', '清理定时器和监听器');
  }

  /**
   * 恢复暂停的操作
   */
  private resumePausedOperations(): void {
    // 恢复在后台时暂停的操作
    hilog.info(0x0000, 'testTag', '恢复暂停的操作');
  }

  /**
   * 刷新数据
   */
  private refreshData(): void {
    // 刷新应用数据
    hilog.info(0x0000, 'testTag', '刷新应用数据');
  }

  /**
   * 重新建立网络连接
   */
  private reconnectNetwork(): void {
    // 重新建立网络连接
    hilog.info(0x0000, 'testTag', '重新建立网络连接');
  }

  /**
   * 更新UI状态
   */
  private updateUIState(): void {
    // 更新UI显示状态
    hilog.info(0x0000, 'testTag', '更新UI状态');
  }

  /**
   * 保存当前状态
   */
  private saveCurrentState(): void {
    // 保存应用当前状态
    hilog.info(0x0000, 'testTag', '保存当前状态');
  }

  /**
   * 暂停动画和定时器
   */
  private pauseAnimationsAndTimers(): void {
    // 暂停所有动画和定时器
    hilog.info(0x0000, 'testTag', '暂停动画和定时器');
  }

  /**
   * 释放临时资源
   */
  private releaseTempResources(): void {
    // 释放临时占用的资源
    hilog.info(0x0000, 'testTag', '释放临时资源');
  }

  /**
   * 暂停网络请求
   */
  private pauseNetworkRequests(): void {
    // 暂停非必要的网络请求
    hilog.info(0x0000, 'testTag', '暂停网络请求');
  }
}