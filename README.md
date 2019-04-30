# TDShopSDK iOS

## Installation【安装】

From CocoaPods【使用CocoaPods】

`pod 'TDShopSDK'`

## Examples【示例】(Swift)

###  `"import TDShopSDK"`

### 1.Initialization SDK【初始化SDK】
```
let config = TDConfig.config(appkey: "your appKey") { (isInitSuccess,errMsg) in
}
// You can show TDShopSDK's log ,if you set isDebug true.
config.isDebug = true
TDShopSDK.sdkInitialize(config: config)
```

### 2.URL SCHEME 【深层链接】

#### Step1：Add TDShopSDK scheme to Info.plist file 【将TDShopSDK的scheme加入到Info.plist文件中】

scheme `tdshop`

#### Step2：Handle Applcation open url msg【处理APP打开URL的消息】
```
func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
     return TDShopSDK.handleOpenUrl(url: url)
}
func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
     return TDShopSDK.handleOpenUrl(url: url)
}
```
#### Step3 Use DemoLink for Test【使用测试链接进行测试】

`tdshop://mytdshop.net/195221EF4498F6F0E1CC10C852843F2643C4168F181E443552C442C50939A437`

SDK will open a ViewController witch show the google page , if success!

### 3.TDIconView 
#### TDIconView need a  Appropriate ratio (width:height 1:1)【TDIconView 需要一个合适的宽高比（宽：高 1:1）】
```
let WH:CGFloat = 100
let iconView = TDIconView.init(frame: CGRect.init(x: 0, y: 0, width: WH, height: WH))
self.view.addSubview(iconView)
```

### 4.TDBannerView 
#### TDBannerView need a  Appropriate ratio (width:height 720:372)【TDBannerView 需要一个合适的宽高比（宽：高 720:372）】
```
let W:CGFloat = 300
let H:CGFloat = W * 372/720.0
let iconView = TDIconView.init(frame: CGRect.init(x: 0, y: 0, width: W, height: H))
self.view.addSubview(iconView)
```

### 5.Show Interstitial 【弹出插屏广告】

```
TDShopSDK.showInterstitialView()

```

        
    



















