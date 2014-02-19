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
    
    CGRect currentCollectionFrame;
}
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *toggleButton;
@property (weak, nonatomic) IBOutlet UICollectionView *hotAlbumCollectionView;
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
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat pageWidth = self.collectionView.frame.size.width;
    self.pageControl.currentPage = self.hotAlbumCollectionView.contentOffset.x / pageWidth;
    NSLog(@"넘겨져라");
}


-(IBAction)toggleButton:(id)sender{
    if(playCatagory.player.rate == 1.0){
        [playCatagory pause];
    }
    else{
        [playCatagory.player play];
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
            NSLog(@"%@",string);
        }
        NSLog(@"%@",string);
    }
    [self.collectionView reloadData];
    NSLog(@"%@",HotArtist);
}

-(void)AFNetworkingAD{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"foo":@"bar"};
    [manager POST: @"http://mixhips.nowanser.cloulu.com/request_hot_user" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"JSON: %@", responseObject);
        [self test:responseObject];
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
    [self.hotAlbumCollectionView reloadData];
}

-(void)AFNetworkingAlbum{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"foo":@"bar"};
    [manager POST: @"http://mixhips.nowanser.cloulu.com/request_hot_album" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"JSON: %@", responseObject);
        [self albumtest:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger i ;
    if(collectionView == self.hotAlbumCollectionView){
        [self.hotAlbumCollectionView setContentSize:CGSizeMake(960, 100)];
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
        [self.hotAlbumCollectionView setContentSize:CGSizeMake(960, 100)];
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
}

-(void)setUser:(NSString *)userNamef setSound:(NSString *)soundNamef{
    soundName1 = soundNamef;
    userName1 = userNamef;
}

////////////////////

//-(void)viewDidLayoutSubviews{
//    
//    
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"top_bAR.png"] forBarMetrics:UIBarMetricsDefault];
//    //[[UIToolbar appearance]setBackgroundImage:[UIImage imageNamed:@"background_2.png"] forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
//    [[UITabBar appearance]setBackgroundImage:[UIImage imageNamed:@"top_bAR.png"]];
//}



- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationController.toolbar.hidden = NO;
	// Do any additional setup after loading the view, typically from a nib.
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(92 , 5, 200, 20)];
    
    self.progressBar = [[UIProgressView alloc] initWithFrame:CGRectMake(93, 28, 200, 4)];
    [self.navigationController.toolbar addSubview:self.progressBar];
    playCatagory = [PlaylistCatagory defaultCatalog];
    playCatagory.delegate1 = self;
    

    scrolltime = 0;
    setSmallSize = -1;
   
}

-(void)viewWillAppear:(BOOL)animated{
    [self AFNetworkingAD];
    [self AFNetworkingAlbum];
    
    
    if(soundName1 == NULL){
        
    }
    else{
                    [self.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
        [self.titleLabel setBackgroundColor:[UIColor clearColor]];
        [self.titleLabel setTextColor:[UIColor blackColor]];
        [self.titleLabel setText:[NSString stringWithFormat:@"%@ - %@",soundName1, userName1]];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        // [titleV addSubview:self.titleLabel];
        [self.navigationController.toolbar addSubview:self.titleLabel];
    }
    
   // UIView *titleV = [[[UIView alloc]init]initWithFrame:CGRectMake(92, 10, 200, 13)];
    
    
    
   // [self progressBar];
//    NSLog(@"%d",[[PlaylistCatagory defaultCatalog] getCurTime]);
//    NSLog(@"%d",[[PlaylistCatagory defaultCatalog] getDuration]);
//
    [self.navigationController setNavigationBarHidden:YES];
//    if(playCatagory.player.rate == 1.0){
//        NSLog(@"%f", [playCatagory getTimer]);
//        self.progressBar.progress = [playCatagory getTimer];
//    }
//    else{
//        
//    }

    
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
