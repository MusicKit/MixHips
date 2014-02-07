//
//  MyPageCollectionViewCell.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 5..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "MyPageCollectionViewCell.h"
#import "AlbumList.h"
@interface MyPageCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *albumImage;
@property (weak, nonatomic) IBOutlet UILabel *albumName;
@property (weak, nonatomic) IBOutlet UILabel *like;

@end

@implementation MyPageCollectionViewCell

- (void) setAlbumInfo:(AlbumList *)list
{
    self.albumName.text = list.albumName;
    self.albumImage.image = [UIImage imageNamed:list.albumImage];
    self.like.text = list.like;
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
