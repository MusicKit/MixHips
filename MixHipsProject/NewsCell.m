//
//  NewsCell.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 7..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "NewsCell.h"
#import "Newslist.h"

@implementation NewsCell

- (void) setProductInfo:(Newslist *)list
{
    self.ad_menu.text = list.ad_menu;
    self.ad_title.text = list.ad_title;
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
