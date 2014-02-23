//
//  PlaylistCell.h
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 3..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumList.h"


@interface PlaylistCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *listImg;
@property (strong, nonatomic) AlbumList *albumList;
- (void) setPlaylistInfo:(NSString *)name nickName:(NSString *)nickName img:(NSString *)img;
@end
