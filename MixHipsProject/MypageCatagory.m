//
//  MypageCatagory.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 18..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "MypageCatagory.h"

@implementation MypageCatagory{
    NSString *_albumID;
}

static MypageCatagory *_instance = nil;
+ (id)defaultCatalog
{
    if (nil == _instance) {
        _instance = [[MypageCatagory alloc] init];
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

-(void)setAlbuId:(NSString *)albumid{
    _albumID = albumid;
}

-(NSString *)getalbumID{
    return _albumID;
}

@end
