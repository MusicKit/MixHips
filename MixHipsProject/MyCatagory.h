//
//  MyCatagory.h
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 24..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCatagory : NSObject


@property NSString *my_id;
@property NSString *my_name;
+ (id)defaultCatalog;
-(void)setInfo:(NSString *)myId myName:(NSString *)myName;
-(NSString *)getMyID;
-(NSString *)getMyName;
@end
