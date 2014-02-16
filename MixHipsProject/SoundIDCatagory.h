//
//  SoundIDCatagory.h
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 14..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoundIDCatagory : NSObject

+ (id)defaultCatalog;
-(NSString *)getSoundid;
-(void)setSoundid:(NSString *)sound_id;

@end
