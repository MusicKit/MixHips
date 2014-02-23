//
//  PlaylistCell.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 3..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "PlaylistCell.h"
#import "PlayListDB.h"


@interface PlaylistCell ()
@property (weak, nonatomic) IBOutlet UILabel *songTitle;
@property (weak, nonatomic) IBOutlet UILabel *nickName;


@end

@implementation PlaylistCell{
    PlayListDB *_playlist;
}

- (void) setPlaylistInfo:(NSString *)name nickName:(NSString *)nickName img:(NSString *)img
{
    self.songTitle.text = name;
    self.nickName.text = nickName;
    UIImageView *musicImg = [[UIImageView alloc]initWithFrame:CGRectMake(17, 12, 25, 25)];
    musicImg.image = [UIImage imageNamed:img];
    [self addSubview:musicImg];
//    self.imageView.image = [UIImage imageNamed:img];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
