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
    list.like_count = like;
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

//Albumlist
+(id)Albumlist:(NSString *)album_id album_img:(NSString *)album_img_url album_name:(NSString *)album_name like:(NSString *)like user_name:(NSString *)user_name{
    AlbumList *list = [[AlbumList alloc]init];
    list.album_id = album_id;
    list.album_img = album_img_url;
    list.album_name = album_name;
    list.like_count = like;
    list.user_Name = user_name;
    return list;
}

+(id)hotAlbumList:(NSString *)album_id album_name:(NSString *)album_name album_img:(NSString *)album_img user_name:(NSString *)user_name like_count:(NSString *)like_count{
    AlbumList *list = [[AlbumList alloc]init];
    list.album_id = album_id;
    list.album_name = album_name;
    list.album_img = album_img;
    list.user_Name = user_name;
    list.like_count = like_count;
    return list;
}

//HotArtist
+(id)hotArtistList:(NSString *)user_id userName:(NSString *)user_name userImg:(NSString *)user_img{
    AlbumList *list = [[AlbumList alloc]init];
    list.user_id = user_id;
    list.user_img = user_img;
    list.user_Name  = user_name;
    return  list;
}

//HotArtistProfile
+(id)hotArtistAlbumlist:(NSString *)album_id album_img:(NSString *)album_img_url album_name:(NSString *)album_name like:(NSString *)like{
    AlbumList *list = [[AlbumList alloc]init];
    list.album_id = album_id;
    list.album_img = album_img_url;
    list.album_name = album_name;
    list.like_count = like;
    return list;
}


//Album Sound list
+(id)soundlist:(NSString *)sound_name sound_id:(NSString *)sound_id sound_url:(NSString *)sound_url{
    AlbumList *list = [[AlbumList alloc]init];
    list.sound_id = sound_id;
    list.sound_name = sound_name;
    list.sound_url = sound_url;
    return list;
}

//follow
+(id)followList:(NSString *)user_id user_name:(NSString *)user_name user_img:(NSString *)user_img
{
    AlbumList *list = [[AlbumList alloc]init ];
    list.user_id = user_id;
    list.user_img = user_img;
    list.user_Name = user_name;
    return list;
}

//comment
+(id)comment:(NSString *)user_id user_name:(NSString *)user_name user_img:(NSString *)user_img commentID:(NSString *)commentID commentTime:(NSString *)commentTime contents:(NSString *)contents{
    AlbumList *list = [[AlbumList alloc]init];
    list.user_id = user_id;
    list.user_img = user_img;
    list.user_Name = user_name;
    list.comment_id = commentID;
    list.comment_time = commentTime;
    list.contents = contents;
    return list;
}


+(id)uploadAlbum:(NSData *)albumData albumName:(NSString *)albumName{
    AlbumList *list = [[AlbumList alloc ]init];
    list.albumdata = albumData;
    list.albumName = albumName;
    return list;
}





//sound



@end
