//
//  AlbumList.h
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 3..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlbumList : NSObject

@property (strong, nonatomic) NSString *songTitle, *nickName, *image, *url;
@property (strong, nonatomic) NSString *albumName, *albumImage, *albumNickName, *like;
@property int rowID;

+(id)albumlist:(NSString *)songTitle singerName:(NSString *)nickName image:(NSString *)image;

+(id)album:(NSString *)albumName image:(NSString *)albumImage like:(NSString *)like nickName:(NSString *)nickName;

@end
