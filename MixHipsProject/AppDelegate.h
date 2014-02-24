//
//  AppDelegate.h
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 1. 13..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "FBLoginViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    UIActivityIndicatorView * indicator;
}
@property (nonatomic, retain) UIActivityIndicatorView * indicator;
@property (strong, nonatomic) UIWindow *window;
@property (weak, nonatomic) UIButton *login;
@property (strong) NSString *user_id;
@property (strong)     NSString *user_name;
@property (strong)     NSString *pre_login;
@property NSDictionary *myLoginInfo;
@property NSDictionary *foodInfo;
@property int myLoginTryNum;
@property (strong, nonatomic) FBLoginViewController *loginViewController;
@property NSString *whatMainCate;

- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error;
- (void)userLoggedIn;
- (void)userLoggedOut;
-(void)agreeView;


@property AVAudioPlayer *player;

-(void)callIndicator;
-(void)hideIndicator;
@end
