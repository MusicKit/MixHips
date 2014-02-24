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
#import "cacheList.h"


#import "PlayerViewController.h"


@implementation PlaylistCatagory{
    PlayListDB *playDB;
    Player *playerlist;
    NSMutableArray *list;
    NSTimer *timer;
    NSTimer *timer1;
    NSTimer *timer2;
    NSString *purl;
    NSString *musicURL;
    NSString* urlTextEscaped;
    NSInteger indexPathRow;
    NSArray *listTrack;
    NSString * timeString;
    NSString *userName;
    NSString *soundName;
    NSString *soundid11;
    AVPlayerItem* playerItem;
    BOOL loop;
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
        [PlayListDB sharedPlaylist];
        [self loadData];
    }
    return self;
}

-(void)changeTime:(NSInteger)time{
    
    [player seekToTime:CMTimeMakeWithSeconds(time, 1) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero completionHandler:^(BOOL finished){
        [player play];
    }];
}

- (void)test:(NSDictionary *)dic {
    NSDictionary *dd = [NSDictionary dictionaryWithDictionary:dic];
    NSArray *soundlist = [dd objectForKey:@"sounds_list"];
    NSMutableArray *soundURL = [[NSMutableArray alloc]init];
    
    if(soundlist.count == 0){
        playerlist = [Player defaultCatalog];
        playDB = [PlayListDB sharedPlaylist];
        [playDB deleteMusic:playerlist.indexPathRow];
        playerlist.indexPathRow++;
        NSLog(@"%d",playerlist.indexPathRow);
        
        
        listTrack =  [playDB data];
        NSLog(@"%d",listTrack.count);
        if(playerlist.indexPathRow > listTrack.count-1){
            playerlist.indexPathRow = 0;
            NSString *soundid = [NSString stringWithFormat:@"%@",listTrack[playerlist.indexPathRow]];
            [self AFNetworkingPlay:soundid];
            
        }
        else{
            NSString *soundid = [NSString stringWithFormat:@"%@",listTrack[playerlist.indexPathRow]];
            NSLog(@"%@",soundid);
            [self AFNetworkingPlay:soundid];
        }


    }
    else{
        [soundURL addObject:[soundlist[0] objectForKey:@"sound_url"]];
        purl = [NSString stringWithFormat:@"%@",soundURL[0]];
        musicURL = [NSString stringWithFormat:@"http://mixhips.nowanser.cloulu.com%@",purl];
        urlTextEscaped = [musicURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    
}
-(void)AFNetworkingPlay:(NSString *)soundid{
    [self.delegate indicator];
    NSLog(@"%@",soundid);
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
        playerlist = [Player defaultCatalog];
        playerlist.indexPathRow++;
        NSLog(@"%d",playerlist.indexPathRow);
        playDB = [PlayListDB sharedPlaylist];
        listTrack =  [playDB data];
        NSLog(@"%d",listTrack.count);
        if(playerlist.indexPathRow > listTrack.count-1){
            playerlist.indexPathRow = 0;
            NSString *soundid = [NSString stringWithFormat:@"%@",listTrack[playerlist.indexPathRow]];
            [self AFNetworkingPlay:soundid];
        }
        
    }];
    
}


-(void)playStart:(NSString *)soundid{
    NSLog(@"play 11111");
    [self AFNetworkingPlay:soundid];
}

-(void)loopPlay{
    loop = YES;
    NSLog(@"들어감");
    player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification object:[player currentItem]];
}

-(void)notloopPlay{
    loop = NO;
}



-(void)changeLockScreen:(UIImage *)img soundName:(NSString *)soundName1 userName:(NSString *)userName1{
     MPMediaItemArtwork *artWork = [[MPMediaItemArtwork alloc] initWithImage:img];
    NSArray *keys = [NSArray arrayWithObjects:
                     MPMediaItemPropertyTitle,
                     MPMediaItemPropertyArtist,
                     MPMediaItemPropertyPlaybackDuration,
                     MPNowPlayingInfoPropertyPlaybackRate,
                     MPNowPlayingInfoPropertyElapsedPlaybackTime,
                     MPMediaItemPropertyArtwork,
                     nil];
    NSArray *values = [NSArray arrayWithObjects:
                       soundName1,
                       userName1,
                       [[NSNumber alloc] initWithInteger:[self getDuration]],
                       [NSNumber numberWithInt:1],
                       [[NSNumber alloc] initWithInteger:[self getCurTime]],
                       artWork,
                       nil];
    NSDictionary *mediaInfo = [NSDictionary dictionaryWithObjects:values forKeys:keys];
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:mediaInfo];
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)receivedEvent
{
    if ( receivedEvent.type == UIEventTypeRemoteControl ) {
        switch (receivedEvent.subtype) {
            case UIEventSubtypeRemoteControlPlay:
            case UIEventSubtypeRemoteControlPause:
            case UIEventSubtypeRemoteControlStop:
            case UIEventSubtypeRemoteControlTogglePlayPause:
                if ( self.player.rate ==1.0 ) {
                    [self.player pause];
                    [[MPMusicPlayerController applicationMusicPlayer] pause];
                } else {
                    [self.player play];
                    [[MPMusicPlayerController applicationMusicPlayer] play];
                }
                break;
                
            case UIEventSubtypeRemoteControlBeginSeekingBackward:
            case UIEventSubtypeRemoteControlBeginSeekingForward:
            case UIEventSubtypeRemoteControlEndSeekingBackward:
            case UIEventSubtypeRemoteControlEndSeekingForward:
            case UIEventSubtypeRemoteControlPreviousTrack:
            case UIEventSubtypeRemoteControlNextTrack:
//                self.player.currentTime = 0;
                break;
                
            default:
                break;
        }
    }
}


 //
//- (void)changeLockScreen{
//    Class playingInfoCenter = NSClassFromString(@"MPNowPlayingInfoCenter");
//
//    if (playingInfoCenter) {
//        UIImage *albumImage = [playerlist getAlbumImageWithSize:SCREENIMAGE_SIZE];
//        if(albumImage == nil){
//            albumImage = [UIImage imageNamed:@"artview_1.png"];
//        }
//        MPMediaItemArtwork *artWork = [[MPMediaItemArtwork alloc] initWithImage:albumImage];
//        
//
//        
//        NSMutableDictionary *songInfo = [[NSMutableDictionary alloc] init];
//        if(_curPlayItem != nil){
//            
//            [songInfo setObject:[_curPlayItem valueForKey:MPMediaItemPropertyTitle] forKey:MPMediaItemPropertyTitle];
//            [songInfo setObject:[_curPlayItem valueForKey:MPMediaItemPropertyArtist] forKey:MPMediaItemPropertyArtist];
//            [songInfo setObject:[_curPlayItem valueForKey:MPMediaItemPropertyPlaybackDuration] forKey:MPMediaItemPropertyPlaybackDuration];
//            
//        }else {
//            [songInfo setObject:_curPlayMusic.title forKey:MPMediaItemPropertyTitle];
//            [songInfo setObject:_curPlayMusic.artist forKey:MPMediaItemPropertyArtist];
//            [songInfo setObject:[[NSNumber alloc] initWithInteger:[self getDuration]] forKey:MPMediaItemPropertyPlaybackDuration];
//        }
//        [songInfo setObject:artWork forKey:MPMediaItemPropertyArtwork];
//        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songInfo];
//    }
//}


- (int)getDuration{
    return (int)CMTimeGetSeconds(player.currentItem.asset.duration);
}
- (int)getCurTime{
    return (int)CMTimeGetSeconds(player.currentTime);
}
- (void)syncPlayTimeLabel:(NSTimer *)t{
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
// 임시
-(float) getTime {
    int duration = [self getDuration];
    int currentTime = [self getCurTime];
    float ff = currentTime / (float)duration;
    return ff;
}

- (void)setAudioSession{
    NSError *error = nil;
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback withOptions:kAudioSessionProperty_OverrideCategoryMixWithOthers error:&error];
    
    [session setActive:YES error:&error];
}

- (void)updateInfo{
    [self.delegate setUser:userName setSound:soundName];
    [self.delegate1 setUser:userName setSound:soundName];
    [self.delegate2 setUser:userName setSound:soundName];
    [self.delegate3 setUser:userName setSound:soundName];
    [self.delegate4 setUser:userName setSound:soundName];
    [self.delegate1 notiPlay];
    [self.delegate2 notiPlay];
    [self.delegate3 notiPlay];
    [self.delegate4 notiPlay];
}

//-(void)updateTable{
//    [self.reloadDelegate reloadTable];
//}

- (void) saveData:(NSInteger)indexPathRowf
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSMutableArray *fishList = [NSMutableArray array];
    NSString *userNamef = [NSString stringWithFormat:@"%@",[playDB getNickNameOfMusicAtIndex:indexPathRowf]];
    NSString *soundNamef = [NSString stringWithFormat:@"%@",[playDB getNameOfMovieAtIndex:indexPathRowf]];
      NSLog(@"%@ , sound : %@",userNamef,soundNamef);
     NSString *soundIDf = [NSString stringWithFormat:@"%@",[playDB getSoundIdAtIndex:indexPathRowf]];
//    NSMutableArray *dd = [[NSMutableArray alloc]init];
//    [dd addObject:playerItem];
    
//    [defaults setObject:dd forKey:@"playitem"];
    [defaults setObject:userNamef forKey:@"userName"];
    [defaults setObject:soundNamef forKey:@"soundName"];
       [defaults setInteger:indexPathRowf forKey:@"indexpath"];
    [defaults setObject:soundIDf forKey:@"soundId"];
    NSLog(@"%d",indexPathRowf);
    
    [defaults synchronize];
}

- (void) loadData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *ff = [defaults objectForKey:@"indexpath"];
    [Player defaultCatalog];
    playDB = [PlayListDB sharedPlaylist];
    [playerlist setIndexPathrow:ff.integerValue];
}

-(void)playMusic:(NSURL *)url{
    playDB = [PlayListDB sharedPlaylist];
    [playDB fetchMovies];
    playerItem = [AVPlayerItem playerItemWithURL:url];
    
    // Subscribe to the AVPlayerItem's DidPlayToEndTime notification.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];
    player = [[AVPlayer alloc] initWithPlayerItem:playerItem];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(syncPlayTimeLabel:) userInfo:Nil repeats:YES];
    timer1 = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateInfo) userInfo:nil repeats:YES];
//    timer2 = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(getTime) userInfo:nil repeats:YES];
//    NSTimer *timer3 = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateIndex) userInfo:Nil repeats:YES];
     playerlist = [Player defaultCatalog];
    NSArray *albumImgTrack = [playDB albumimg];

    userName = [NSString stringWithFormat:@"%@",[playDB getNickNameOfMusicAtIndex:playerlist.indexPathRow]];
    soundName = [NSString stringWithFormat:@"%@",[playDB getNameOfMovieAtIndex:playerlist.indexPathRow]];
    NSString *ff = @"http://mixhips.nowanser.cloulu.com";
    ff = [ff stringByAppendingString:albumImgTrack[playerlist.indexPathRow]];
    NSLog(@"--%@",ff);
    NSURL *fee = [NSURL URLWithString:ff];
    NSData *img = [NSData dataWithContentsOfURL:fee];
    
    UIImage *albumImg = [UIImage imageWithData:img];
    
    [self.delegate setImg:playerlist.indexPathRow];
    
    
//    [self updateIndex];
//    [self updateTable];
    
    [self saveData:playerlist.indexPathRow];
    [self changeLockScreen:albumImg soundName:soundName userName:userName];
    [self setAudioSession];
    [self updateInfo];
    [self.delegate stopindicator];
    [player play];
}

-(void)itemDidFinishPlaying:(NSNotification *) notification {
    if(loop == YES){
        AVPlayerItem *p = [notification object];
        [p seekToTime:kCMTimeZero];
    }
    else{
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
}
@end
