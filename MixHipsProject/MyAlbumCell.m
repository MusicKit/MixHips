//
//  MyAlbumCell.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 3..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "MyAlbumCell.h"
#import "AlbumList.h"
#import "SoundIDCatagory.h"


@interface MyAlbumCell()
@property (weak, nonatomic) IBOutlet UILabel *musicName;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UILabel *albumNum;



@end

@implementation MyAlbumCell{
    SoundIDCatagory *soundCatagory;
}

-(IBAction)commentButton:(id)sender{
    soundCatagory = [SoundIDCatagory defaultCatalog];
    [[SoundIDCatagory defaultCatalog] setSoundid:self.soundid];
}

- (void) setProductInfo:(AlbumList *)list indexPath:(NSInteger)index
{
    self.musicName.text = list.sound_name;
    self.albumNum.text = [NSString stringWithFormat:@"%d",index+1];
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
