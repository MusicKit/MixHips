//
//  Player.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 5..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "Player.h"
#import <AVFoundation/AVFoundation.h>

@interface Player()<AVAudioPlayerDelegate, AVAudioRecorderDelegate>
@end

@implementation Player{
    NSArray *musicFiles;
    NSTimer *timer;
}

-(void)playMusic:(NSURL *)url{
    if(self.player !=nil){
        if([self.player isPlaying]){
            [self.player stop];
        }
        
        self.Player = nil;
        
        [timer invalidate];
        timer = nil;
    }
}

@end
