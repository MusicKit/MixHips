//
//  PlayCatalog.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 3..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "PlayCatalog.h"

@implementation PlayCatalog
{
    NSMutableArray *playList;
}

static PlayCatalog *_instance = nil;

+ (id)defaultPlayCatalog
{
    if (nil == _instance) {
        _instance = [[PlayCatalog alloc] init];
    }
    return _instance;
}

- (id) init
{
    self = [super init];
    if (self) {
        //
    }
    return self;
}

@end
