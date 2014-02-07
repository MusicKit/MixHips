//
//  AppDelegate.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 1. 13..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "AppDelegate.h"

#import <FacebookSDK/FacebookSDK.h>
#import <Parse/Parse.h>

@interface AppDelegate()

@end

@implementation AppDelegate



//백그라운드에서 음악 재생 유지...
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    __block UIBackgroundTaskIdentifier task = 0;
    task=[application beginBackgroundTaskWithExpirationHandler:^{
        NSLog(@"Expiration handler called %f",[application backgroundTimeRemaining]);
        [application endBackgroundTask:task];
        task=UIBackgroundTaskInvalid;
    }];
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    // Call FBAppCall's handleOpenURL:sourceApplication to handle Facebook app responses
    BOOL wasHandled = [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
    
    // You can add your app-specific url handling code here if needed
    
    return wasHandled;
}
/* 페이스북... 연동
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [Parse setApplicationId:@"T4JC47GMzVl5a19lIQokMxxE8Nx5WheSeptT8346"
                  clientKey:@"UIrh8jLMhDnpuxfSM11bVQyuvNqUmaqnfWHqCUY9"];
    
    [PFFacebookUtils initializeFacebook];
    return YES;
}
 */


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    // Override point for customization after application launch.
    return YES;
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
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
