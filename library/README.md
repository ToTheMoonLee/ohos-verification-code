# verification-code

verification-code 是一个验证码输入的组件

## 简介
项目基于harmonyOS api11 开发，由于在官方没有找到相关的输入验证码的组件，所以自己开发了一个，方便大家使用。
效果如下：

![verification_code.gif](..%2Fimages%2Fverification_code.gif)

## 仓库地址

`地址：[verification_code](https://github.com/ToTheMoonLee/ohos-verification-code)，如果觉得对您的开发有帮助，欢迎star。当然如果对本项目有任何问题，feel free to make issues。
`
## 下载安装

```shell
ohpm install verification_code
```

## 使用方式

代码如下，直接引用VerificationCodeComponent。参数如下：

| 参数        | 说明             |
|-----------|----------------|
| slotWidthVP    | 验证码横线间隙，单位是vp  |
| lineWidthVP | 验证码横线长度，单位是vp  |
| onTextChanged | 输入验证码时，文字变化的回调 |
| onTextComplete | 输入验证码时，输入结束的回调 |

```javascript
VerificationCodeComponent({
    slotWidthVP: 10, lineWidthVP: 50,
    onTextChanged: (value) => {
        console.log("onTextChanged ------> " + value)
    },
    onTextComplete: (value) => {
        console.log("onTextComplete ------> " + value)
    }
}) 
```

## TODO

这个验证码的组件还是一个简单版本，但是希望能为各位开发者减轻负担，提供思路，并能为鸿蒙的发展贡献一点微薄之力。

