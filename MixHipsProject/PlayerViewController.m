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

@interface PlayerViewController ()<AVAudioPlayerDelegate, AVAudioRecorderDelegate>
@property (weak, nonatomic) IBOutlet UIButton *play;
@property (weak, nonatomic) IBOutlet UIButton *fastButton;
@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@property (weak, nonatomic) IBOutlet UIButton *volumnButton;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;




@end

@implementation PlayerViewController{
    PlaylistCatagory *playCatagory;
    PlayListViewController *list;
    NSTimer *timer;
}
@synthesize player;

-(IBAction)loopMusic:(id)sender{
    playCatagory.player.numberOfLoops = -1;
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

-(IBAction)toggleButton:(id)sender{

    if(playCatagory.player.playing == YES){
        [timer invalidate];
        timer = nil;
        [self.play setTitle:@"Play" forState:UIControlStateNormal];
        [playCatagory pause];
    }
    else if(playCatagory.player.playing==NO){
        
        timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timeFired:) userInfo:nil repeats:YES];
        [self.play setTitle:@"Pause" forState:UIControlStateNormal];
        [playCatagory playStart];
        
    }
}
-(void)timeFired:(NSTimer *)t{
     if(playCatagory.player.playing == YES){
    double time = [playCatagory returnTime];
//    self.progressSlider.minimumValue = 0;
//    self.progressSlider.maximumValue = time;
    [self.progressSlider setValue:time animated:NO];
    
    self.progressLabel.text = [NSString stringWithFormat:@"%i:%.02i",(int)time/60, (int)time %60];

      }
        else{
            [self.progressSlider setValue:0 animated:YES];
        }
}


//볼륨슬라이더
-(int)returnVolumSliderValue{
    return self.volumeSlider.value;
}
-(IBAction)updateVolume:(id)sender{
    playCatagory.player.volume = self.volumeSlider.value;
}

-(void)updateProgress:(NSTimer *)timer{
    
}





- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.volumeSlider.hidden = YES;
	// Do any additional setup after loading the view.
    [self.navigationController setToolbarHidden:YES];
    playCatagory = [[PlaylistCatagory defaultCatalog]init];
    player = nil;
    
    

    
//    [[AVAudioSession sharedInstance]setCategory:AVAudioSessionCategoryAmbient error:nil];
//    
//    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
//    [[AVAudioSession sharedInstance] setActive: YES error: nil];
//    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
     [self.navigationController setToolbarHidden:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    if(playCatagory.player.playing == YES){
        [self.play setTitle:@"pause" forState:UIControlStateNormal];
        NSLog(@"555");
    }
    else if(playCatagory.player.playing==NO){
        [self.play setTitle:@"play" forState:UIControlStateNormal];
        NSLog(@"666");
    }
    player.volume = self.volumeSlider.value;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
