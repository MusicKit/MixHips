//
//  PlaylistCatagory.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 6..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "PlaylistCatagory.h"
#import "AFHTTPRequestOperationManager.h"
#import "PlayListDB.h"
#import "Player.h"


@implementation PlaylistCatagory{
    PlayListDB *playDB;
    Player *playerlist;
    NSMutableArray *list;
    NSTimer *timer;
    NSString *purl;
    NSString *musicURL;
    NSString* urlTextEscaped;
    NSInteger indexPathRow;
    NSArray *listTrack;
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
    }
    return self;
}

- (void)test:(NSDictionary *)dic {
    NSDictionary *dd = [NSDictionary dictionaryWithDictionary:dic];
    NSArray *soundlist = [dd objectForKey:@"sounds_list"];
    NSMutableArray *soundURL = [[NSMutableArray alloc]init];

    [soundURL addObject:[soundlist[0] objectForKey:@"sound_url"]];
    purl = [NSString stringWithFormat:@"%@",soundURL[0]];
    
    musicURL = [NSString stringWithFormat:@"http://mixhips.nowanser.cloulu.com%@",purl];
    urlTextEscaped = [musicURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
-(void)AFNetworkingPlay:(NSString *)soundid{
    NSString *i = [NSString stringWithFormat:@"%@",soundid];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"foo":@"bar", @"sounds_id":i};
    [manager POST: @"http://mixhips.nowanser.cloulu.com/fetch_sounds" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"JSON: %@", responseObject);
        [self test:responseObject];
        NSURL *urlForPlay = [NSURL URLWithString:urlTextEscaped];
        [self playMusic:urlForPlay];
        NSLog(@"music url : %@",urlForPlay);
       // [self.collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (NSTimeInterval) availableDuration;
{
    NSArray *loadedTimeRanges = [[self.player currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [[loadedTimeRanges objectAtIndex:0] CMTimeRangeValue];
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;
    return result;
}



-(void)playStart:(NSString *)soundid{
    NSLog(@"play 11111");
    [self AFNetworkingPlay:soundid];
}

-(void)pause{
    [player pause];
}

-(void)next:(NSString *)soundid{
    //[self net:soundid];
}

-(void)prev{
    
}

//끝날을시
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    
}

//-(double)returnTime{
//    return player.currentTime;
//}
//
//-(int)returnVolumeValue{
//    return player.volume;
//
//}


-(void)playMusic:(NSURL *)url{
    playDB = [PlayListDB sharedPlaylist];
    AVPlayerItem* playerItem = [AVPlayerItem playerItemWithURL:url];
    
    // Subscribe to the AVPlayerItem's DidPlayToEndTime notification.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];
    
    // Pass the AVPlayerItem to a new player
    player = [[AVPlayer alloc] initWithPlayerItem:playerItem];
    
    // Begin playback
    [player play];

}

-(void)itemDidFinishPlaying:(NSNotification *) notification {
    // Will be called when AVPlayer finishes playing playerItem
    playerlist = [Player defaultCatalog];
    playerlist.indexPathRow++;
    
    listTrack =  [playDB data];
    if(playerlist.indexPathRow > listTrack.count-1){
        playerlist.indexPathRow = 0;
        NSString *soundid = [NSString stringWithFormat:@"%@",listTrack[playerlist.indexPathRow]];
        [self AFNetworkingPlay:soundid];
    }
    else{
        NSString *soundid = [NSString stringWithFormat:@"%@",listTrack[playerlist.indexPathRow]];
       [self AFNetworkingPlay:soundid];
    }
}





@end
