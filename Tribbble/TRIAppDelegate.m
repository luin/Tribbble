//
//  TRIAppDelegate.m
//  Tribbble
//
//  Created by Zihua Li on 1/15/14.
//  Copyright (c) 2014 Zihua Li. All rights reserved.
//

#import "TRIAppDelegate.h"
#import "Controllers/TRIShotsViewController.h"
#import "Controllers/TRIFeedsTableViewController.h"
#import "Controllers/TRISettingTableViewController.h"

@implementation TRIAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    [tabBarController setViewControllers:@[[self createTabWithClass:[TRIShotsViewController class]
                                                              title:@"debuts"],
                                           [self createTabWithClass:[TRIShotsViewController class]
                                                              title:@"popular"],
                                           [self createTabWithClass:[TRIFeedsTableViewController class]
                                                              title:@"following"],
                                           [self createTabWithClass:[TRIShotsViewController class]
                                                              title:@"everyone"],
                                           [self createTabWithClass:[TRISettingTableViewController class]
                                                              title:@"setting"]
                                           ]];
    [tabBarController.view setTintColor:[UIColor colorWithRed:0.918 green:0.298 blue:0.537 alpha:1.0]];
    self.window.rootViewController = tabBarController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (id)createTabWithClass:(Class)class
                   title:(NSString *)title
{
    UIViewController *vc = [[class alloc] initWithNibName:nil bundle:nil];
    vc.title = [title capitalizedString];
    vc.tabBarItem.image = [UIImage imageNamed:title];
    
    UINavigationController *nvc = [[UINavigationController alloc]
                                   initWithRootViewController:vc];
    return nvc;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
