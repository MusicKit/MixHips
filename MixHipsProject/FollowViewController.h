//
//  FollowViewController.h
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 1. 28..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumList.h"

@interface FollowViewController : UIViewController
@property (strong,nonatomic) AlbumList *list;
@property (strong, nonatomic)NSString *user_ID;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end
