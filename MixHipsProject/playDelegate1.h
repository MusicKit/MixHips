//
//  playDelegate1.h
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 19..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol playDelegate1 <NSObject>
-(void)updateProgressViewWithPlayer:(NSString *)string time:(float)time;
-(void)setUser:(NSString *)userNamef setSound:(NSString *)soundNamef;
-(void)notiPlay;
@end
