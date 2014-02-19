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

#import "PlayerViewController.h"


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
    NSString * timeString;
    NSString *userName;
    NSString *soundName;
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

/*   앱 재생중이면 폰켤때 화면에 나오는거...
- (void)changeLockScreen{
    Class playingInfoCenter = NSClassFromString(@"MPNowPlayingInfoCenter");
    
    if (playingInfoCenter) {
        UIImage *albumImage = [_curPlayMusic getAlbumImageWithSize:SCREENIMAGE_SIZE];
        if(albumImage == nil){
            albumImage = [UIImage imageNamed:@"artview_1.png"];
        }
        MPMediaItemArtwork *artWork = [[MPMediaItemArtwork alloc] initWithImage:albumImage];
        
        NSMutableDictionary *songInfo = [[NSMutableDictionary alloc] init];
        if(_curPlayItem != nil){
            
            [songInfo setObject:[_curPlayItem valueForKey:MPMediaItemPropertyTitle] forKey:MPMediaItemPropertyTitle];
            [songInfo setObject:[_curPlayItem valueForKey:MPMediaItemPropertyArtist] forKey:MPMediaItemPropertyArtist];
            [songInfo setObject:[_curPlayItem valueForKey:MPMediaItemPropertyPlaybackDuration] forKey:MPMediaItemPropertyPlaybackDuration];
            
        }else {
            [songInfo setObject:_curPlayMusic.title forKey:MPMediaItemPropertyTitle];
            [songInfo setObject:_curPlayMusic.artist forKey:MPMediaItemPropertyArtist];
            [songInfo setObject:[[NSNumber alloc] initWithInteger:[self getDuration]] forKey:MPMediaItemPropertyPlaybackDuration];
        }
        [songInfo setObject:artWork forKey:MPMediaItemPropertyArtwork];
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songInfo];
    }
}
*/

- (int)getDuration{
    return (int)CMTimeGetSeconds(player.currentItem.asset.duration);
}
- (int)getCurTime{
    return (int)CMTimeGetSeconds(player.currentTime);
}
- (void)syncPlayTimeLabel{
    int duration = [self getDuration];
    int currentTime = [self getCurTime];
    int durationMin = (int)(duration / 60);
    int durationSec = (int)(duration % 60);
    int currentMins = (int)(currentTime / 60);
    int currentSec = (int)(currentTime % 60);
    float ff = currentTime / (float)duration;

    
    timeString =[NSString stringWithFormat:@"%02d:%02d/%02d:%02d",currentMins,currentSec,durationMin,durationSec];
    
    [self.delegate updateProgressViewWithPlayer:timeString time:ff];
    [self.delegate1 updateProgressViewWithPlayer:timeString time:ff];
    [self.delegate2 updateProgressViewWithPlayer:timeString time:ff];
    [self.delegate3 updateProgressViewWithPlayer:timeString time:ff];
    [self.delegate4 updateProgressViewWithPlayer:timeString time:ff];
}



-(NSString *)getTime{
    NSLog(@"%@",timeString);
    return timeString;
}

- (void)setAudioSession{
    NSError *error = nil;
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback withOptions:kAudioSessionProperty_OverrideCategoryMixWithOthers error:&error];
    
    [session setActive:YES error:&error];
}

-(void)playMusic:(NSURL *)url{
    playDB = [PlayListDB sharedPlaylist];
    AVPlayerItem* playerItem = [AVPlayerItem playerItemWithURL:url];
    
    // Subscribe to the AVPlayerItem's DidPlayToEndTime notification.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];
    
    player = [[AVPlayer alloc] initWithPlayerItem:playerItem];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(syncPlayTimeLabel) userInfo:Nil repeats:YES];
     playerlist = [Player defaultCatalog];
    userName = [NSString stringWithFormat:@"%@",[playDB getNickNameOfMusicAtIndex:playerlist.indexPathRow]];
    soundName = [NSString stringWithFormat:@"%@",[playDB getNameOfMovieAtIndex:playerlist.indexPathRow]];
    [self.delegate setImg:playerlist.indexPathRow];
    [self.delegate1 setUser:userName setSound:soundName];
    [self.delegate2 setUser:userName setSound:soundName];
    [self.delegate3 setUser:userName setSound:soundName];
    [self.delegate4 setUser:userName setSound:soundName];
    
    [self setAudioSession];
    [self syncPlayTimeLabel];
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
