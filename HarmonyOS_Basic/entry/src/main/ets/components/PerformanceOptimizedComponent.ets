// @Component
// struct PerformanceOptimizedComponent {
//   @State largeDataList: DataItem[] = []
//   @State @Watch('onFilterChange') filter: string = ''
//
//   // 推荐：使用计算属性避免重复计算
//   get filteredList(): DataItem[] {
//     if (!this.filter) return this.largeDataList
//     return this.largeDataList.filter(item =>
//     item.name.toLowerCase().includes(this.filter.toLowerCase())
//     )
//   }
//
//   onFilterChange() {
//     // 只在filter变化时执行相关逻辑
//     console.log('过滤条件变化:', this.filter)
//   }
//
//   build() {
//     Column() {
//       TextInput({ placeholder: '搜索...' })
//         .onChange((value) => {
//           this.filter = value
//         })
//
//       // 推荐：使用LazyForEach处理大量数据
//       List() {
//         LazyForEach(this.filteredList, (item: DataItem) => {
//           ListItem() {
//             Text(item.name)
//           }
//         }, (item: DataItem) => item.id)
//       }
//     }
//   }
// }