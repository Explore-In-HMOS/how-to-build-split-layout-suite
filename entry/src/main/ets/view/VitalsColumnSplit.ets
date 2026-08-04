import { HealthStore } from '../model/HealthData';
import { Theme } from '../model/Theme';

// ColumnSplit demo. Panel heights + divider margins stay under 100% so the
// divider remains draggable.
@Component
export struct VitalsColumnSplit {
  @Builder
  vitalPanel(name: string, value: number, unit: string, accent: string, tint: string) {
    Column() {
      Text(name.toUpperCase())
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(accent)
        .letterSpacing(1.5)
        .maxLines(1)

      Row() {
        Text(`${value}`).fontSize(32).fontWeight(FontWeight.Bold).fontColor(Theme.text).maxLines(1)
        Text(unit).fontSize(11).fontColor(Theme.textDim).margin({ left: 5, bottom: 6 })
      }
      .alignItems(VerticalAlign.Bottom)
      .margin({ top: 4 })
    }
    .width('100%')
    .height('42%')
    .padding({ left: 22, right: 22 })
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(tint)
    .borderRadius(Theme.cardRadius)
    .border({ width: 1, color: Theme.stroke })
    .clip(true)
  }

  build() {
    ColumnSplit() {
      this.vitalPanel('Heart Rate', HealthStore.heartRate, 'bpm', Theme.hr, '#17080A')
      this.vitalPanel('Steps', HealthStore.steps, 'today', Theme.steps, '#08130F')
    }
    .resizeable(true)
    .divider({ startMargin: 6, endMargin: 6 })
    .width('100%')
    .height('100%')
  }
}