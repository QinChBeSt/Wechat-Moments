//
//  AppDelegate.m
//  Wechat-Moments
//
//  Created by 钱程 on 2018/3/1.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "AppDelegate.h"
//VC
#import "WeChatViewController.h"
#import "AddressbookViewController.h"
#import "DiscoverViewController.h"
#import "MineViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //1.创建Window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    //a.初始化一个tabBar控制器
    UITabBarController *tabbar=[[UITabBarController alloc]init];
    
    //设置控制器为Window的根控制器
    self.window.rootViewController=tabbar;
    //设置tabBar颜色
   tabbar.tabBar.tintColor = [UIColor colorWithRed:24/255.0 green:164/255.0 blue:13/255.0 alpha:1];
    
    WeChatViewController *weChatVC = [[WeChatViewController alloc]init];
    weChatVC.title = @"微信";
    weChatVC.tabBarItem.title=@"微信";
    weChatVC.tabBarItem.image=[UIImage imageNamed:@"discover"];
    weChatVC.tabBarItem.selectedImage = [UIImage imageNamed:@"discoverSelect"];
    UINavigationController * weChatNavi = [[UINavigationController alloc]initWithRootViewController:weChatVC];
    [tabbar addChildViewController:weChatNavi];
    
    AddressbookViewController *addressbookVC = [[AddressbookViewController alloc]init];
    addressbookVC.title = @"通讯录";
    addressbookVC.tabBarItem.title=@"通讯录";
    addressbookVC.tabBarItem.image=[UIImage imageNamed:@"addressbook"];
    addressbookVC.tabBarItem.selectedImage = [UIImage imageNamed:@"addressbookSelect"];
    UINavigationController * addressNavi = [[UINavigationController alloc]initWithRootViewController:addressbookVC];
    [tabbar addChildViewController:addressNavi];
    
    DiscoverViewController *discoverVC = [[DiscoverViewController alloc]init];
    discoverVC.title = @"发现";
    discoverVC.tabBarItem.title=@"发现";
    discoverVC.tabBarItem.image=[UIImage imageNamed:@"discover"];
    discoverVC.tabBarItem.selectedImage = [UIImage imageNamed:@"discoverSelect"];
    UINavigationController * discoverNavi = [[UINavigationController alloc]initWithRootViewController:discoverVC];
    [tabbar addChildViewController:discoverNavi];
    
    MineViewController *mineVC = [[MineViewController alloc]init];
    mineVC.title = @"我的";
    mineVC.tabBarItem.title=@"我的";
    mineVC.tabBarItem.image=[UIImage imageNamed:@"mine"];
    mineVC.tabBarItem.selectedImage = [UIImage imageNamed:@"mineS"];
    UINavigationController * mineNavi = [[UINavigationController alloc]initWithRootViewController:mineVC];
    [tabbar addChildViewController:mineNavi];
    return YES;
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
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Wechat_Moments"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
