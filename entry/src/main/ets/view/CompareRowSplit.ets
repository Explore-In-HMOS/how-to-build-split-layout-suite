import { HealthStore } from '../model/HealthData';
import { Theme } from '../model/Theme';

// RowSplit demo. Today is accented, yesterday is dimmed. Draggable divider.
@Component
export struct CompareRowSplit {
  @Builder
  dayPanel(title: string, steps: number, kcal: number, titleColor: string, valueColor: string, tint: string) {
    Column() {
      Text(title.toUpperCase())
        .fontSize(9)
        .fontWeight(FontWeight.Medium)
        .fontColor(titleColor)
        .letterSpacing(1.2)
        .maxLines(1)

      Text(`${steps}`).fontSize(21).fontWeight(FontWeight.Bold).fontColor(valueColor).maxLines(1).margin({ top: 5 })
      Text('steps').fontSize(9).fontColor(Theme.textDim).maxLines(1)

      Text(`${kcal} kcal`).fontSize(10).fontColor(Theme.cal).maxLines(1).margin({ top: 10 })
    }
    .width('47%')
    .height('100%')
    .padding({ left: 6, right: 6 })
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(tint)
    .borderRadius(Theme.cardRadius)
    .border({ width: 1, color: Theme.stroke })
    .clip(true)
  }

  build() {
    RowSplit() {
      this.dayPanel('Today', HealthStore.stepsToday, HealthStore.caloriesToday, Theme.steps, Theme.text, '#08130F')
      this.dayPanel('Yesterday', HealthStore.stepsYesterday, HealthStore.caloriesYesterday, Theme.textDim, '#B7BCC4', '#121317')
    }
    .resizeable(true)
    .width('100%')
    .height('100%')
  }
}