//
//  AppDelegate.m
//  果壳
//
//  Created by 李旺 on 2016/12/13.
//  Copyright © 2016年 我赢. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "LeftViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    LeftViewController*leftvc=[[LeftViewController alloc]init];
    UINavigationController*nav=[[UINavigationController alloc]initWithRootViewController:[[HomeViewController alloc]init]];
    
    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:nav leftMenuViewController:leftvc rightMenuViewController:nil];
    sideMenuViewController.scaleContentView=NO;
    sideMenuViewController.contentViewInPortraitOffsetCenterX=50;
    sideMenuViewController.contentViewShadowColor=[UIColor blackColor];
    self.window.rootViewController=sideMenuViewController;
    
    [self.window makeKeyAndVisible];
    [self afn];
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    
    
    // 获取友盟social版本号
    //NSLog(@"UMeng social version: %@", [UMSocialGlobal umSocialSDKVersion]);
    
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"581bdd3f5312dd97d8003429"];
    //设置新浪的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3310639731"  appSecret:@"90e898cb41ba77c573bbc1e2e4f93412" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    return YES;
}

    // 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}
-(void)afn
{
    //1.创建网络状态监测管理者
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    
    //2.监听改变
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                //没网提示
                //[SVProgressHUD showErrorWithStatus:@"没有网络"];
                [SVProgressHUD showProgress:INT_MAX status:@"没有网络"];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"3G|4G");
                [SVProgressHUD showInfoWithStatus:@"使用流量哦"];
                //取消提示
                //[SVProgressHUD dismiss];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi");
                //取消提示
                [SVProgressHUD dismiss];
                break;
            default:
                break;
        }
    }];
    
    [manger startMonitoring];
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
