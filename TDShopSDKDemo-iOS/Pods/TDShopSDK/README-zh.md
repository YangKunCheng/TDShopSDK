# TDShopSDK iOS

README: [English](https://github.com/mobisummer/TDShopSDK/blob/master/README.md) | [中文](https://github.com/mobisummer/TDShopSDK/blob/master/README-zh.md)

## 安装
  
使用CocoaPods
  
`pod 'TDShopSDK'`
  
## 示例(Swift)
  
###  `"import TDShopSDK"`
  
### 1.初始化SDK
```
let config = TDConfig.config(appkey: "your appKey") { (isInitSuccess,errMsg) in
}
// You can show TDShopSDK's log ,if you set isDebug true.
config.isDebug = true
TDShopSDK.sdkInitialize(config: config)
```
  
### 2.深层链接
  
#### 第一步： 将TDShopSDK的scheme加入到Info.plist文件
  
scheme `tdshop`
  
#### 第二步：处理APP打开URL的消息
```
func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
     return TDShopSDK.handleOpenUrl(url: url)
}
func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    return TDShopSDK.handleOpenUrl(url: url)
}
```
#### 第三步: 使用测试链接进行测试
  
`tdshop://mytdshop.net/195221EF4498F6F0E1CC10C852843F2643C4168F181E443552C442C50939A437`
  
如果成功SDK会弹出控制器打开谷歌首页
  
### 3.TDIconView 
#### TDIconView 需要一个合适的宽高比（宽：高 1:1）
```
let WH:CGFloat = 100
let iconView = TDIconView.init(frame: CGRect.init(x: 0, y: 0, width: WH, height: WH), viewId: "test_ios_icon_001")
self.view.addSubview(iconView)
```
#### 在viewWillAppear方法里添加如下代码
```
override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.iconView.handleWhenViewAppear()
}
```
  
### 4.TDBannerView 
#### TDBannerView 需要一个合适的宽高比（宽：高 720:372）
```
let W:CGFloat = 300
let H:CGFloat = W * 372/720.0
let bannerView = TDBannerView.init(frame: CGRect.init(x: 0, y: 0, width: W, height: H), viewId: "test_ios_banner_001")
self.view.addSubview(bannerView)
```
#### 在viewWillAppear方法里添加如下代码
```
override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.bannerView.handleWhenViewAppear()
}
```

### 5.TDCustomView 
#### 1.创建一个TDCustomView子类
```
class CustomView: TDCustomView {
  //初始化
  override init(viewId: String, tags: [String]?) {
      super.init(viewId: viewId, tags: tags)
   }
   //事件点击的处理
   @objc func click(button:UIButton){
        super.handleViewDidClick(button.tag)
    }
   func setupView(resources:[TDAdResourcesModel]) {
        //创建你的自定义视图   
   }
}
```
#### 2.获取广告素材，配置视图
```
TDShopSDK.getAdResourcesInfo(placementId: "placementId", tags: ["hat"]) { (resources) in
            
  self.customView = CustomView.init(viewId: self.placementIdTF.text ?? "", tags: tags2)
  self.customView?.frame = CGRect.init(x: 10, y: currY, width: UIScreen.main.bounds.size.width-20, height: 100)
  self.customView?.setupView(resources: resources)
  self.customView?.handleWhenViewAppear()
  self.view.addSubview(self.customView!)
}
```
#### 3.在viewWillAppear方法里添加如下代码
```
override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.customView?.handleWhenViewAppear()
}
```

### 6.本地推送配置

#### 第一步： 注册推送服务
```
if #available(iOS 10.0, *) {
    UNUserNotificationCenter.current().delegate = self
}
```
#### 第二步： 处理本地推送消息（SDK会在适当的时机给用户推送消息）
```
@available(iOS 10.0, *)
func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
{
    if TDShopSDK.canHandleLocalPushNoti(info: notification.request.content.userInfo) {
        completionHandler([.alert])
    }
}
@available(iOS 10.0, *)
func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
  TDShopSDK.handleLocalPushNoti(info: response.notification.request.content.userInfo)
  completionHandler()
}

```




















