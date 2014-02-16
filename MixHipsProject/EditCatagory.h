//
//  EditCatagory.h
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 14..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EditCatagory : NSObject
@property (strong, nonatomic) NSString *soundName;
@property (strong, nonatomic) NSMutableArray *soundNameArr;
+ (id)defaultCatalog;
-(NSString *)returnSoundName;
- (void)setArrTest:(NSString *)sR;
-(NSArray *)getArrTest;
@end
