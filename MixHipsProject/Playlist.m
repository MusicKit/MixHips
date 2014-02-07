//
//  Playlist.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 1. 27..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "Playlist.h"

@implementation Playlist

+ (id)playlist:(NSString *)song_title nick:(NSString *)nickName url:(NSString *)song_url{
    Playlist *list = [[Playlist alloc]init];
    list.musicName = song_title;
    list.singerName = nickName;
    list.url = song_url;
    
    return list;

}

@end
