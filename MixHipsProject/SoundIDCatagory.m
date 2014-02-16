//
//  SoundIDCatagory.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 14..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "SoundIDCatagory.h"

@implementation SoundIDCatagory{
    NSString *soundid;
}

static SoundIDCatagory *_instance = nil;

+ (id)defaultCatalog
{
    if (nil == _instance) {
        _instance = [[SoundIDCatagory alloc] init];
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

-(void)setSoundid:(NSString *)sound_id{
    soundid = sound_id;
}

-(NSString *)getSoundid{
    return soundid;
}
@end
