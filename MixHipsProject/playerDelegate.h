//
//  playerDelegate.h
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 18..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol playerDelegate <NSObject>
-(void)syncMusicProgress:(NSString *)timeString timePoint:(CMTime *)currentTime;
-(void)setImg:(NSInteger)indexPathff;
-(void)updateProgressViewWithPlayer:(NSString *)string time:(float)time;
- (void)updateProgressViewWithPlayer:(AVAudioPlayer *)player;
@end
