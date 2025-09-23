import { RowDemo } from '../components/RowDemo'
import { FlexDemo } from '../components/FlexDemo'
import { ColumnDemo } from '../components/ColumnDemo'
import { GridDemo } from '../components/GridDemo'
import { StackDemo } from '../components/StackDemo'

@Entry
@Component
struct ComponentPage {
  @State message: string = 'Hello World';

  build() {
    Column({ space: 10 }) {
      // RowDemo()
      // ColumnDemo()
      // FlexDemo()
      StackDemo()
      GridDemo()
    }
    .padding(10)
    .layoutWeight(1)
    .backgroundColor('#F1F3F5')
  }
}