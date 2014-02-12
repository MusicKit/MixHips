//
//  Newslist.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 7..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "Newslist.h"

@implementation Newslist

+(id)newsList:(NSString *)ad_id ad_menu:(NSString *)ad_menu ad_title:(NSString *)ad_title{
    Newslist *list = [[Newslist alloc]init];
    list.ad_id = ad_id;
    list.ad_menu  = ad_menu;
    list.ad_title = ad_title;
    return list;
}

@end
