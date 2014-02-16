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

#define IMAGE_NUM 3

@interface HomingViewController ()<UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, AVAudioPlayerDelegate, UIPageViewControllerDelegate>
{
    int loadedPageCount;
    UIScrollView *_scrollView;
    UIPageControl *pageControl;
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
@property (nonatomic,strong) NSMutableArray *collectionData;
@property (nonatomic,strong) NSMutableArray *allCells;


@end

@implementation HomingViewController{
    PlayListViewController *playerVC;
    PlaylistCatagory *playCatagory;
    NSString *soundID;
    NSArray *listTrack;
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


-(void)updateProgress:(NSTimer *)timer{
    //self.progressBar.progress = playCatagory.player.currentTime;
//    self.progressBar.progress = playCatagory.player.currentTime / playCatagory.player.duration;
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
    for(int i=0;i<3;i++)
    {
        [userID addObject:[abc[i] objectForKey:@"user_id"]];
        [image addObject:[abc[i] objectForKey:@"user_img_url"]];
        
        [userName addObject:[abc[i] objectForKey:@"user_name"]];
        [HotArtist addObject:[AlbumList hotArtistList:userID[i] userName:userName[i] userImg:image[i]]];
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
    for(int i=0;i<9;i++)
    {
        [albumID_Album addObject:[abc[i] objectForKey:@"album_id"]];
        [albumImage addObject:[abc[i] objectForKey:@"album_img_url"]];
        
        [albumName addObject:[abc[i] objectForKey:@"album_name"]];
        [userName_Album addObject:[abc[i] objectForKey:@"user_name"]];
        [likeCount addObject:[abc[i] objectForKey:@"like_count"]];
        [HotAlbum addObject:[AlbumList hotAlbumList:albumID_Album[i] album_name:albumName[i] album_img:albumImage[i] user_name:userName_Album[i] like_count:likeCount[i]]];
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


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationController.toolbar.hidden = NO;
	// Do any additional setup after loading the view, typically from a nib.

       playCatagory = [PlaylistCatagory defaultCatalog];
    self.progressBar = [[UIProgressView alloc] initWithFrame:CGRectMake(93, 25, 200, 2)];
    [self.navigationController.toolbar addSubview:self.progressBar];

    scrolltime = 0;
    setSmallSize = -1;
   
}

-(void)viewWillAppear:(BOOL)animated{
    [self AFNetworkingAD];
    [self AFNetworkingAlbum];
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
