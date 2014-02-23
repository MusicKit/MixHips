//
//  HomingViewController.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 1. 23..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "HomingViewController.h"
#import "PlayListViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "AFHTTPRequestOperationManager.h"
#import "PlaylistCatagory.h"
#import "AlbumList.h"
#import "HotArtistCell.h"
#import "AlbumProfileViewController.h"
#import "AlbumMusicViewController.h"
#import "MyCell.h"
#import "playerDelegate.h"
#import "PlayListViewController.h"
#import "cacheList.h"
#import "PlayListDB.h"
#import "PlayerViewController.h"

#define IMAGE_NUM 3

@interface HomingViewController ()<UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, AVAudioPlayerDelegate, UIPageViewControllerDelegate, playDelegate1>
{
    int loadedPageCount;
    UIScrollView *_scrollView;
    NSTimer *timer;
    NSMutableArray *HotArtist;
    NSMutableArray *HotAlbum;
    NSMutableArray *userName_Album;
    NSMutableArray *albumID_Album;
    NSInteger setSmallSize;
    NSInteger scrolltime;
    NSMutableArray *userID;
    NSString *soundid11;
    cacheList *data;
    UIActivityIndicatorView *indicator;
    CGRect currentCollectionFrame;
}
@property (strong, nonatomic) UIButton *testButton;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *hotAlbumCollectionView;
@property (weak, nonatomic) IBOutlet UIView *networkView;
@property (weak, nonatomic) IBOutlet UIButton *reNetButton;
@property (strong, nonatomic) UIProgressView *progressBar;
@property (strong , nonatomic)UILabel *titleLabel;
@property (nonatomic,strong) NSMutableArray *collectionData;
@property (nonatomic,strong) NSMutableArray *allCells;


@end

@implementation HomingViewController{
    PlayListViewController *playerVC;
    PlaylistCatagory *playCatagory;
    NSString *soundID;
    NSArray *listTrack;
    NSString *soundName1;
    NSString *userName1;
    BOOL ch;
}

-(IBAction)listJoin:(id)sender{
    PlayListViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"playlist"];
    [self.navigationController pushViewController:nextVC animated:YES];
}

-(IBAction)restartNet:(id)sender{
    [self AFNetworkingAlbum];
    self.networkView.hidden = YES;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat pageWidth = self.collectionView.frame.size.width;
    self.pageControl.currentPage = self.hotAlbumCollectionView.contentOffset.x / pageWidth;
}



-(void)toggleButton:(id)sender{
    if(ch == YES){
        [playCatagory playStart:soundid11];
        [self.testButton setImage:[UIImage imageNamed:@"stop.png"] forState:UIControlStateNormal];
    }
    else{
        if(playCatagory.player.rate == 1.0){
            [playCatagory.player pause];
            [self.testButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        }
        else{
            [playCatagory.player play];
            [self.testButton setImage:[UIImage imageNamed:@"stop.png"] forState:UIControlStateNormal];
        }

    }


}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(collectionView == self.hotAlbumCollectionView)
    NSLog(@"index %d",indexPath.row);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqual:[NSString stringWithFormat:@"album"]]){
        AlbumMusicViewController *dest1 = (AlbumMusicViewController *)segue.destinationViewController;
        NSIndexPath *indexPath1= [self.hotAlbumCollectionView indexPathForCell:sender];
        dest1.album_ID =[albumID_Album objectAtIndex:indexPath1.row];
        dest1.user_Name =[userName_Album objectAtIndex:indexPath1.row];
    }
    if([segue.identifier isEqual:[NSString stringWithFormat:@"artist"]]){
        AlbumProfileViewController *dest = (AlbumProfileViewController *)segue.destinationViewController;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
        dest.user_ID = [userID objectAtIndex:indexPath.row];
    }
    if ([segue.identifier isEqual:[NSString stringWithFormat:@"soundlist"]]) {
        
    }
}



///////////////////////////////////



//network hotuser
- (void)test:(NSDictionary *)dic {
    NSDictionary *dd = [NSDictionary dictionaryWithDictionary:dic];
    NSArray *abc = [dd objectForKey:@"hot_user"];
    userID = [[NSMutableArray alloc]init];
    NSMutableArray *image = [[NSMutableArray alloc]init];
    NSMutableArray *userName = [[NSMutableArray alloc]init];
        HotArtist = [[NSMutableArray alloc]init];
    NSString *string = [NSString stringWithFormat:@"1"];
    for(int i=0;i<3;i++)
    {
        if([string isEqualToString:@"<null>"])
        {
            break;
                    }
        else{
        [userID addObject:[abc[i] objectForKey:@"user_id"]];
        [image addObject:[abc[i] objectForKey:@"user_img_url"]];
        
        [userName addObject:[abc[i] objectForKey:@"user_name"]];
        [HotArtist addObject:[AlbumList hotArtistList:userID[i] userName:userName[i] userImg:image[i]]];
            string = [NSString stringWithFormat:@"%@",abc[i]];
        }
    }
    
}

-(void)notiPlay{
    ch = NO;
}

-(void)AFNetworkingAD{
    [indicator startAnimating];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"foo":@"bar"};
    [manager POST: @"http://mixhips.nowanser.cloulu.com/request_hot_user" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"JSON: %@", responseObject);
        [self test:responseObject];
        [indicator stopAnimating];
        [self.collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

//networ hotalbum
- (void)albumtest:(NSDictionary *)dic {
    NSDictionary *dd = [NSDictionary dictionaryWithDictionary:dic];
    NSArray *abc = [dd objectForKey:@"hot_album"];
    albumID_Album = [[NSMutableArray alloc]init];
    NSMutableArray *albumImage = [[NSMutableArray alloc]init];
    NSMutableArray *albumName = [[NSMutableArray alloc]init];
    userName_Album = [[NSMutableArray alloc]init];
    NSMutableArray *likeCount = [[NSMutableArray alloc]init];
    HotAlbum = [[NSMutableArray alloc]init];
    NSString *string = [NSString stringWithFormat:@"%@",abc[0]];
    if([string isEqualToString:@"<null>"]){
    }
    else{
    for(int i=0;i<9;i++)
    {
        if([string isEqualToString:@"<null>"])
        {
            break;
        }
        else{

        [albumID_Album addObject:[abc[i] objectForKey:@"album_id"]];
        [albumImage addObject:[abc[i] objectForKey:@"album_img_url"]];
        
        [albumName addObject:[abc[i] objectForKey:@"album_name"]];
        [userName_Album addObject:[abc[i] objectForKey:@"user_name"]];
        [likeCount addObject:[abc[i] objectForKey:@"like_count"]];
        [HotAlbum addObject:[AlbumList hotAlbumList:albumID_Album[i] album_name:albumName[i] album_img:albumImage[i] user_name:userName_Album[i] like_count:likeCount[i]]];
            string = [NSString stringWithFormat:@"%@",abc[i]];
        }
        NSLog(@"%@",string);
    }
    }
    
}

-(void)AFNetworkingAlbum{
    [indicator startAnimating];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"foo":@"bar"};
    [manager POST: @"http://mixhips.nowanser.cloulu.com/request_hot_album" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"JSON: %@", responseObject);
        [self albumtest:responseObject];
        [indicator stopAnimating];
        [self.hotAlbumCollectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        self.networkView.hidden = NO;
    }];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger i ;
    if(collectionView == self.hotAlbumCollectionView){
        [self.hotAlbumCollectionView setContentSize:CGSizeMake(960, 138)];
        i = [HotAlbum count];
    }
    if(collectionView == self.collectionView){
        i = [HotArtist count];
    }
    return i;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell;
    if(collectionView == self.collectionView) {
    HotArtistCell *cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotArtist_cell" forIndexPath:indexPath];
    self.list = [HotArtist objectAtIndex:indexPath.row];
    [cell1 setProductInfo:self.list];
        cell = cell1;
    }
    if(collectionView == self.hotAlbumCollectionView){
        [self.hotAlbumCollectionView setContentSize:CGSizeMake(960, 138)];
        MyCell *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotAlbumlist" forIndexPath:indexPath];
        //cell2.label.text = [self.collectionData objectAtIndex:indexPath.row];
        self.list = [HotAlbum objectAtIndex:indexPath.row];
        [cell2 setProductInfo:self.list];
        cell = cell2;
    }
    return cell;
}

-(void)updateProgressViewWithPlayer:(NSString *)string time:(float)time{
   self.progressBar.progress = time;
    self.progressBar.progress = [[PlaylistCatagory defaultCatalog] getTime];
    if(playCatagory.player.rate == 1.0){
        [self.testButton setImage:[UIImage imageNamed:@"stop.png"] forState:UIControlStateNormal];
    }
    else{
        [self.testButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    }

}

-(void)setUser:(NSString *)userNamef setSound:(NSString *)soundNamef{
    soundName1 = soundNamef;
    userName1 = userNamef;
    if(soundName1 == NULL){
        
    }
    else{
//        [self.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
//        [self.titleLabel setBackgroundColor:[UIColor clearColor]];
//        [self.titleLabel setTextColor:[UIColor blackColor]];
        [self.titleLabel setText:[NSString stringWithFormat:@"%@ - %@",soundName1, userName1]];
//        [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
//        // [titleV addSubview:self.titleLabel];
//        [self.navigationController.toolbar addSubview:self.titleLabel];
    }
}

- (void) loadData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *userName11 = [defaults objectForKey:@"userName"];
    NSString *soundName11 = [defaults objectForKey:@"soundName"];
    soundid11 = [defaults objectForKey:@"soundId"];
    
    
    [self.titleLabel setText:[NSString stringWithFormat:@"%@ - %@",soundName11, userName11]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    PlayListDB *playDB = [PlayListDB sharedPlaylist];
    [playDB fetchMovies];
    
    ch = YES;
    //musictitle
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(92 , 7, 200, 20)];
    [self.titleLabel setFont:[UIFont fontWithName:@"system - system" size:10]];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setTextColor:[UIColor blackColor]];
    [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [self.navigationController.toolbar addSubview:self.titleLabel];
    
    [self loadData];
    self.navigationController.toolbar.hidden = NO;

    self.networkView.hidden = YES;
    CALayer * l = [self.networkView layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:6.0];
    
    //재생버튼
    self.testButton = [[UIButton alloc]initWithFrame:CGRectMake( 50,2,40 ,40)];
    [self.testButton addTarget:self action:@selector(toggleButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.testButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    [self.navigationController.toolbar addSubview:self.testButton];
    
    
    //프로그래스바
    self.progressBar = [[UIProgressView alloc] initWithFrame:CGRectMake(93, 30, 200, 4)];
    [self.progressBar setTintColor:[UIColor blackColor]];
    [self.navigationController.toolbar addSubview:self.progressBar];
    
    //indicator
    indicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(135, 200, 50, 50)];
    indicator.hidesWhenStopped = YES;
    [self.view addSubview:indicator];
    
    
    playCatagory = [PlaylistCatagory defaultCatalog];
    playCatagory.delegate1 = self;

    scrolltime = 0;
    setSmallSize = -1;
   
}



-(void)viewWillAppear:(BOOL)animated{
    playCatagory = [PlaylistCatagory defaultCatalog];
    
    
    playCatagory.delegate1 = self;
    [self AFNetworkingAD];
    [self AFNetworkingAlbum];
    self.progressBar.progress = [[PlaylistCatagory defaultCatalog] getTime];
    if(playCatagory.player.rate == 1.0){
        [self.testButton setImage:[UIImage imageNamed:@"stop.png"] forState:UIControlStateNormal];
    }
    else{
        [self.testButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    }
    
    [self.navigationController setNavigationBarHidden:YES];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
