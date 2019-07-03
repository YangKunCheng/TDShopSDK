# TDShopSDK iOS

README: [English](https://github.com/mobisummer/TDShopSDK/blob/master/README.md) | [中文](https://github.com/mobisummer/TDShopSDK/blob/master/README-zh.md)

## Installation

From CocoaPods

`pod 'TDShopSDK'`

## Examples(Swift)

###  `"import TDShopSDK"`

### 1.Initialization SDK
```
let config = TDConfig.config(appkey: "your appKey") { (isInitSuccess,errMsg) in
}
// You can show TDShopSDK's log ,if you set isDebug true.
config.isDebug = true
TDShopSDK.sdkInitialize(config: config)
```

### 2.URL SCHEME 

#### Step1：Add TDShopSDK scheme to Info.plist file 

scheme `tdshop`

#### Step2：Handle Applcation open url msg
```
func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
     return TDShopSDK.handleOpenUrl(url: url)
}
func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
     return TDShopSDK.handleOpenUrl(url: url)
}
```
#### Step3 Use DemoLink for Test

`tdshop://mytdshop.net/195221EF4498F6F0E1CC10C852843F2643C4168F181E443552C442C50939A437`

SDK will open a ViewController witch show the google page , if success!

### 3.TDImageADView 
#### TDImageADView need a  Appropriate ratio (width:height 1:1)
```
let WH:CGFloat = 100
let imageAdView = TDImageADView.init(frame: CGRect.init(x: 0, y: 0, width: WH, height: WH), viewId: "test_ios_icon_001")
self.view.addSubview(imageAdView)
```

### 4.TDCustomView 
#### 1.create a subclass of TDCustomView.
```
class CustomView: TDCustomView {
  //init
  override init(viewId: String, tags: [String]?) {
      super.init(viewId: viewId, tags: tags)
   }
   //handle click event
   @objc func click(button:UIButton){
        super.handleViewDidClick(button.tag)
    }
   func setupView(resources:[TDAdResourcesModel]) {
        //Creat your custom view 
   }
}
```
#### 2.Get ad resources then config your custom view.
```
TDShopSDK.getAdResourcesInfo(placementId: "placementId", tags: ["hat"]) { (resources) in
            
  self.customView = CustomView.init(viewId: self.placementIdTF.text ?? "", tags: tags2)
  self.customView?.frame = CGRect.init(x: 10, y: currY, width: UIScreen.main.bounds.size.width-20, height: 100)
  self.customView?.setupView(resources: resources)
  self.customView?.handleWhenViewAppear()
  self.view.addSubview(self.customView!)
}
```
