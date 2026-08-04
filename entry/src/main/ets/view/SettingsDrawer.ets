import { Theme } from '../model/Theme';

// Sidebar content for the SideBarContainer.
@Component
export struct SettingsDrawer {
  @Link use24Hour: boolean;
  @Link metricUnits: boolean;
  onClose?: () => void;

  @Builder
  settingRow(label: string, value: boolean, onToggle: (v: boolean) => void) {
    Row() {
      Text(label).fontSize(12).fontColor(Theme.text).layoutWeight(1)
      Toggle({ type: ToggleType.Switch, isOn: value })
        .selectedColor(Theme.steps)
        .onChange((isOn: boolean) => { onToggle(isOn); })
    }
    .width('84%')
    .height(40)
    .padding({ left: 14, right: 8 })
    .borderRadius(12)
    .backgroundColor(Theme.card)
    .border({ width: 1, color: Theme.stroke })
    .alignItems(VerticalAlign.Center)
    .margin({ bottom: 8 })
  }

  build() {
    Column() {
      Text('SETTINGS')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(Theme.textDim)
        .letterSpacing(2)
        .margin({ bottom: 16 })

      this.settingRow('24-hour', this.use24Hour, (v: boolean) => { this.use24Hour = v; })
      this.settingRow('Metric units', this.metricUnits, (v: boolean) => { this.metricUnits = v; })

      Button('Close')
        .fontSize(13)
        .fontColor(Theme.text)
        .backgroundColor(Theme.cardHi)
        .width('56%')
        .height(36)
        .borderRadius(18)
        .margin({ top: 8 })
        .onClick(() => { this.onClose?.(); })
    }
    .width('100%')
    .height('100%')
    .padding({ top: 24, bottom: 24, left: 10, right: 10 })
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#08090B')
  }
}