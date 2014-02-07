//
//  AlbumList.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 3..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "AlbumList.h"

@implementation AlbumList

+(id)album:(NSString *)albumName image:(NSString *)albumImage like:(NSString *)like nickName:(NSString *)nickName{
    AlbumList *list = [[AlbumList alloc]init];
    list.albumName = albumName;
    list.albumImage = albumImage;
    list.albumNickName = nickName;
    list.like = like;
    return list;
}

// 팩토리 메소드
+(id)albumlist:(NSString *)songTitle singerName:(NSString *)nickName image:(NSString *)image{
    AlbumList *list = [[AlbumList alloc]init];
    list.songTitle = songTitle;
    list.nickName = nickName;
    list.image = image;
    return list;
}



@end
