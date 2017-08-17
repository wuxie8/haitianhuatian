//
//  AppDelegate.m
//  haitianhuatian
//
//  Created by Admin on 2017/8/11.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "BaseNC.h"
#import "MineViewController.h"
#import "HomePageViewController.h"
#import "BBSViewController.h"
#import <AdSupport/AdSupport.h>
#import "UMMobClick/MobClick.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kIsLogin"]) {
        //读取用户信息
        Context.currentUser = [NSKeyedUnarchiver unarchiveObjectWithFile:DOCUMENT_FOLDER(@"loginedUser")];
    }
    [self umConfigInstance];
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"FirstLG"]){
        
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
                           [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString],@"idfa",
                           @"1.0.0",@"mac",
                           appNo,@"channel",
                           nil];
        [[NetWorkManager sharedManager]postJSON:[NSString stringWithFormat:@"%@&m=toutiao&a=activate",SERVERE] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
            
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@",error);
            
            
        }];
    }
    self.window  = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController=[AppDelegate setTabBarController];
    
    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    return YES;
}
-(void)umConfigInstance{
    UMConfigInstance.appKey = @"5992c6cf4544cb5fbe00150d";
    UMConfigInstance.channelId = @"App Store";
  
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
}
+(UITabBarController *)setTabBarController
{
    
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"FirstLG"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
//    HomePageViewController *homepage = [[HomePageViewController alloc] init]; //未处理
//    LoadSupermarketViewController *treatVC = [[LoadSupermarketViewController alloc] init]; //已处理
//    FastHandleCardViewController *mine=[[FastHandleCardViewController alloc]init];
//    RemindViewController *remind=[RemindViewController new];
//    PersonCenterViewController *person=[[PersonCenterViewController alloc]init];
//    JishiyuViewController *jishiyu=[JishiyuViewController new];
//    //步骤2：将视图控制器绑定到导航控制器上
//    __unused   BaseNC *nav1C = [[BaseNC alloc] initWithRootViewController:homepage];
//    BaseNC *nav2C = [[BaseNC alloc] initWithRootViewController:treatVC];
//    BaseNC *nav3C=[[BaseNC alloc]initWithRootViewController:mine];
//    BaseNC *nav4C=[[BaseNC alloc]initWithRootViewController:person];
//    __unused   BaseNC *nav5C=[[BaseNC alloc]initWithRootViewController:remind];
//    BaseNC *nav6C=[[BaseNC alloc]initWithRootViewController:jishiyu];
//
    MineViewController *person=[[MineViewController alloc]init];
    HomePageViewController *homepage=[HomePageViewController new];
    LoginViewController *login=[LoginViewController new];
    BBSViewController *bbs=[BBSViewController new];
    BaseNC *nav5C=[[BaseNC alloc]initWithRootViewController:bbs];

  __unused  BaseNC *nav6C=[[BaseNC alloc]initWithRootViewController:login];
    BaseNC *nav7C=[[BaseNC alloc]initWithRootViewController:person];
    BaseNC *nav8C=[[BaseNC alloc]initWithRootViewController:homepage];

    UITabBarController *tabBarController=[[UITabBarController alloc]init];
    //改变tabBar的背景颜色
    UIView *barBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 49)];
    barBgView.backgroundColor = [UIColor whiteColor];
    [tabBarController.tabBar insertSubview:barBgView atIndex:0];
    tabBarController.tabBar.opaque = YES;
    
    tabBarController.viewControllers=@[nav8C,nav5C,nav7C];
    tabBarController.selectedIndex = 0; //默认选中第几个图标（此步操作在绑定viewControllers数据源之后）
    NSArray *titles = @[@"首页",@"论坛",@"个人中心",@"个人中心"];
    NSArray *images=@[@"HomePage",@"BBS",@"Mine",@"PersonCenter"];
    NSArray *selectedImages=@[@"HomePageYellow",@"BBSYelllow",@"MineYellow",@"PersonCenterHeight"];
    //               NSArray *titles = @[@"简单借款秒借版",@"个人中心",@"设置"];
    //        NSArray *images=@[@"lending",@"Mineing"];
    //         NSArray *selectedImages=@[@"lendingBlue",@"MineingBlue"];
    
    //绑定TabBar数据源
    for (int i = 0; i<tabBarController.tabBar.items.count; i++) {
        UITabBarItem *item = (UITabBarItem *)tabBarController.tabBar.items[i];
        item.title = titles[i];
        item.image = [[UIImage imageNamed:[images objectAtIndex:i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [[UIImage imageNamed:[selectedImages objectAtIndex:i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        tabBarController.tabBar.tintColor = kColorFromRGBHex(0xed6c3e);
    }
    return  tabBarController;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
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
