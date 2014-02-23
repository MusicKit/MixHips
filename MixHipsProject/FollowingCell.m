//
//  FollowingCell.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 12..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "FollowingCell.h"
#import "UIImageView+AFNetworking.h"
#import "AFHTTPRequestOperationManager.h"
#import "FollowViewController.h"


@implementation FollowingCell{
    FollowViewController *followVC;
    NSString *user_id;
}

- (void) setPlaylistInfo:(AlbumList *)list
{
    self.userName.text = list.user_Name;
    NSString *url = @"http://mixhips.nowanser.cloulu.com";
    url  = [url stringByAppendingString:list.user_img];
    NSURL *imgURL = [NSURL URLWithString:url];
    NSLog(@"dfdf%@",imgURL);
    [self.userImg setImageWithURL:imgURL];
    user_id = list.user_id;

    
}

-(IBAction)following:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"MixHips" message:@"해제하시겠습니까?" delegate:self cancelButtonTitle:@"취소" otherButtonTitles:@"확인", nil];
    alert.alertViewStyle = UIAlertViewStyleDefault;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
        if(alertView.cancelButtonIndex == buttonIndex){
            NSLog(@"취소");
        }
        else if(alertView.firstOtherButtonIndex == buttonIndex){
            [self AFNetworkingADFollow];
            NSLog(@"fff%@",user_id);
        }
}

-(void)AFNetworkingADFollow{
    NSString *d = [NSString stringWithFormat:@"%@",user_id];
    NSString *i = [NSString stringWithFormat:@"6"]; ///   본인 아이디
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"send_id":i , @"receive_id":d};
    [manager POST: @"http://mixhips.nowanser.cloulu.com/action_follow" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self.delegate AFNetworkingAD];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
