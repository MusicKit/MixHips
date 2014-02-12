//
//  ListViewCell.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 11..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ListViewCell.h"
#import "ListViewController.h"
#import "UIImageView+AFNetworking.h"

@implementation ListViewCell{
    ListViewController *listdd;
    NSMutableData *abc;
}



- (void) setPlaylistInfo:(AlbumList *)list
{
    self.albumName.text = list.album_name;
    self.userName.text = list.user_Name;
    NSString *url = @"http://mixhips.nowanser.cloulu.com";
    url  = [url stringByAppendingString:list.album_img];
    NSURL *imgURL = [NSURL URLWithString:url];
    [self.albumImg setImageWithURL:imgURL];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

@end
