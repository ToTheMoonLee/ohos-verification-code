import {VerificationCodeComponent } from '../../../../../library/src/main/ets/components/VerificationCodeComponent'
@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    Row() {
      Column() {
        VerificationCodeComponent({
          slotWidthVP: 10, lineWidthVP: 50,
          onTextChanged: (value) => {
            console.log("onTextChanged ------> " + value)
          },
          onTextComplete: (value) => {
            console.log("onTextComplete ------> " + value)
          }
        })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .height('100%')
  }
}