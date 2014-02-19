//
//  FollowViewController.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 1. 28..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "FollowViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "AlbumList.h"
#import "FollowingCell.h"
#import "AlbumProfileViewController.h"
#import "PlaylistCatagory.h"
#import "FollowDelegate.h"
@interface FollowViewController () <UICollectionViewDelegate, UICollectionViewDataSource, FollowDelegate>

@property (strong, nonatomic) UIProgressView *progressBar;


@end

@implementation FollowViewController{
    PlaylistCatagory *playCatagory;
    NSMutableArray *userID;
    NSMutableArray *user_img;
    NSMutableArray *user_name;
    NSMutableArray *followingList;
}

-(IBAction)toggleButton:(id)sender{
    if(playCatagory.player.rate == 1.0){
        [playCatagory pause];
    }
    else{
        [playCatagory.player play];
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:[NSString stringWithFormat:@"userName"]]){
        AlbumProfileViewController *dest = (AlbumProfileViewController *)segue.destinationViewController;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
        dest.user_ID = [userID objectAtIndex:indexPath.row];
        //AlbumList *list = [[listCatalog defaultCatalog] albumAt:indexPath.row];
        //dest.list = list;
    }
    
}


//network
- (void)test:(NSDictionary *)dic {
    NSDictionary *dd = [NSDictionary dictionaryWithDictionary:dic];
    NSArray *following = [dd objectForKey:@"following_list"];
    
    NSLog(@"aaqawrawr%@",following);
    userID = [[NSMutableArray alloc]init];
    user_img = [[NSMutableArray alloc]init];
    user_name = [[NSMutableArray alloc]init];
    
    followingList = [[NSMutableArray alloc]init];
    for(int i=0;i<following.count;i++)
    {
        [userID addObject:[following[i] objectForKey:@"user_id"]];
        [user_img addObject:[following[i] objectForKey:@"user_img_url"]];
        [user_name addObject:[following[i] objectForKey:@"user_name"]];
        
        [followingList addObject:[AlbumList followList:userID[i] user_name:user_name[i] user_img:user_img[i]]];
    }
    NSLog(@"ffff%@",followingList);


}
-(void)AFNetworkingAD{
    NSString *i = [NSString stringWithFormat:@"7"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"foo":@"bar", @"user_id":i};
    [manager POST: @"http://mixhips.nowanser.cloulu.com/show_following" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"JSON: %@", responseObject);
        [self test:responseObject];
        [self.collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return followingList.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FollowingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"follow_cell" forIndexPath:indexPath];
    self.list = [followingList objectAtIndex:indexPath.row];
    [cell setPlaylistInfo:self.list];
    cell.delegate = self;
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
    [self AFNetworkingAD];
    playCatagory = [PlaylistCatagory defaultCatalog];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
