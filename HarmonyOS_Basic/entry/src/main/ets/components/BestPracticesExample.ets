@Component
export struct BestPracticesExample {
  // 推荐：使用具体类型
  @State userCount: number = 0
  @State isLoggedIn: boolean = false
  @State userInfo: UserInfo | null = null

  // 不推荐：使用any类型
  // @State data: any = {}

  // 推荐：初始化默认值
  @State settings: AppSettings = {
    theme: 'light',
    language: 'zh-CN',
    fontSize: 16
  }

  // 推荐：复杂状态使用接口定义
  @State formData: LoginForm = {
    username: '',
    password: '',
    rememberMe: false
  }

  build() {
    Column() {
      // UI 构建
    }
  }
}

interface UserInfo {
  id: string
  name: string
  avatar: string
  role: 'admin' | 'user' | 'guest'
}

interface AppSettings {
  theme: 'light' | 'dark'
  language: string
  fontSize: number
}

interface LoginForm {
  username: string
  password: string
  rememberMe: boolean
}