//
//  AlbumCell.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 4..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "AlbumCell.h"
@interface AlbumCell()
@property (weak, nonatomic) IBOutlet UILabel *musicName;
@property (weak, nonatomic) IBOutlet UILabel *soundNum;

@end

@implementation AlbumCell

- (void) setProductInfo:(AlbumList *)list indexPath:(NSInteger)index
{
    self.musicName.text = list.sound_name;
    self.soundNum.text = [NSString stringWithFormat:@"%d",index+1];
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
