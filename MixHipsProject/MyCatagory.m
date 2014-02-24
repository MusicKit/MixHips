//
//  MyCatagory.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 24..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "MyCatagory.h"

@implementation MyCatagory

static MyCatagory *_instance = nil;
+ (id)defaultCatalog
{
    if (nil == _instance) {
        _instance = [[MyCatagory alloc] init];
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

-(void)setInfo:(NSString *)myId myName:(NSString *)myName{
    self.my_id = myId;
    self.my_name =myName;
}

-(NSString *)getMyID{
    return self.my_id;
}

-(NSString *)getMyName{
    return  self.my_name;
}


@end
