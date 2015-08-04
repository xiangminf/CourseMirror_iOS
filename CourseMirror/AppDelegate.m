//
//  AppDelegate.m
//  CourseMirror
//
//  Created by 童罡正 on 7/30/15.
//  Copyright (c) 2015 Gangzheng Tong. All rights reserved.
//

#import "AppDelegate.h"
#import "UIColor+PDD.h"
#import "GZTLoginViewController.h"
#import "GZTCourseViewController.h"
#import "GZTSettingViewController.h"
#import <Parse/Parse.h>
#import "LibraryAPI.h"
#import "GZTGlobalModule.h"
#import "GZTUtilities.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@property (strong, nonatomic) GZTLoginViewController *loginViewController;
@property (strong, nonatomic) GZTSettingViewController *settingViewController;
@property (strong, nonatomic) GZTCourseViewController *courseViewController;

@property (strong, nonatomic) UIViewController *savedViewController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    // [Optional] Power your app with Local Datastore. For more info, go to
    // https://parse.com/docs/ios_guide#localdatastore/iOS
    [Parse enableLocalDatastore];
    
    // Initialize Parse.
    [Parse setApplicationId:@"c4Fz5plueUVfkqQ19vY9UI5xuzfzzflwWa2QiDjn"
                  clientKey:@"mdLEt9R4Eyb6Z9OVdO9UsNTFrnuVahX7hOQwGeBL"];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    
    //init root controller
    GZTCourseViewController *courseViewController = [[GZTCourseViewController alloc] init];
    UINavigationController *courseNavViewController = [[UINavigationController alloc] initWithRootViewController:courseViewController];
    [courseNavViewController.navigationBar setTranslucent:NO];
    
    GZTSettingViewController *settingViewController = [[GZTSettingViewController alloc] init];
    self.settingViewController = settingViewController;
    UINavigationController *settingsNavViewController = [[UINavigationController alloc] initWithRootViewController:settingViewController];
    [settingsNavViewController.navigationBar setTranslucent:NO];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[courseNavViewController,
                                              settingsNavViewController
                                              ];
    self.tabBarController.delegate = self;
    [self.tabBarController.tabBar setTranslucent:YES];
    
    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];

    // download data in advance
    NSArray *cs = [[LibraryAPI sharedInstance] getCourses];
    [[LibraryAPI sharedInstance] getLectures];
    [[LibraryAPI sharedInstance] getQuestions];

    
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    UINavigationController *navController = (UINavigationController *)viewController;
    UIViewController *visibleViewController = [navController visibleViewController];
    
    
    // Save currently visible view controller for follow-on checks
    self.savedViewController = visibleViewController;
}

- (void)_customizeAppearance {
    [[UIPageControl appearance] setPageIndicatorTintColor:[UIColor lightGrayColor]];
    [[UIPageControl appearance] setCurrentPageIndicatorTintColor:[UIColor pddTextColor]];
    [[UIPageControl appearance] setBackgroundColor:[UIColor clearColor]];
    
    [[UINavigationBar appearance] setTintColor:[UIColor pddTextColor]];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init]
                                      forBarPosition:UIBarPositionAny
                                          barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    [[UITabBar appearance] setTintColor:[UIColor blackColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
}


@end
