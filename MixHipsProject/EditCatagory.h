//
//  EditCatagory.h
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 14..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlbumList.h"

@interface EditCatagory : NSObject
@property (strong, nonatomic) NSString *soundNameff;
@property (strong, nonatomic) NSMutableArray *soundNameArr;
+ (id)defaultCatalog;
-(NSInteger)getIndex;
-(NSString *)returnSoundName;
- (void)setArrTest:(NSString *)sR;
-(NSMutableArray *)getArrTest;
-(void)setData:(NSData *)data;
-(NSMutableArray *)getMpArr;
-(void)initialize;


-(void)setData11:(NSData *)data1;
-(NSData *)getData11;

-(void)dd:(NSString *)alubmName data:(NSData *)data;

-(NSMutableArray *)returnListData;
-(NSString *)albumName;
-(void)albumName:(NSString *)albumName;

-(void)setIndex:(NSInteger)indexPathRow;
//-(NSInteger)getIndex;

-(void)setFileName:(NSString *)filename;
-(NSMutableArray *)getFileName;
-(void)setFile:(NSString *)filename;
@end
