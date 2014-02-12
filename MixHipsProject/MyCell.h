//
//  MyCell.h
//  DragCollectionViewCell
//
//  Created by Quy Sang Le on 2/12/13.
//  Copyright (c) 2013 Quy Sang Le. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumList.h"

@interface MyCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *albumImg;
@property (weak, nonatomic) IBOutlet UILabel *albumName;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *like_count;
@property (weak, nonatomic) IBOutlet UIImageView *albumImage;

- (void) setProductInfo:(AlbumList *)list;
@end
