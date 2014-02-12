//
//  ArtistProfileAlbumCell.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 8..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ArtistProfileAlbumCell.h"
#import "UIImageView+AFNetworking.h"

@implementation ArtistProfileAlbumCell

- (void) setProductInfo:(AlbumList *)list
{
    // self.imageURL.text = list.image;
    self.albumName.text = list.album_name;
    self.listCount.text = [NSString stringWithFormat:@"%@",list.like_count];
    NSString *url = @"http://mixhips.nowanser.cloulu.com";
    url = [url stringByAppendingString:list.album_img];
    NSURL *imgURL = [NSURL URLWithString:url];
    [self.albumImg setImageWithURL:imgURL];
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
