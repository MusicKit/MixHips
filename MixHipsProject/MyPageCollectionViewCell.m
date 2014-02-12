//
//  MyPageCollectionViewCell.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 5..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "MyPageCollectionViewCell.h"
#import "AlbumList.h"
#import "UIImageView+AFNetworking.h"
@interface MyPageCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *albumName;
@property (weak, nonatomic) IBOutlet UILabel *like;
@property (weak, nonatomic) IBOutlet UIImageView *albumImg;

@end

@implementation MyPageCollectionViewCell

- (void) setAlbumInfo:(AlbumList *)list
{
    self.albumName.text = list.album_name;
    self.like.text = [NSString stringWithFormat:@"%@",list.like_count];
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
