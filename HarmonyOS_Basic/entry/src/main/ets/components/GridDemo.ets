@Component
@Preview
export struct GridDemo{
  @State assignments: Assignment[] = [
    { title: '数学作业', deadline: '2025-09-15', status: 'pending' },
    { title: 'Java编程', deadline: '2025-09-16', status: 'completed' },
    { title: '英语作文', deadline: '2025-09-17', status: 'pending' },
    { title: '物理实验', deadline: '2025-09-18', status: 'overdue' },
    { title: '化学报告', deadline: '2025-09-19', status: 'pending' },
    { title: '历史论文', deadline: '2025-09-20', status: 'completed' }
  ];

  build() {
    Grid(){
      ForEach(this.assignments,(assignment: Assignment)=>{
        GridItem(){
          Column({ space: 14}) {
            //作业标题
            Text(assignment.title).fontSize(26)

            //作业状态
            Text(this.getIconByStatus(assignment.status)).fontSize(24)
            Text(assignment.status).fontColor(this.getColorByStatus(assignment.status)).fontSize(24)

            //截止时间
            Text(assignment.deadline).fontSize(12)
          }
        }
      })
    }
    .columnsTemplate('1fr 1fr')
    .rowsTemplate('auto auto auto')
    .columnsGap(16)
    .rowsGap(16)
    .width('100%')
    .padding(16)
  }

  getIconByStatus(status:string): string{
    switch (status){
      case 'pending':
        return '📝'
      case 'completed':
        return '✅'
      case 'overdue':
        return '⚠️'
      default :
        return '📋'
    }
    return ''
  }

  getColorByStatus(status: string): string {
    switch (status) {
      case 'pending':
        return '#FF9800';
      case 'completed':
        return '#4CAF58';
      case 'overdue':
        return '#FF5722';
      default:
        return '#CCCCCC';
    }
  }
}



interface Assignment {
  title: string
  deadline: string
  status: string
}