//
//  ListViewCell.h
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 11..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumList.h"
#import "ListViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ListViewCell : UICollectionViewCell<NSURLConnectionDataDelegate>
@property (strong, nonatomic) ListViewController *ListVC;
@property (weak, nonatomic) IBOutlet UIImageView *albumImg;
@property (weak, nonatomic) IBOutlet UILabel *albumName;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UILabel *like_count;


- (void) setPlaylistInfo:(AlbumList *)list;
@end
