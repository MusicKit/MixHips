//
//  CommentCell.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 13..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "CommentCell.h"
#import "UIImageView+AFNetworking.h"

@implementation CommentCell

-(void)setSize{
    
}

- (void) setPlaylistInfo:(AlbumList *)list
{
    self.userName.text = list.user_Name;
    self.commentTime.text = list.comment_time;
    self.contents.text = list.contents;
    NSLog(@"%@",list.user_img);
    NSString *url = @"http://mixhips.nowanser.cloulu.com";
    url  = [url stringByAppendingString:list.user_img];
    NSURL *imgURL = [NSURL URLWithString:url];
    [self.userImg setImageWithURL:imgURL];
    
    [self.userName sizeToFit];
    [self.commentTime sizeToFit];
    [self.contents sizeToFit];
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
