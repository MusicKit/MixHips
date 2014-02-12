//
//  HotArtistCell.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 8..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "HotArtistCell.h"
#import "UIImageView+AFNetworking.h"


@implementation HotArtistCell

- (void) setProductInfo:(AlbumList *)list
{
    self.userName.text = list.user_Name;
    NSString *url = @"http://mixhips.nowanser.cloulu.com";
    url = [url stringByAppendingString:list.user_img];
    NSURL *imgURL = [NSURL URLWithString:url];
    [self.artistImg setImageWithURL:imgURL];
    NSLog(@"url %@",imgURL);
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
