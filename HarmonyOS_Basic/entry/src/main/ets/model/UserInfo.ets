export interface UserInfo {
  id: number // 用户id唯一标识
  name: string
  age: number
  avatar: Resource
  email?: string //带问号可选字段
  active: boolean
}