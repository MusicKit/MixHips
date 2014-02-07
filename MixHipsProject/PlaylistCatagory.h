//
//  PlaylistCatagory.h
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 6..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface PlaylistCatagory : NSObject <AVAudioPlayerDelegate>
@property AVAudioPlayer *player;
+ (id)defaultCatalog;
-(void)playStart;
-(void)stop;
-(void)pause;
-(void)playMusic:(NSURL *)url;
-(double)returnTime;
-(int)returnVolumeValue;
@end
