//
//  PlaylistCatagory.h
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 6..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "playerDelegate.h"
#import "playDelegate1.h"
#import "playDelegate2.h"
#import "playDelegate3.h"
#import "playDelegate4.h"

@protocol CircularProgressViewDelegate <NSObject>

@optional

- (void)updateProgressViewWithPlayer:(AVPlayer *)player;
- (void)playerDidFinishPlaying;

@end

@interface PlaylistCatagory : NSObject <AVPlayerItemLegibleOutputPushDelegate ,AVPlayerItemOutputPullDelegate, AVPlayerItemOutputPushDelegate>
@property AVPlayer *player;

@property (weak, nonatomic) id<playerDelegate> delegate;
@property (weak, nonatomic) id<playDelegate1> delegate1;
@property (weak, nonatomic) id<playDelegate2> delegate2;
@property (weak, nonatomic) id<playDelegate3> delegate3;
@property (weak, nonatomic) id<playDelegate4> delegate4;
//@property (assign, nonatomic) id <CircularProgressViewDelegate> delegate;

+ (id)defaultCatalog;
-(void)playStart:(NSString *)soundid;
-(void)pause;
-(void)next:(NSString *)soundid;
-(void)playMusic:(NSURL *)url;

- (int)getDuration;
- (int)getCurTime;
-(void)itemDidFinishPlaying:(NSNotification *) notification;
@end
