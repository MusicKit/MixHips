//
//  HotArtistCell.h
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 8..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumList.h"

@interface HotArtistCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *artistImg;
@property (weak, nonatomic) IBOutlet UILabel *userName;
- (void) setProductInfo:(AlbumList *)list;
@end
