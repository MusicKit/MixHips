//
//  EditCatagory.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 14..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "EditCatagory.h"

@implementation EditCatagory {
    NSMutableArray *_arrTest;
}

static EditCatagory *_instance = nil;
+ (id)defaultCatalog
{
    if (nil == _instance) {
        _instance = [[EditCatagory alloc] init];
    }
    return _instance;
}

- (id) init
{
    self = [super init];
    if (self) {
        _arrTest = [[NSMutableArray alloc]init];
//       self.soundNameArr = [[NSMutableArray alloc]init];
//        [self.soundNameArr addObject:self.soundName];
    }
    return self;
}
- (void)setArrTest:(NSString *)sR {
    [_arrTest addObject:sR];
}

-(NSArray *)getArrTest{
    return _arrTest;
}

-(NSString *)returnSoundName{
    return self.soundName;
}

@end
