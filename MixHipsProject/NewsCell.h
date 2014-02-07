//
//  NewsCell.h
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 7..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Newslist.h"

@interface NewsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ad_menu;
@property (weak, nonatomic) IBOutlet UILabel *ad_title;

- (void) setProductInfo:(Newslist *)list;

@end
