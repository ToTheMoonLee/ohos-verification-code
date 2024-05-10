import { display } from '@kit.ArkUI'

@Entry
@Component
export struct VerificationCodeComponent {

  // 实际的输入的验证码的值
  @State realContent: string = ''
  // 最大可输入的验证码长度
  maxLength: number = 6
  // 用来绘制空白和横线，基数是空白blank，偶数是横线，cursor控件
  lineArray: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
  // 屏幕宽度
  displayWidth: number = 0
  // 横线的间隙
  slotWidthVP: number = 5
  // 横线长度
  lineWidthVP: number = 0
  // cursor闪烁需要的timer，每隔500毫秒闪烁一次
  timer: number = 0
  // 控制cursor的绘制
  @State isCursorShowing: boolean = false

  onTextChanged: (value:string)=> void = (value) => {}
  onTextComplete: (value:string)=> void = (value) => {}

  aboutToAppear(): void {
    // 获取屏幕宽度和绘制单位
    try {
      this.displayWidth = display.getDefaultDisplaySync().width
      let totalWidth = vp2px(this.slotWidthVP) * 5 + vp2px(this.lineWidthVP) * 6
      // 用户给定间隙和横线总长度大于屏幕长度
      if (totalWidth > this.displayWidth) {
        this.slotWidthVP = 5
        this.lineWidthVP = 50
      }
    } catch (exception) {
      console.error('Failed to obtain the default display object. Code: ' + JSON.stringify(exception))
    }
    this.startCountTimer()
  }

  // 界面消失时取消间隔定时
  aboutToDisappear(): void {
    clearInterval(this.timer)
  }

  /**
   * 开启500ms的cursor闪烁
   */
  startCountTimer() {
    this.timer = setInterval(() => {
      this.isCursorShowing = !this.isCursorShowing
    }, 500)
  }

  build() {
    Stack() {
      Row() {
        // 循环绘制横线、文字和cursor
        ForEach(this.lineArray, (item: number) => {
          if (item % 2 == 0) {
            this.cursorComponent(item / 2 - 1)
          } else {
            Blank()
              .width(this.slotWidthVP)
          }
        })
      }.width('100%')

      // 将输入框变透明
      TextInput({ placeholder: "", text: "" })
        .placeholderColor(Color.Transparent)
        .placeholderFont({ size: 15 })
        .fontColor(Color.Transparent)
        .caretColor(Color.Transparent)
        .fontSize(15)
        .type(InputType.Number)
        .maxLines(1)
        .maxLength(this.maxLength)
        .padding({ left: 0 })
        .backgroundColor(Color.Transparent)
        .selectionMenuHidden(true)
        .onChange((value: string) => {
          // 调用textChanged的回调
          if (value.length == this.maxLength) {
            this.onTextChanged(value)
            this.onTextComplete(value)
          } else {
            this.onTextChanged(value)
          }
          this.realContent = value
        })
        .width('100%')
        .height(50)
    }
    .width('100%')
    .height(50)
  }

  /**
   * 绘制输入验证码的小横线
   * @param showPos
   */
  @Builder
  cursorComponent(showPos: number) {
    Column() {
      Stack() {
        // 绘制文字
        if (showPos < this.realContent.length) {
          Text(this.realContent[showPos])
        }
        // 绘制cursor
        Line()
          .width(1)
          .height(30)
          .startPoint([0, 0])
          .endPoint([0, 20])
          .stroke(this.isCursorShowing && (this.realContent.length == showPos) ? Color.Black : Color.Transparent)
          .strokeWidth(1)
      }
      // 绘制横线
      Line()
        .width(this.lineWidthVP)
        .height(1)
        .startPoint([0, 0])
        .endPoint([this.lineWidthVP, 0])
        .stroke(Color.Black)
        .strokeWidth(1)
    }
  }
}

export declare interface TextChangedListener {
  /**
   * 输入/删除监听
   * @param changeText 输入/删除的字符
   */
  textChanged(changeText: string): void;

  /**
   * 输入完成
   * @param text 完成输入的文本
   */
  textCompleted(text: string): void;
}