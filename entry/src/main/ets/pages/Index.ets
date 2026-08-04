import { VitalsColumnSplit } from '../view/VitalsColumnSplit';
import { CompareRowSplit } from '../view/CompareRowSplit';
import { SettingsDrawer } from '../view/SettingsDrawer';
import { Theme } from '../model/Theme';

interface LayoutDemo {
  route: string;
  component: string;
  label: string;
  accent: string;
}

@Entry
@Component
struct Index {
  private stack: NavPathStack = new NavPathStack();
  @State showSettings: boolean = false;
  @State use24Hour: boolean = true;
  @State metricUnits: boolean = true;

  private demos: LayoutDemo[] = [
    { route: 'column', component: 'ColumnSplit', label: 'Vitals',  accent: Theme.hr },
    { route: 'row',    component: 'RowSplit',    label: 'Compare', accent: Theme.steps }
  ];

  private componentName(route: string): string {
    switch (route) {
      case 'column': return 'ColumnSplit';
      default:       return 'RowSplit';
    }
  }

  // A solid rounded bar, the building block for the drawn lines.
  @Builder
  bar(w: number, h: number, r: number, color: string) {
    Column() {}
    .width(w)
    .height(h)
    .borderRadius(r)
    .backgroundColor(color)
  }

  // A small mark that depicts each layout: stacked bars or side bars.
  @Builder
  layoutGlyph(route: string, color: string) {
    if (route === 'column') {
      Column({ space: 3 }) {
        this.bar(18, 7, 2, color)
        this.bar(18, 7, 2, color)
      }
    } else {
      Row({ space: 3 }) {
        this.bar(7, 18, 2, color)
        this.bar(7, 18, 2, color)
      }
    }
  }

  // Thin ring that frames the round face.
  @Builder
  frame() {
    Circle()
      .width('99%')
      .height('99%')
      .fillOpacity(0)
      .stroke(Theme.stroke)
      .strokeWidth(1)
      .strokeOpacity(0.6)
      .hitTestBehavior(HitTestMode.None)
  }

  // Title and back chevron, placed inside the safe arc.
  @Builder
  pageHeader(title: string) {
    Text(title)
      .fontSize(13)
      .fontWeight(FontWeight.Medium)
      .fontColor(Theme.text)
      .letterSpacing(0.5)
      .maxLines(1)
      .width('100%')
      .textAlign(TextAlign.Center)
      .position({ x: 0, y: '7%' })

    Button({ type: ButtonType.Circle }) {
      Text('‹').fontSize(20).fontColor(Theme.text)
    }
    .width(30)
    .height(30)
    .backgroundColor(Theme.cardHi)
    .position({ x: '14%', y: '15%' })
    .onClick(() => { this.stack.pop(); })
  }

  // One destination for every route.
  @Builder
  demoPage(route: string) {
    NavDestination() {
      Stack() {
        this.frame()

        Column() {
          if (route === 'column') {
            VitalsColumnSplit()
          } else {
            CompareRowSplit()
          }
        }
        .width('84%')
        .height('72%')

        this.pageHeader(this.componentName(route))
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Theme.bg)
    }
    .hideTitleBar(true)
  }

  build() {
    SideBarContainer(SideBarContainerType.Overlay) {
      // Sidebar (first child).
      SettingsDrawer({
        use24Hour: $use24Hour,
        metricUnits: $metricUnits,
        onClose: () => { this.showSettings = false; }
      })

      // Content (second child). The Stack lets the gear float over every page.
      Stack() {
        Navigation(this.stack) {
          // Home menu — the list of layout demos.
          Stack() {
            this.frame()

            Column() {
              Text('LAYOUTS')
                .fontSize(13)
                .fontWeight(FontWeight.Medium)
                .fontColor(Theme.text)
                .letterSpacing(3)
                .margin({ top: 8, bottom: 12 })

              List({ space: 8 }) {
                ForEach(this.demos, (d: LayoutDemo) => {
                  ListItem() {
                    Row() {
                      Column() {
                        this.layoutGlyph(d.route, d.accent)
                      }
                      .width(22)
                      .justifyContent(FlexAlign.Center)
                      .alignItems(HorizontalAlign.Center)

                      Column() {
                        Text(d.component).fontSize(13).fontWeight(FontWeight.Medium).fontColor(Theme.text).maxLines(1)
                        Text(d.label).fontSize(10).fontColor(Theme.textDim).maxLines(1)
                      }
                      .alignItems(HorizontalAlign.Start)
                      .layoutWeight(1)
                      .margin({ left: 12 })

                      Text('›').fontSize(18).fontColor(Theme.textDim)
                    }
                    .width('100%')
                    .height(60)
                    .padding({ left: 16, right: 16 })
                    .borderRadius(Theme.cardRadius)
                    .backgroundColor(Theme.card)
                    .border({ width: 1, color: Theme.stroke })
                    .alignItems(VerticalAlign.Center)
                  }
                  .onClick(() => { this.stack.pushPath({ name: d.route }); })
                }, (d: LayoutDemo) => d.route)
              }
              .width('86%')
              .layoutWeight(1)
              .scrollBar(BarState.Off)
              .edgeEffect(EdgeEffect.Spring)
              .alignListItem(ListItemAlign.Center)
            }
            .width('100%')
            .height('100%')
            .padding({ top: 18, bottom: 18 })
          }
          .width('100%')
          .height('100%')
          .backgroundColor(Theme.bg)
        }
        .navDestination(this.demoPage)
        .hideTitleBar(true)
        .mode(NavigationMode.Stack)
        .width('100%')
        .height('100%')

        // Settings drawer toggle (drawn 3-line mark).
        Button({ type: ButtonType.Circle }) {
          Column({ space: 3 }) {
            this.bar(13, 2, 1, Theme.text)
            this.bar(13, 2, 1, Theme.text)
            this.bar(13, 2, 1, Theme.text)
          }
        }
        .width(26)
        .height(26)
        .backgroundColor(Theme.cardHi)
        .position({ x: '72%', y: '15%' })
        .onClick(() => { this.showSettings = true; })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Theme.bg)
    }
    .showSideBar(this.showSettings)
    .showControlButton(false)
    .sideBarWidth(180)
    .minSideBarWidth(150)
    .maxSideBarWidth(200)
    .sideBarPosition(SideBarPosition.Start)
    .onChange((value: boolean) => { this.showSettings = value; })
    .width('100%')
    .height('100%')
  }
}