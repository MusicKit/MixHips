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
    NSInteger *indexPath;
    NSString *_albumIMG;
    NSString *_soundID;
    NSString *_albumID;
}

static Player *_instance = nil;

+ (id)defaultCatalog
{
    if (nil == _instance) {
        _instance = [[Player alloc] init];
    }
    return _instance;
}

- (id) init
{
    self = [super init];
    if (self) {
    }
    return self;
}
-(void)setAlbumId:(NSString *)albumid{
    _albumID = albumid;
}
-(NSString *)getAlbumId{
    return _albumID;
}

-(void)setSoundId:(NSString *)soundid{
    _soundID = soundid;
}
-(NSString *)getSoundId{
    return _soundID;
}
-(void)setAlbumImg:(NSString *)albumimg{
    _albumIMG = albumimg;
}

-(NSString *)getAlbumImg{
    return _albumIMG;
}

- (NSUInteger)returnIndexPath
{
    return self.indexPathRow;
}

@end
