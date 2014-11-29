//
//  AppDelegate.m
//  TEQWIN_PROJECT
//
//  Created by Teqwin on 28/7/14.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//



#import <Parse/Parse.h>
#import "AppDelegate.h"

//#import "GAI.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    sleep(2);
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:255.0/255.0 green:208.0/255.0 blue:0.0/255.0 alpha:1.0]];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"footer_menu_bg_2.png"]];
             // Optional: automatically send uncaught exceptions to Google Analytics.
  //  [GAI sharedInstance].trackUncaughtExceptions = YES;
    
    // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
  //  [GAI sharedInstance].dispatchInterval = 20;
    
    // Optional: set Logger to VERBOSE for debug information.
  //  [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
    
    // Initialize tracker. Replace with your tracking ID.
   // [[GAI sharedInstance] trackerWithTrackingId:@"UA-56329849-2"];

    // Override point for customization after application launch.
    [Parse setApplicationId:@"DZyOo57JB5flWHtN8j96BeGwTtGu6wurtLO74BBK"
                  clientKey:@"DMmwJqTGIoxnQ67PdOxCLhukewvJzuDqEZA7PBgD"];
   
    // Register for Push Notifications before iOS 8
    [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                     UIRemoteNotificationTypeAlert |
                                                     UIRemoteNotificationTypeSound)];
    
    


    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    PFACL *defaultACL = [PFACL ACL];
    [defaultACL setPublicReadAccess:YES];
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    
    [currentInstallation saveInBackground];



    


    //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"background.jpg"]
                                     //  forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.0/255.0 green:0/255.0 blue:30.0/255.0 alpha:1.0]];
     //[[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8]];
     //  [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.755 green:0.655 blue:0.0 alpha:1]];
        NSShadow *shadow = [[NSShadow alloc] init];

   [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 1);
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
       
    return YES;
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    currentInstallation.channels = @[ @"global" ];
    [currentInstallation saveInBackground];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
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


@end
