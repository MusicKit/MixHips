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
@property (strong, nonatomic) NSString *albumName, *albumImage, *albumNickName;

@property int rowID;

//핫아티스트
@property (strong, nonatomic) NSString *user_Name;
@property (strong, nonatomic) NSString *user_img;
@property (strong, nonatomic) NSString *user_id;

//앨범프로필
@property (strong, nonatomic) NSString *album_img, *album_name, *user_say, *album_id, *like_count, *follower_count, *following_count;

@property (strong, nonatomic)   NSString *sound_id, *sound_name, *sound_url;


+(id)albumlist:(NSString *)songTitle singerName:(NSString *)nickName image:(NSString *)image;

+(id)album:(NSString *)albumName image:(NSString *)albumImage like:(NSString *)like nickName:(NSString *)nickName;

//Album list
+(id)Albumlist:(NSString *)album_id album_img:(NSString *)album_img_url album_name:(NSString *)album_name like:(NSString *)like user_name:(NSString *)user_name;

//핫 앨범
+(id)hotAlbumList:(NSString *)album_id album_name:(NSString *)album_name album_img:(NSString *)album_img user_name:(NSString *)user_name like_count:(NSString *)like_count;

// 핫아티스트
+(id)hotArtistList:(NSString *)user_id userName:(NSString *)user_name userImg:(NSString *)user_img;

//앨범프로필
+(id)hotArtistAlbumlist:(NSString *)album_id album_img:(NSString *)album_img_url album_name:(NSString *)album_name like:(NSString *)like;

//Album Sound list
+(id)soundlist:(NSString *)sound_name sound_id:(NSString *)sound_id sound_url:(NSString *)sound_url;

//follow
+(id)followList:(NSString *)user_id user_name:(NSString *)user_name user_img:(NSString *)user_img;

@end
