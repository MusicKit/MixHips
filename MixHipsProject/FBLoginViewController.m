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
#import "AFHTTPRequestOperationManager.h"

@interface FBLoginViewController ()<UITextFieldDelegate>



@end

@implementation FBLoginViewController {
    AppDelegate *_appDlg;
}

-(IBAction)nextButton:(id)sender{
    self.agreeView.hidden  = YES;
    self.agreeView2.hidden = NO;
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
             self.agreeView2.hidden = YES;
             self.agreeView3.hidden = NO;

             // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
             [appDelegate sessionStateChanged:session state:state error:error];
         }];
    }
}





- (void)afterLoggedIn {
    // get DEVICE_TOKEN for push..
    // 얻기 완료/실패 후 처리는 앱델리깃
    NSLog(@"come");
    if([_appDlg.pre_login isEqualToString:@"true"]){
        if([_appDlg.user_name isEqualToString:@""]){
            self.agreeView3.hidden = NO;
            self.agreeView2.hidden = YES;
        }
        else{
                UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                HomeViewController *VC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"mainVC"];
            
                VC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            
            [self presentViewController:VC animated:YES completion:nil];
        }
    }
    
    

    
  
    
}

- (void)logout {
    FBLoginViewController *loginViewController = [[FBLoginViewController alloc] init];
    
    [loginViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:loginViewController animated:YES completion:nil];
    [FBSession.activeSession closeAndClearTokenInformation];
    
}


//-(BOOL)textFieldShouldReturn:(UITextField *)textField{
//    if(self.textField.text.length >0){
//        [self AFNetworkingSearchListInputComment:self.textField.text];
//        self.hideView.hidden = YES;
//        self.textField.text = @"";
//        [self.textField resignFirstResponder];
//    }
//    else{
//        self.hideView.hidden = YES;
//        [self.textField resignFirstResponder];
//    }
//    return YES;
//}
//

-(void)AFNetworkingAlbum{
//    [indicator startAnimating];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"foo":@"bar", @"user_id":_appDlg.user_id, @"user_name":self.nickTextField.text};
    [manager POST: @"http://mixhips.nowanser.cloulu.com/check_user_name" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"JSON: %@", responseObject);
//        [indicator stopAnimating];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
//        [indicator stopAnimating];
//        self.networkView.hidden = NO;
    }];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.agreeView.hidden = YES;
    self.agreeView2.hidden = YES;
    self.agreeView3.hidden = YES;
   
    
    
    _appDlg = [UIApplication sharedApplication].delegate;
    
    NSNotificationCenter *noti = [NSNotificationCenter defaultCenter];
    [noti addObserver:self selector:@selector(afterLoggedIn) name:@"afterLogin" object:nil];
//    [noti addObserver:self selector:@selector(makeNicname) name:@"makeNic" object:nil];
    [noti addObserver:self selector:@selector(logout) name:@"logout" object:nil];
    
    
    
}

- (void)viewDidUnload {
    [[NSNotificationCenter defaultCenter] removeObserver:@"afterLogin"];
    [[NSNotificationCenter defaultCenter] removeObserver:@"makeNic"];
}



@end
