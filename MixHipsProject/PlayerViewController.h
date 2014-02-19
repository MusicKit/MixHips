//
//  PlayerViewController.h
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 1. 27..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "AlbumList.h"

@interface PlayerViewController : UIViewController

@property AVPlayer *player;

@property (strong, nonatomic) NSString *soundID;
@property (strong, nonatomic) NSString *albumImg;

-(void)setImg:(NSInteger)indexPathff;

@end
