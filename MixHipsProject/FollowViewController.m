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
#import "PlayListViewController.h"
@interface FollowViewController () <UICollectionViewDelegate, UICollectionViewDataSource, FollowDelegate>

@property (strong, nonatomic) UIProgressView *progressBar;
@property (weak, nonatomic) IBOutlet UIView *netView;
@property (weak, nonatomic) IBOutlet UIButton *renetButton;


@end

@implementation FollowViewController{
    PlaylistCatagory *playCatagory;
    NSMutableArray *userID;
    NSMutableArray *user_img;
    NSMutableArray *user_name;
    NSMutableArray *followingList;
    UIActivityIndicatorView *indicator;
}

-(IBAction)listJoin:(id)sender{
    PlayListViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"playlist"];
    [self.navigationController pushViewController:nextVC animated:YES];
}

-(IBAction)restartNet:(id)sender{
    [self AFNetworkingAD];
    self.netView.hidden = YES;
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
    [indicator startAnimating];
    NSString *i = [NSString stringWithFormat:@"4"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"foo":@"bar", @"user_id":i};
    [manager POST: @"http://mixhips.nowanser.cloulu.com/show_following" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"JSON: %@", responseObject);
        [self test:responseObject];
        [indicator stopAnimating];
        [self.collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        self.netView.hidden = NO;
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

-(void)dismissVC{
    [self.navigationController popViewControllerAnimated:YES];
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
    
    self.netView.hidden = YES;
    CALayer * l = [self.netView layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:6.0];
    
    indicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(135, 200, 50, 50)];
    indicator.hidesWhenStopped = YES;
    [self.view addSubview:indicator];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(dismissVC)];
 
	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
