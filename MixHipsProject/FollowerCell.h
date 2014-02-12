//
//  FollowerCell.h
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 12..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumList.h"

@interface FollowerCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UILabel *userName;
- (void) setPlaylistInfo:(AlbumList *)list;
@end
