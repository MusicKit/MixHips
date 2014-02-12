//
//  Catalog.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 3..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "Catalog.h"
#import "AlbumList.h"
#import "RequestCenter.h"

@implementation Catalog
{
    NSArray *albumList;
    NSMutableArray *soundlist;
}

// 싱글톤 메소드
static Catalog *_instance = nil;

+ (id)defaultCatalog
{
    if (nil == _instance) {
        _instance = [[Catalog alloc] init];
    }
    return _instance;
}

- (id) init
{
    self = [super init];
    if (self) {
        albumList = [[ NSArray alloc]init    ];
        albumList = soundlist;
    }
    return self;
}
/*
-(void)net{
    RequestCenter *requestCenter = [[RequestCenter alloc] init];
    //NSString *i = [NSString stringWithFormat:@"7"];
    NSString *d = [NSString stringWithFormat:@"%@",self.album_ID];
    NSString *i = [NSString stringWithFormat:@"%@",user_Id];
    NSLog(@"user id : %@",user_Id);
    //NSString *d = self.album_ID;
    NSLog(@"album idff : %@",self.album_ID);
    
    NSURL *urlCurrent = [NSURL URLWithString:@"http://mixhips.nowanser.cloulu.com/request_album"];
    NSMutableURLRequest *requestCurrent = [NSMutableURLRequest requestWithURL:urlCurrent];
    NSDictionary *dicRequest = @{@"키":@"값", @"my_id(user_id(본인))":i , @"album_id":d};
    NSDictionary *dicResult = [requestCenter setSyncRequest:requestCurrent withOption:dicRequest];
    
    NSLog(@"%@",dicResult);
    ////////////////////
    //albumImgURL = [NSString stringWithFormat:@"%@",[dicResult objectForKey:@"album_img_url"]];
    //soundName = [NSString stringWithFormat:@"%@",[dicResult objectForKey:@"sound_name"]];
    //soundID = [NSString stringWithFormat:@"%@",[dicResult objectForKey:@"sound_id"]];
    //soundURL = [NSString stringWithFormat:@"%@",[dicResult objectForKey:@"sound_url"]];
    
    
    NSArray *sound = [dicResult objectForKey:@"sounds"];
    NSMutableArray *soundIDArr = [[NSMutableArray alloc]init];
    NSMutableArray *soundNameArr = [[NSMutableArray alloc]init];
    NSMutableArray *soundURLArr = [[NSMutableArray alloc]init];
    soundlist = [[NSMutableArray alloc]init];
    for(int i=0;i<sound.count;i++)
    {
        [soundIDArr addObject:[sound[i] objectForKey:@"sound_id"]];
        [soundURLArr addObject:[sound[i] objectForKey:@"sound_url"]];
        [soundNameArr addObject:[sound[i] objectForKey:@"sound_name"]];
        
        [soundlist addObject:[AlbumList soundlist:soundNameArr[i] sound_id:soundIDArr[i] sound_url:soundURLArr[i]]];
    }
    NSLog(@"soundcount : %d",soundlist.count);
}*/


- (NSUInteger)numberOfMusic
{
    return [albumList count];
}

- (id)musicAt:(NSUInteger)index
{
    return [albumList objectAtIndex:index];
}


@end
