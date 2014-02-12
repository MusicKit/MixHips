//
//  ArtistProfileAlbumCell.h
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 8..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumList.h"

@interface ArtistProfileAlbumCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *albumName;
@property (weak, nonatomic) IBOutlet UILabel *listCount;
@property (weak, nonatomic) IBOutlet UIImageView *albumImg;
- (void) setProductInfo:(AlbumList *)list;

@end
