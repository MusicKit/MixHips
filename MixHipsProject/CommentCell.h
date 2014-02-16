//
//  CommentCell.h
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 13..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumList.h"

@interface CommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *contents;
@property (weak, nonatomic) IBOutlet UILabel *commentTime;
- (void) setPlaylistInfo:(AlbumList *)list;
-(void)setSize;
@end
