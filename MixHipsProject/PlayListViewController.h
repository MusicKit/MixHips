//
//  PlayListViewController.h
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 1. 27..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "AlbumList.h"

@interface PlayListViewController : UIViewController
//@property AVAudioPlayer *player;
@property (strong, nonatomic) AlbumList *albumList;
@end
