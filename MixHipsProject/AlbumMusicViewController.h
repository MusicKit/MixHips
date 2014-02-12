//
//  AlbumMusicViewController.h
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 1. 28..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumList.h"
#import "UIImageView+AFNetworking.h"

@interface AlbumMusicViewController : UIViewController
@property (strong, nonatomic) AlbumList *albumList;
@property (strong, nonatomic) NSString *album_ID;
@property (strong,nonatomic) NSString *user_ID;
@property (strong, nonatomic) NSString *user_Name;
- (void)returnAlbumID:(NSString *)album_id user_id:(NSString *)user_id;
@end
