//
//  AppDelegate.swift
//  TDShopSDKDemo-iOS
//
//  Created by mac on 2019/6/1.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import TDShopSDK

#if canImport(UserNotifications)
import UserNotifications
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        
        //初始化SDK
        let config = TDConfig.config(appkey: "demoMyshop") { (isInitSuccess,errMsg) in
            
        }
        config.isDebug = true
        TDShopSDK.sdkInitialize(config: config)
        
        //iOS10之后设置推送代理，实现代理方法。
        self.registNoti()
        
        let navi = UINavigationController.init(rootViewController: TDShopSDKDemoListVC())
        self.window?.rootViewController = navi
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    
    // 深层链接
    
    // 测试链接 tdshop://mytdshop.net/195221EF4498F6F0E1CC10C852843F2643C4168F181E443552C442C50939A437
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
       
        let canHandleUrl = TDShopSDK.handleOpenUrl(url: url)
        
        return canHandleUrl
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let canHandleUrl = TDShopSDK.handleOpenUrl(url: url)
        
        return canHandleUrl
    }
    
    
    
}

// SDK本地推送
extension AppDelegate:UNUserNotificationCenterDelegate{
    
    
    func registNoti() {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        }
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        
        // SDK是否能处理该通知
        if TDShopSDK.canHandleLocalPushNoti(info: notification.request.content.userInfo) {
            completionHandler([.alert])
        }else{
            // 处理自己APP的逻辑
            
        }
    }
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        // SDK尝试处理次通知
        let handle  = TDShopSDK.handleLocalPushNoti(info: response.notification.request.content.userInfo)
        if !handle {
            // 处理自己APP的逻辑
        }
        completionHandler()
    }
    

}

