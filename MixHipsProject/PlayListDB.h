//
//  PlayListDB.h
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 3..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayListDB : NSObject
@property NSMutableArray *playList;
@property NSMutableArray *nickNameList;
- (NSInteger)addMovieWithName:(NSString *)name nickName:(NSString *)nickName;
- (NSInteger)getNumberOfMovies;
- (void)fetchMovies;
- (NSString *)getNameOfMovieAtIndex:(NSInteger)index;
+ (id)sharedPlaylist;
-(NSString *)getNickNameOfMusicAtIndex:(NSInteger)index;
-(NSInteger)deleteMusic:(NSIndexPath *)indexpath;
@end
