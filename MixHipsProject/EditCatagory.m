//
//  EditCatagory.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 14..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "EditCatagory.h"

@implementation EditCatagory {
    NSMutableArray *_arrTest;
    NSData *fileData;
    NSMutableArray *mpArr;
    NSMutableArray *_fileArr;
    NSMutableData *data11;
    NSMutableArray *datapath;
    NSInteger numCell;
    NSMutableArray *listData;
    NSString *soundName;
    NSInteger indexPathRow1;
    NSString *fileName;
}

static EditCatagory *_instance = nil;
+ (id)defaultCatalog
{
    if (nil == _instance) {
        _instance = [[EditCatagory alloc] init];
    }
    return _instance;
}

- (id) init
{
    self = [super init];
    if (self) {
        _arrTest = [[NSMutableArray alloc]init];
        mpArr = [[NSMutableArray alloc]init];
        _fileArr = [[NSMutableArray alloc]init];
        listData = [[NSMutableArray alloc]init];
        
//       self.soundNameArr = [[NSMutableArray alloc]init];
//        [self.soundNameArr addObject:self.soundName];
    }
    return self;
}

-(void)dd:(NSString *)alubmName data:(NSData *)data{
    soundName = alubmName;
    [listData addObject:[AlbumList uploadAlbum:data albumName:alubmName]];
    NSLog(@"ddd %d",listData.count);
}

-(void)albumName:(NSString *)albumName{
    soundName =albumName;
}

-(NSString *)albumName{
    return soundName;
}
-(NSMutableArray *)returnListData{
    return listData;
}
-(void)initialize{
    mpArr = [[NSMutableArray alloc]init];
    _arrTest = [[NSMutableArray alloc]init];
    _fileArr = [[NSMutableArray alloc]init];
 //   listData = [[NSMutableArray alloc]init];
}
-(void)setData11:(NSData *)data1
{
    fileData = data1;
}
-(NSData *)getData11{
    return fileData;
}

-(void)setNumCell:(NSInteger)num
{
    numCell = num;
}

-(NSInteger)getNumCell{
    return numCell;
}
-(NSInteger)deleteCell
{
   return numCell--;
}


-(void)setData:(NSData *)data{
    [mpArr addObject:data];
}

-(NSMutableArray *)getMpArr{
    return mpArr;
}

- (void)setArrTest:(NSString *)sR {
    [_arrTest addObject:sR];
}

-(NSMutableArray *)getArrTest{
    return _arrTest;
}

-(NSString *)returnSoundName{
    return self.soundNameff;
}

-(void)setIndex:(NSInteger)indexPathRow{
    indexPathRow1 = indexPathRow;
}
-(NSInteger)getIndex{
    return indexPathRow1;
}

//-(void)setFileName:(NSString *)filename{
//    NSLog(@"%@",fileName);
//    [_fileArr addObject:fileName];
//}

-(void)setFile:(NSString *)filename{
    [_fileArr addObject:filename];
}
-(NSMutableArray *)getFileName{
    return _fileArr;
}

@end
