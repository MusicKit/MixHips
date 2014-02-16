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

- (NSUInteger)returnIndexPath
{
    return self.indexPathRow;
}

@end
