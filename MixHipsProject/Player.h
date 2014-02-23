//
//  Player.h
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 5..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface Player : NSObject 

@property AVAudioPlayer *player;
@property NSInteger indexPathRow;

+ (id)defaultCatalog;
- (NSInteger)returnIndexPath;

-(void)setAlbumImg:(NSString *)albumimg;
-(NSString *)getAlbumImg;

-(void)setSoundId:(NSString *)soundid;
-(NSString *)getSoundId;

-(void)setAlbumId:(NSString *)albumid;
-(NSString *)getAlbumId;

-(void)setIndexPathrow:(NSInteger)indexPath;


@end
