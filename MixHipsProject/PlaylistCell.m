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

- (void) setPlaylistInfo:(NSString *)name nickName:(NSString *)nickName
{
    self.songTitle.text = name;
    self.nickName.text = nickName;
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
