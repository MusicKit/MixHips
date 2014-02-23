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
#import "FBLoginViewController.h"
#import "AFHTTPRequestOperationManager.h"

@interface AppDelegate()

@end

@implementation AppDelegate

@synthesize indicator;


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




- (void)transitionToViewController:(UIViewController *)viewController
                    withTransition:(UIViewAnimationOptions)transition
{
    [UIView transitionFromView:self.window.rootViewController.view
                        toView:viewController.view
                      duration:0.65f
                       options:transition
                    completion:^(BOOL finished){
                        self.window.rootViewController = viewController;
                    }];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"top_bAR.png"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:[[NSDictionary alloc]initWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor, nil]];

    [[UIToolbar appearance]setBackgroundImage:[UIImage imageNamed:@"bg.png"] forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
    [[UITabBar appearance] setBackgroundColor:[UIColor blackColor]];
    [[UITabBar appearance]setBarTintColor:[UIColor blackColor]];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    // Create a LoginUIViewController instance where we will put the login button
    FBLoginViewController *loginViewController = [[FBLoginViewController alloc] init];
    self.loginViewController = loginViewController;
    
    // Set loginUIViewController as root view controller
    [[self window] setRootViewController:loginViewController];
    
    //  self.window.backgroundColor = [UIColor clearColor];
    [self.window makeKeyAndVisible];
    
    
    // Whenever a person opens the app, check for a cached session
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        NSLog(@"Found a cached session");
        // If there's one, just open the session silently, without showing the user the login UI
        [FBSession openActiveSessionWithReadPermissions:@[@"basic_info",@"email"]
                                           allowLoginUI:NO
                                      completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                          // Handler for session state changes
                                          // This method will be called EACH time the session state changes,
                                          // also for intermediate states and NOT just when the session open
                                          [self sessionStateChanged:session state:state error:error];
                                      }];
        
        
        
        // If there's no cached session, we will show a login button
    } else {
        UIButton *loginButton = [self.loginViewController FBloginButton];
        [loginButton setAlpha:1.0];
        [loginButton setUserInteractionEnabled:YES];
    }
    return YES;
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    double index = [tabBarController.viewControllers indexOfObject:viewController];
    if ( 4 == index ) {
        
        NSLog(@"4 click");
        
        
        return NO;
    }
    return YES;
}

- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error
{
    // If the session was opened successfully
    if (!error && state == FBSessionStateOpen){
        NSLog(@"Session opened");
        // Show the user the logged-in UI
        [self userLoggedIn];
        
        return;
    }
    if (state == FBSessionStateClosed || state == FBSessionStateClosedLoginFailed){
        // If the session is closed
        NSLog(@"Session closed");
        // Show the user the logged-out UI
        [self userLoggedOut];
    }
    
    // Handle errors
    if (error){
        NSLog(@"Error");
        NSString *alertText;
        NSString *alertTitle;
        // If the error requires people using an app to make an action outside of the app in order to recover
        if ([FBErrorUtility shouldNotifyUserForError:error] == YES){
            alertTitle = @"Something went wrong";
            alertText = [FBErrorUtility userMessageForError:error];
            [self showMessage:alertText withTitle:alertTitle];
        } else {
            
            // If the user cancelled login, do nothing
            if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
                NSLog(@"User cancelled login");
                
                // Handle session closures that happen outside of the app
            } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession){
                alertTitle = @"Session Error";
                alertText = @"Your current session is no longer valid. Please log in again.";
                [self showMessage:alertText withTitle:alertTitle];
                
                // For simplicity, here we just show a generic message for all other errors
                // You can learn how to handle other errors using our guide: https://developers.facebook.com/docs/ios/errors
            } else {
                //Get more error information from the error
                NSDictionary *errorInformation = [[[error.userInfo objectForKey:@"com.facebook.sdk:ParsedJSONResponseKey"] objectForKey:@"body"] objectForKey:@"error"];
                
                // Show the user an error message
                alertTitle = @"Something went wrong";
                alertText = [NSString stringWithFormat:@"Please retry. \n\n If the problem persists contact us and mention this error code: %@", [errorInformation objectForKey:@"message"]];
                [self showMessage:alertText withTitle:alertTitle];
            }
        }
        // Clear this token
        [FBSession.activeSession closeAndClearTokenInformation];
        // Show the user the logged-out UI
        [self userLoggedOut];
    }
}

// Show the user the logged-out UI
- (void)userLoggedOut
{
    UIButton *loginButton = [self.loginViewController FBloginButton];
    // UIButton *nvloginButton = [self.loginViewController NVLoginButton];
    [loginButton setUserInteractionEnabled:YES];
    //[nvloginButton setUserInteractionEnabled:YES];
    [loginButton setAlpha:1.0];
    //[nvloginButton setAlpha:1.0];
    
    // Confirm logout message
    [self showMessage:@"You're now logged out" withTitle:@""];
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"logout" object:self];
}

// Show the user the logged-in UI
- (void)userLoggedIn
{
    UIButton *loginButton = self.loginViewController.FBloginButton;
    [loginButton setUserInteractionEnabled:NO];
    [loginButton setAlpha:0];
    
    
    // Welcome
    
    [FBRequestConnection
     startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
         if (!error) {
             
             AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
             NSLog(@"%@",[[FBSession activeSession] accessTokenData]);
             [manager.operationQueue waitUntilAllOperationsAreFinished];
             NSDictionary *params = @{@"facebook_token": [[FBSession activeSession] accessTokenData]};
             
             [manager POST:@"http://mixhips.nowanser.cloulu.com/login_facebook" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
                 NSLog(@"JSON: %@", responseObject);
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"afterLogin" object:nil];
                 
             }failure:
              ^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog(@"Error:%@",error);
              }];
             //통신
             
             //self.myLoginTryNum = 0;
             
             //[self performSelector:@selector(whatShow)];
             
             
             
         }
     }];
    
    
    
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
    NSLog(@"%lu",    (unsigned long)[tabBarController.viewControllers indexOfObject:viewController]);
    NSLog(@"tabbar delegate");
}

- (void)whatShow {
    self.myLoginTryNum++;
    NSLog(@"%d", self.myLoginTryNum);
    if ([[self.myLoginInfo[@"result"] stringValue] isEqual: @"1"]) {
        if ([self.myLoginInfo[@"name"] isEqual:@"0"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"makeNic" object:nil];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"afterLogin" object:nil];
        }
    } else {
        if (self.myLoginTryNum == 5) {
            [FBSession.activeSession closeAndClearTokenInformation];
            NSLog(@"%@", self.myLoginInfo);
        } else {
            [self performSelector:@selector(whatShow) withObject:nil afterDelay:1];
        }
    }
}


// Show an alert message
- (void)showMessage:(NSString *)text withTitle:(NSString *)title
{
    [[[UIAlertView alloc] initWithTitle:title
                                message:text
                               delegate:self
                      cancelButtonTitle:@"OK!"
                      otherButtonTitles:nil] show];
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

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
//    BOOL wasHandled = [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
//    
//    // You can add your app-specific url handling code here if needed
//    
//    return wasHandled;
    return [FBSession.activeSession handleOpenURL:url];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    // Handle the user leaving the app while the Facebook login dialog is being shown
    // For example: when the user presses the iOS "home" button while the login dialog is active
    [FBAppCall handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
