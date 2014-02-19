//
//  MypageCatagory.h
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 18..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MypageCatagory : NSObject
+ (id)defaultCatalog;
-(void)setAlbuId:(NSString *)albumid;
-(NSString *)getalbumID;
@end
