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
@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@property (weak, nonatomic) IBOutlet UIButton *volumnButton;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *albumView;
@property (weak, nonatomic) IBOutlet UIProgressView *progresss;





@end

@implementation PlayerViewController{
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
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(IBAction)joinCommnet:(id)sender{
    [[SoundIDCatagory defaultCatalog] setSoundid:self.soundID];
    NSLog(@"------ %@",self.soundID);
}

-(IBAction)showVolume:(id)sender{
    if(self.volumnButton.tag == 1){
        self.volumeSlider.hidden = NO;
        self.volumnButton.tag = 0;
    }
    else if(self.volumnButton.tag == 0){
        self.volumeSlider.hidden = YES;
        self.volumnButton.tag = 1;
    }
}


-(void)updateProgressViewWithPlayer:(NSString *)string time:(float)time{
    self.progresss.progress = time;
    self.progressLabel.text = string;
}

//- (IBAction)currentTimeSliderTouchUpInside:(id)sender
//{
//    [playCatagory stop];
//    self.player.currentTime = self.currentTimeSlider.value;
//
//    [self play:self];
//}


-(IBAction) handleSliderValueChanged {
	CMTime seekTime = playCatagory.player.currentItem.asset.duration;
	seekTime.value = seekTime.value * self.progressSlider.value;
	seekTime = CMTimeConvertScale (seekTime, player.currentTime.timescale,
                                   kCMTimeRoundingMethod_RoundHalfAwayFromZero);
	[playCatagory.player seekToTime:seekTime];
}


-(IBAction)toggleButton:(id)sender{
    if(self.play.tag == 0){
    playerCata = [Player defaultCatalog];
    NSLog(@"list : %@", listTrack[indexPath]);
    self.soundID = [NSString stringWithFormat:@"%@",listTrack[indexPath]];
    [playCatagory playStart:self.soundID];
   // [self updateProgress];
        self.play.titleLabel.text = @"puase";
        self.play.tag = 1;
    }
    else if(self.play.tag == 1){
        [playCatagory pause];
        self.play.titleLabel.text = @"play";
        self.play.tag = 0;
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
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    playDB = [PlayListDB sharedPlaylist];
    listTrack =  [playDB data];
    albumlistTrack = [playDB albumimg];
   

    
    
    if(playCatagory.player.rate ==1){
        self.play.titleLabel.text = @"pause";
    }
    else{
        self.play.titleLabel.text = @"play";
    }
}


-(void)viewWillDisappear:(BOOL)animated{
   [self.navigationController setToolbarHidden:NO];
    self.tabBarController.tabBar.hidden=NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.volumeSlider.hidden = YES;
	// Do any additional setup after loading the view.
    self.tabBarController.tabBar.hidden=YES;
    playCatagory = [PlaylistCatagory defaultCatalog];
    playCatagory.delegate = self;
    player = nil;
    
    
     [self.navigationController setToolbarHidden:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
