//
//  FollowingCell.h
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 12..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumList.h"
#import "FollowViewController.h"
#import "FollowDelegate.h"

@interface FollowingCell : UICollectionViewCell
@property (weak,nonatomic) id<FollowDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIButton *followingButton;
- (void) setPlaylistInfo:(AlbumList *)list;
@end
