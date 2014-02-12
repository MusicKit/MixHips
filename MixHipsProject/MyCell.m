//
//  MyCell.m
//  DragCollectionViewCell
//
//  Created by Quy Sang Le on 2/12/13.
//  Copyright (c) 2013 Quy Sang Le. All rights reserved.
//

#import "MyCell.h"
#import "UIImageView+AFNetworking.h"

@implementation MyCell

- (void) setProductInfo:(AlbumList *)list
{
    self.albumName.text = list.album_name;
    self.userName.text = list.user_Name;
    self.like_count.text = [NSString stringWithFormat:@"%@",list.like_count];
    NSString *url = @"http://mixhips.nowanser.cloulu.com";
    url = [url stringByAppendingString:list.album_img];

    NSURL *imgURL = [NSURL URLWithString:url];
    [self.albumImage setImageWithURL:imgURL];
    NSLog(@"imgURL : %@",imgURL);
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}


@end
