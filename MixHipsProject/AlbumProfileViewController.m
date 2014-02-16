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
#define kCellID @"IMG_CELL_ID1"

@interface AlbumProfileViewController ()< UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *toggleButton;
@property (weak, nonatomic) IBOutlet UIButton *followButton;
@property (strong, nonatomic)UIProgressView *progressBar;
@property (weak, nonatomic) IBOutlet UILabel *followingCount;
@property (weak, nonatomic) IBOutlet UILabel *followerCount;
@property (weak, nonatomic) IBOutlet UILabel *userSay;
@property (weak, nonatomic) IBOutlet UIImageView *userImg;


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
}

-(IBAction)toggleButton:(id)sender{
    if(playCatagory.player.rate == 1.0){
        [playCatagory pause];
    }
    else{
        [playCatagory.player play];
    }
}

/*
-(IBAction)toggleButton:(id)sender{
    
    UIBarButtonItem *pauseButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemPause target:self action:@selector(toggleButton:)];
    if(playCatagory.player.playing == YES){
        NSMutableArray *items = [self.toolbarItems mutableCopy];
        [items removeObjectAtIndex:1];
        [items insertObject:self.toggleButton atIndex:1];
        [self.navigationController.toolbar setItems:items animated:NO];
        [playCatagory stop];
        NSLog(@"555");
    }
    else if(playCatagory.player.playing==NO){
        NSMutableArray *items = [self.toolbarItems mutableCopy];
        [items removeObjectAtIndex:1];
        NSLog(@"%d 2222",items.count);
        [items insertObject:pauseButton atIndex:1];
        [self.navigationController.toolbar setItems:items animated:NO];
        [playCatagory playStart];
    }

}
 */

-(IBAction)followButton:(id)sender{
    [self AFNetworkingADFollow];
}
//network like{
-(void)AFNetworkingADFollow{
    NSString *d = [NSString stringWithFormat:@"%@",self.user_ID];
    NSString *i = [NSString stringWithFormat:@"7"]; ///   본인 아이디
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"send_id":i , @"receive_id":d};
    [manager POST: @"http://mixhips.nowanser.cloulu.com/action_follow" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self AFNetworkingAD];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
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
    
    NSArray *album = [dd objectForKey:@"albums"];
    albumID = [[NSMutableArray alloc]init];
    NSMutableArray *albumImg = [[NSMutableArray alloc]init];
    NSMutableArray *albumName = [[NSMutableArray alloc]init];
    NSMutableArray *like = [[NSMutableArray alloc]init];
    albumlist = [[NSMutableArray alloc]init];
    for(int i=0;i<album.count;i++)
    {
        [albumID addObject:[album[i] objectForKey:@"album_id"]];
        [albumImg addObject:[album[i] objectForKey:@"album_img_url"]];
        [albumName addObject:[album[i] objectForKey:@"album_name"]];
        [like addObject:[album[i] objectForKey:@"like_count"]];
        
        [albumlist addObject:[AlbumList hotArtistAlbumlist:albumID[i] album_img:albumImg[i] album_name:albumName[i] like:like[i]]];
    }

    [self.collectionView reloadData];
    
}
-(void)AFNetworkingAD{
    NSString *i = [NSString stringWithFormat:@"7"];
    NSString *d = [NSString stringWithFormat:@"%@",self.user_ID];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"foo":@"bar", @"my_id(user_id(본인))":i , @"user_id":d};
    [manager POST: @"http://mixhips.nowanser.cloulu.com/request_user"parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"JSON: %@", responseObject);
        [self test:responseObject];
        [self.collectionView reloadData];
        [self setProfile];
        //[self setLike];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


-(void)setProfile{
    self.title = self.list.user_Name;
    self.userSay.text = userSay1;
    self.followerCount.text = follwer;
    self.followingCount.text = following;
    NSString *url = @"http://mixhips.nowanser.cloulu.com";
    url = [url stringByAppendingString:userImg];
    NSURL *imgURL = [NSURL URLWithString:url];
    [self.userImg setImageWithURL:imgURL];

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

-(void)viewWillAppear:(BOOL)animated{
    
    
   // self.userImg =
    
    
//    if(playCatagory.player.playing==NO){
//        NSMutableArray *items = [self.toolbarItems mutableCopy];
//        [items removeObjectAtIndex:1];
//        [items insertObject:self.toggleButton atIndex:1];
//        [self.navigationController.toolbar setItems:items animated:NO];
//        NSLog(@"1");
//    }
//    else if(playCatagory.player.playing == YES){
//        NSMutableArray *items = [self.toolbarItems mutableCopy];
//        [items removeObjectAtIndex:1];
//        //UIBarButtonItem *pauseButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemPause target:self action:@selector(toggleButton:)];
//       // [items insertObject:pauseButton atIndex:1];
//        NSLog(@"44");
//        [self.navigationController.toolbar setItems:items animated:NO];
//    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.toolbar.hidden = NO;;
    [self AFNetworkingAD];
    self.tabBarController.tabBar.barTintColor = [UIColor orangeColor];
    abc=self.list.user_id;
    NSLog(@"zzrwt13r13r13r%@",abc);
    
    playCatagory = [[PlaylistCatagory defaultCatalog]init];
    
    
    self.progressBar = [[UIProgressView alloc] initWithFrame:CGRectMake(93, 25, 200, 2)];
    [self.navigationController.toolbar addSubview:self.progressBar];
    

	// Do any additional setup after loading the view.
    
//[self updateData];
    [self.collectionView reloadData];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
