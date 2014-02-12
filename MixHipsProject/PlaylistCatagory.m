//
//  PlaylistCatagory.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 6..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "PlaylistCatagory.h"
#import "RequestCenter.h"
#import "PlayListDB.h"


@implementation PlaylistCatagory{
    NSMutableArray *list;
    NSTimer *timer;
    NSString *purl;
    NSString *musicURL;
    NSString* urlTextEscaped;
}
@synthesize player;

static PlaylistCatagory *_instance = nil;

+ (id)defaultCatalog
{
    if (nil == _instance) {
        _instance = [[PlaylistCatagory alloc] init];
    }
    return _instance;
}

- (id) init
{
    self = [super init];
    if (self) {
        //list = [[NSMutableArray alloc]initWithObjects:@"http://www.ggotnuri.co.kr/day.mp3", nil];
    }
    return self;
}

-(void)net:(NSString *)soundid{
    RequestCenter *requestCenter = [[RequestCenter alloc] init];
    //
    NSString *i = [NSString stringWithFormat:@"%@",soundid];
    
    
    NSURL *urlCurrent = [NSURL URLWithString:@"http://mixhips.nowanser.cloulu.com/fetch_sounds"];
    NSMutableURLRequest *requestCurrent = [NSMutableURLRequest requestWithURL:urlCurrent];
    NSDictionary *dicRequest = @{@"키":@"값", @"sounds_id":i};
    NSDictionary *dicResult = [requestCenter setSyncRequest:requestCurrent withOption:dicRequest];
    NSLog(@"%@",dicResult);
    NSArray *soundlist = [dicResult objectForKey:@"sounds_list"];
    ////////////////////
    NSMutableArray *soundURL = [[NSMutableArray alloc]init];
    [soundURL addObject:[soundlist[0] objectForKey:@"sound_url"]];   // NSLog(@"url: %@",soundID);
    
    //NSString *albumID = [NSString stringWithFormat:@"%@",[dicResult objectForKey:@"album_id"]];
    //NSString *soundName = [NSString stringWithFormat:@"%@",[dicResult objectForKey:@"sound_name"]];
    purl = [NSString stringWithFormat:@"%@",soundURL[0]];
    
    musicURL = [NSString stringWithFormat:@"http://mixhips.nowanser.cloulu.com%@",purl];
    urlTextEscaped = [musicURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",urlTextEscaped);
}



-(void)playStart:(NSString *)soundid{
    [self net:soundid];
    //NSURL *urlForPlay = [NSURL URLWithString:@"http://mixhips.nowanser.cloulu.com/uploads/sound/3/5/day1.mp3"];
    NSURL *urlForPlay = [NSURL URLWithString:urlTextEscaped];
    

    [self playMusic:urlForPlay];
}

-(void)stop{
    [player stop];
}

-(void)pause{
    [player pause];
}

-(void)next:(NSString *)soundid{
    [self net:soundid];
}

-(void)prev{
    
}

//끝날을시
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    
}

-(double)returnTime{
    return player.currentTime;
}

-(int)returnVolumeValue{
    return player.volume;

}



-(void)playMusic:(NSURL *)url{
    if(nil!=player){
        if([player isPlaying]){
            //            [timer invalidate];
            //            timer = nil;
            [player stop];
        }
        
        //플레이어 초기화
        player = nil;
        
        //타이머 처리
        //        [timer invalidate];
        //        timer = nil;
    }
    
    __autoreleasing NSError *error;
    NSData *songFile = [[NSData alloc] initWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:&error ];
    player = [[AVAudioPlayer alloc] initWithData:songFile error:nil];
    player.delegate = self;
    
    if([player prepareToPlay]){
        
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        [[AVAudioSession sharedInstance] setActive: YES error: nil];
        
        //        timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timeFired:) userInfo:nil repeats:YES];
        [player play];
    }
}






@end
