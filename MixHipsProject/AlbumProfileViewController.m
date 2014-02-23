//
//  AlbumProfileViewController.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 1. 17..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "AlbumProfileViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "PlaylistCatagory.h"
#import "RequestCenter.h"
#import "ArtistProfileAlbumCell.h"
#import "AlbumMusicListViewController.h"
#import "AlbumMusicViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIImageView+AFNetworking.h"
#import "PlayListViewController.h"
#define kCellID @"IMG_CELL_ID1"

@interface AlbumProfileViewController ()< UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *followButton;
@property (strong, nonatomic)UIProgressView *progressBar;
@property (weak, nonatomic) IBOutlet UILabel *followingCount;
@property (weak, nonatomic) IBOutlet UILabel *followerCount;
@property (weak, nonatomic) IBOutlet UILabel *userSay;
@property (weak, nonatomic) IBOutlet UIImageView *userImgg;
@property (weak, nonatomic) IBOutlet UIView *netView;
@property (weak, nonatomic) IBOutlet UIButton *renetButton;
@property (weak, nonatomic) IBOutlet UIImageView *followImg;


@end

@implementation AlbumProfileViewController{
    NSMutableArray *albumlist;
    NSString *follwer;
    NSString *following;
    NSString *userImg;
    NSString *userSay1;
    NSString *userID;
    NSString *userName;
    NSString *is_follow;
    NSMutableArray *albumID;
    PlaylistCatagory *playCatagory;
    NSString *abc;
    UIActivityIndicatorView *indicator;
}

-(IBAction)listJoin:(id)sender{
    PlayListViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"playlist"];
    [self.navigationController pushViewController:nextVC animated:YES];
}


-(IBAction)followButton:(id)sender{
    [self AFNetworkingADFollow];
}
//network like{
-(void)AFNetworkingADFollow{
    NSString *d = [NSString stringWithFormat:@"%@",self.user_ID];
    NSString *i = [NSString stringWithFormat:@"6"]; ///   본인 아이디
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"send_id":i , @"receive_id":d};
    [manager POST: @"http://mixhips.nowanser.cloulu.com/action_follow" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self AFNetworkingAD];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(IBAction)restartNet:(id)sender{
    [self AFNetworkingAD];
    self.netView.hidden = YES;
}


//Network

- (void)test:(NSDictionary *)dic {
    NSDictionary *dd = [NSDictionary dictionaryWithDictionary:dic];
    NSLog(@"%@",dd);
    userID = [NSString stringWithFormat:@"%@",[dd objectForKey:@"user_id"]];
    userName = [NSString stringWithFormat:@"%@",[dd objectForKey:@"user_name"]];
    follwer = [NSString stringWithFormat:@"%@",[dd objectForKey:@"follower"]];
    following = [NSString stringWithFormat:@"%@", [dd objectForKey:@"following"]];
    userImg = [NSString stringWithFormat:@"%@", [dd objectForKey:@"user_img_url"]];
    userSay1 = [NSString stringWithFormat:@"%@",[dd objectForKey:@"user_say"]];
    is_follow = [NSString stringWithFormat:@"%@",[dd objectForKey:@"is_follow"]];
    
    NSLog(@"%@",userID);
    NSLog(@"%@",follwer);
    
    NSArray *album = [dd objectForKey:@"albums"];
    albumID = [[NSMutableArray alloc]init];
    NSMutableArray *albumImg = [[NSMutableArray alloc]init];
    NSMutableArray *albumName = [[NSMutableArray alloc]init];
    NSMutableArray *like = [[NSMutableArray alloc]init];
    albumlist = [[NSMutableArray alloc]init];
    NSString *string =  [NSString stringWithFormat:@"%@",[dd objectForKey:@"albums"]];
    if([string isEqualToString:@"<null>"]){
        
    }
    else{
    for(int i=0;i<album.count;i++)
    {
        [albumID addObject:[album[i] objectForKey:@"album_id"]];
        [albumImg addObject:[album[i] objectForKey:@"album_img_url"]];
        [albumName addObject:[album[i] objectForKey:@"album_name"]];
        [like addObject:[album[i] objectForKey:@"like_count"]];
        
        [albumlist addObject:[AlbumList hotArtistAlbumlist:albumID[i] album_img:albumImg[i] album_name:albumName[i] like:like[i]]];
    }
    }
    NSLog(@"%@",is_follow);
    if([is_follow isEqualToString:@"1"]){
        self.followImg.image = [UIImage imageNamed:@"following.png"];
    }
    else{
        self.followImg.image = [UIImage imageNamed:@"follow.png"];
    }

    [self.collectionView reloadData];
    
}
-(void)AFNetworkingAD{
    [indicator startAnimating];
    NSString *i = [NSString stringWithFormat:@"6"];
    NSString *d = [NSString stringWithFormat:@"%@",self.user_ID];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"foo":@"bar", @"my_id":i , @"user_id":d};
    [manager POST: @"http://mixhips.nowanser.cloulu.com/request_user"parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"JSON: %@", responseObject);
        [self test:responseObject];
        [indicator stopAnimating];
        [self.collectionView reloadData];
        [self setProfile];
        //[self setLike];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        self.netView.hidden = NO;
    }];
}


-(void)setProfile{
    self.title = self.list.user_Name;
    self.userSay.text = userSay1;
    self.followerCount.text = follwer;
    self.followingCount.text = following;
    NSString *url = @"http://mixhips.nowanser.cloulu.com";
    url = [url stringByAppendingString:userImg];
    NSLog(@"%@",url);
    NSURL *imgURL = [NSURL URLWithString:url];
    [self.userImgg setImageWithURL:imgURL];
    self.title = [NSString stringWithFormat:@"%@",userName];
    
    if([is_follow isEqualToString:[NSString stringWithFormat:@"1"]]){
        self.followImg.image = [UIImage imageNamed:@"following.png"];
    }
    else{
        self.followImg.image = [UIImage imageNamed:@"follow.png"];
    }

}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:[NSString stringWithFormat:@"%@", @"soundlist"]]){

    AlbumMusicViewController *dest = (AlbumMusicViewController *)segue.destinationViewController;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
    dest.album_ID = albumID[indexPath.row];
    dest.user_ID = userID;
    dest.user_Name = userName;
    }
    //AlbumList *list = [[listCatalog defaultCatalog] albumAt:indexPath.row];
    //dest.list = list;
    if(segue.identifier == [NSString stringWithFormat:@"%@", @"musiclist"]){
    }
}





//////////////////////////////////////////

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	    return [albumlist count];
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	// 재사용 큐에 셀을 가져온다
	ArtistProfileAlbumCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    self.list = [albumlist objectAtIndex:indexPath.row];
    [cell setProductInfo:self.list];
	return cell;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dismissVC{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [self AFNetworkingAD];
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.netView.hidden = YES;
    CALayer * l = [self.netView layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:6.0];
    
    //indicator
    indicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(135, 200, 50, 50)];
    indicator.hidesWhenStopped = YES;
    [self.view addSubview:indicator];

    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(dismissVC)];
    
    abc=self.list.user_id;
    
    playCatagory = [[PlaylistCatagory defaultCatalog]init];
    
    [self.collectionView reloadData];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
