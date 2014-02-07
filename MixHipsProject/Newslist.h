//
//  Newslist.h
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 7..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Newslist : NSObject

@property (strong, nonatomic) NSString *ad_menu, *ad_title;

@property int ad_id;


+(id)newsList:(int)ad_id ad_menu:(NSString *)ad_menu ad_title:(NSString *)ad_title;
@end
