# TDShopSDK iOS

## Installation【安装】

From CocoaPods【使用CocoaPods】

`pod 'TDShopSDK'`


## Examples【示例】(Swift)

###  `"import TDShopSDK"`

### 1.Initialization SDK【初始化SDK】

`let config = TDConfig.config(appkey: "your appKey") { (isInitSuccess,errMsg) in
}
 config.isDebug = true
        
 TDShopSDK.sdkInitialize(config: config)
`












