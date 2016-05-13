//
//  AppDelegate.swift
//  live
//
//  Created by chenpeiwei on 3/4/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var tabBarController:PPTabBarController = PPTabBarController()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        

        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        

        
        setupRealmMigration()
        
        print("PPUserModel.shareInstance \(PPUserModel.shareInstance)")
            
        if PPUserModel.shareInstance.login == false {
            self.tabBarController.presentViewController(PPLoginViewController(), animated: false, completion: nil)
        }
        
        
        MonkeyKing.registerAccount(MonkeyKing.Account.WeChat(appID: ShareConfigs.Wechat.appID, appKey: ShareConfigs.Wechat.appKey))
        MonkeyKing.registerAccount(MonkeyKing.Account.Weibo(appID: ShareConfigs.Weibo.appID, appKey: ShareConfigs.Weibo.appKey, redirectURL: ShareConfigs.Weibo.redirectURL))
        MonkeyKing.registerAccount(MonkeyKing.Account.QQ(appID: ShareConfigs.QQ.appID))
        
        
        
        let token = "OHvNZQPCl8d9xFBV6hYuyn3KWcePBCPg0uDKhMccdAOuTDtWZugh9AtgyVimggIZaZtCVyTc8sWNAeH0EzC2oA=="

        //连接融云服务器
        RCIM.sharedRCIM().connectWithToken(token,
                                           success: { (userId) -> Void in
                                            print("登陆成功。当前登录的用户ID：\(userId)")
                                            
                                            //设置当前登陆用户的信息
                                            RCIM.sharedRCIM().currentUserInfo = RCUserInfo.init(userId: userId, name: "我的名字", portrait: "http://www.rongcloud.cn/images/newVersion/logo/baixing.png")
                                            
                                            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                                                //打开会话列表
//                                                let chatListView = DemoChatListViewController()
//                                                self.navigationController?.pushViewController(chatListView, animated: true)
                                            })
            }, error: { (status) -> Void in
                print("登陆的错误码为:\(status.rawValue)")
            }, tokenIncorrect: {
                //token过期或者不正确。
                //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
                //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
                print("token错误")
        })

        
        return true
    }
    
    func setupRealmMigration() {
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 2,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
        })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        
    }

    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        
        if MonkeyKing.handleOpenURL(url) {
            return true
        }
        
        return false
    }
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }





}

