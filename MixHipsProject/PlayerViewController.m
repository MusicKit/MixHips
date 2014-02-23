//
//  PlayerViewController.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 1. 27..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "PlayerViewController.h"
#import "PlayListViewController.h"
#import "Player.h"
#import "AppDelegate.h"
#import "PlaylistCatagory.h"
#import "RequestCenter.h"
#import "PlayListDB.h"
#import "UIImageView+AFNetworking.h"
#import "CommentViewController.h"
#import "SoundIDCatagory.h"
#import "AFHTTPRequestOperationManager.h"
#import "playerDelegate.h"

@interface PlayerViewController ()<AVAudioPlayerDelegate, AVAudioRecorderDelegate , playerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *play;
@property (weak, nonatomic) IBOutlet UIButton *fastButton;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *albumView;
@property (weak, nonatomic) IBOutlet UIProgressView *progresss;
@property (weak, nonatomic) IBOutlet UINavigationItem *titleNavi;
@property (weak, nonatomic) IBOutlet UIButton *loopButton;
@property (weak, nonatomic) IBOutlet UISlider *sliderTimer;





@end

@implementation PlayerViewController{
    UIActivityIndicatorView *indicator;
    SoundIDCatagory *soundCata;
    PlayListDB *playDB;
    Player *playerCata;
    PlaylistCatagory *playCatagory;
    PlayListViewController *list;
    NSInteger indexPath;
   // NSInteger indexPathRow;
    NSTimer *timer;
    NSArray *listTrack;
    NSArray *albumlistTrack;
    NSString *albumImgURL;
    BOOL isPlaying;
//    UIActivityIndicatorView *indicator;
}
@synthesize player;



//-(void)returnIndexPath:(NSInteger)indexPath{
//    indexPathRow =indexPath;
//    NSLog(@"ffffffff %d",indexPathRow);
//}

//-(IBAction)loopMusic:(id)sender{
//    playCatagory.player.numberOfLoops = -1;
//}

-(IBAction)dismissView:(id)sender{

    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

//-(IBAction) handleSliderValueChanged {
//	CMTime seekTime = playCatagory.player.currentItem.asset.duration;
//	seekTime.value = seekTime.value * self.progressSlider.value;
//	seekTime = CMTimeConvertScale (seekTime, player.currentTime.timescale,
//                                   kCMTimeRoundingMethod_RoundHalfAwayFromZero);
//	[playCatagory.player seekToTime:seekTime];
//}
-(IBAction)sliding:(id)sender{
    [playCatagory.player pause];
//    CMTime newTime = CMTimeMakeWithSeconds(self.sliderTimer.value, 1);
    [playCatagory changeTime:self.sliderTimer.value];
//    NSLog(@"%f",newTime);
//    [playCatagory.player play];
}

-(IBAction)toggleButton:(id)sender{
    if(playCatagory.player.rate ==1.0){
        self.play.selected = NO;
        [playCatagory.player pause];
    }
    else{
        self.play.selected = YES;
        [playCatagory.player play];
    }
}

-(IBAction)fastButton:(id)sender{
    playerCata = [Player defaultCatalog];
    playerCata.indexPathRow++;
    if(playerCata.indexPathRow > listTrack.count-1){
        playerCata.indexPathRow = 0;
        self.soundID= [NSString stringWithFormat:@"%@",listTrack[playerCata.indexPathRow]];
        [self setImg:playerCata.indexPathRow];
        [playCatagory playStart:self.soundID];
    }
    else{
    self.soundID = [NSString stringWithFormat:@"%@",listTrack[playerCata.indexPathRow]];
        [self setImg:playerCata.indexPathRow];
    [playCatagory playStart:self.soundID];
    }
}

-(IBAction)rewindButton:(id)sender{
    playerCata = [Player defaultCatalog];
    playerCata.indexPathRow--;
    [self setImg:playerCata.indexPathRow];
//    [self setProfile];

    self.soundID = [NSString stringWithFormat:@"%@",listTrack[playerCata.indexPathRow]];
    [playCatagory playStart:self.soundID];
}

-(IBAction)loopButton:(id)sender{
    if(self.loopButton.tag == 0){
          [playCatagory loopPlay];
        self.loopButton.tag =1;
    }
    else if(self.loopButton.tag == 1){
        [playCatagory notloopPlay];
    self.loopButton.tag = 0;
    }
}

-(void)updateProgressViewWithPlayer:(NSString *)string time:(float)time{
    self.sliderTimer.value = time;
    self.progresss.progress = time;
    self.progressLabel.text = string;
}

-(void)setUser:(NSString *)userNamef setSound:(NSString *)soundNamef{
    self.titleNavi.title = [NSString stringWithFormat:@"%@ - %@",soundNamef, userNamef];
    NSLog(@"%@", self.titleNavi.title );
    if(playCatagory.player.rate ==1){
        self.play.selected = NO;
    }
    else{
        self.play.selected = YES;
    }
}

-(void)setImg:(NSInteger)indexPathff{
    playDB = [PlayListDB sharedPlaylist];
    //albumlistTrack[indexPathff];
    NSLog(@"%@",albumlistTrack[indexPathff]);
    NSString *url = @"http://mixhips.nowanser.cloulu.com";
    self.albumImg = albumlistTrack[indexPathff];
    NSLog(@"dfdf %@",self.albumImg);
    url = [url stringByAppendingString:self.albumImg];
    NSURL *imgURL = [NSURL URLWithString:url];
    [self.albumView setImageWithURL:imgURL];
    
}

-(void)setProfile{
    playerCata = [Player defaultCatalog];
    NSString *url = @"http://mixhips.nowanser.cloulu.com";
    self.albumImg = [playerCata getAlbumImg];
    NSLog(@"dfdf %@",self.albumImg);
    url = [url stringByAppendingString:self.albumImg];
    NSURL *imgURL = [NSURL URLWithString:url];
    [self.albumView setImageWithURL:imgURL];
    if(playCatagory.player.rate ==1){
        self.play.selected = NO;
    }
    else{
        self.play.selected = YES;
    }
}

-(void)indicator{
    [indicator startAnimating];
}

-(void)stopindicator{
    [indicator stopAnimating];
}

//-(void)dismissVC{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationItem.backBarButtonItem setTitle:@" "];
    playDB = [PlayListDB sharedPlaylist];
    listTrack =  [playDB data];
    albumlistTrack = [playDB albumimg];
    [self setProfile];
    
    //self.title = @
    
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(dimissVC)];
//     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(dismissVC)];

}

//-(IBAction)dismissVC:(id)sender{
//    [UIView animateWithDuration:0.4 animations:^{
//        
//    }]
//}
-(void)viewWillDisappear:(BOOL)animated{
   [self.navigationController setToolbarHidden:NO];
    self.tabBarController.tabBar.hidden=NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
	// Do any additional setup after loading the view.
    self.tabBarController.tabBar.hidden=YES;
    playCatagory = [PlaylistCatagory defaultCatalog];
    playCatagory.delegate = self;
    player = nil;
    
    //indicator
    indicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(135, 200, 50, 50)];
    indicator.hidesWhenStopped = YES;
    [self.view addSubview:indicator];
    
    
    // [self.navigationController setToolbarHidden:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
