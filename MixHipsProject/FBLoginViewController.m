//
//  FBLoginViewController.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 24..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "FBLoginViewController.h"
#import "AppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>
#import "HomeViewController.h"

@interface FBLoginViewController ()


@property (weak, nonatomic) IBOutlet UIView *joinView;
@property (weak, nonatomic) IBOutlet UITextField *myNicTextField;
@property (weak, nonatomic) IBOutlet UILabel *myNicInfoLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *doingLogin;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@end

@implementation FBLoginViewController {
    AppDelegate *_appDlg;
    // UIScrollView *_scrollView;
    
    
}


- (IBAction)loginBtn:(id)sender {
    if (FBSession.activeSession.state == FBSessionStateOpen
        || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
        
        // Close the session and remove the access token from the cache
        // The session state handler (in the app delegate) will be called automatically
        [FBSession.activeSession closeAndClearTokenInformation];
        
        // If the session state is not any of the two "open" states when the button is clicked
    } else {
        // Open a session showing the user the login UI
        // You must ALWAYS ask for basic_info permissions when opening a session
        [FBSession openActiveSessionWithReadPermissions:@[@"basic_info", @"email"]
                                           allowLoginUI:YES
                                      completionHandler:
         ^(FBSession *session, FBSessionState state, NSError *error) {
             
             // Retrieve the app delegate
             AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
             // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
             [appDelegate sessionStateChanged:session state:state error:error];
         }];
    }
    
}



- (void)afterLoggedIn {
    // get DEVICE_TOKEN for push..
    // 얻기 완료/실패 후 처리는 앱델리깃
    NSLog(@"come");
    
    
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HomeViewController *VC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"mainVC"];
    
    VC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:VC animated:YES completion:nil];
    
  
    
}

- (void)logout {
    FBLoginViewController *loginViewController = [[FBLoginViewController alloc] init];
    
    [loginViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:loginViewController animated:YES completion:nil];
    [FBSession.activeSession closeAndClearTokenInformation];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.scroll];
    [self.view addSubview:self.FBloginButton];
   
    
    
    _appDlg = [UIApplication sharedApplication].delegate;
    [self.doingLogin startAnimating];
    
    NSNotificationCenter *noti = [NSNotificationCenter defaultCenter];
    [noti addObserver:self selector:@selector(afterLoggedIn) name:@"afterLogin" object:nil];
//    [noti addObserver:self selector:@selector(makeNicname) name:@"makeNic" object:nil];
    [noti addObserver:self selector:@selector(logout) name:@"logout" object:nil];
    
    self.joinView.layer.cornerRadius = 8.0;
    self.joinView.layer.masksToBounds = YES;
    self.joinView.alpha = 0;
    
}

- (void)viewDidUnload {
    [[NSNotificationCenter defaultCenter] removeObserver:@"afterLogin"];
    [[NSNotificationCenter defaultCenter] removeObserver:@"makeNic"];
}



@end
