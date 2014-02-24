//
//  FollowerViewController.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 12..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "FollowerViewController.h"
#import "AlbumProfileViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "FollowerCell.h"
#import "PlaylistCatagory.h"
#import "PlayListViewController.h"

@interface FollowerViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *netView;
@property (weak, nonatomic) IBOutlet UIButton *renetButton;
@property (strong, nonatomic) UIProgressView *progressBar;

@end

@implementation FollowerViewController
{
    PlaylistCatagory *playCatagory;
    NSMutableArray *userID;
    NSMutableArray *user_img;
    NSMutableArray *user_name;
    NSMutableArray *followerList;
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
    NSArray *follower = [dd objectForKey:@"following_list"];

    userID = [[NSMutableArray alloc]init];
    user_img = [[NSMutableArray alloc]init];
    user_name = [[NSMutableArray alloc]init];
    
    followerList = [[NSMutableArray alloc]init];
    for(int i=0;i<follower.count;i++)
    {
        [userID addObject:[follower[i] objectForKey:@"user_id"]];
        [user_img addObject:[follower[i] objectForKey:@"user_img_url"]];
        [user_name addObject:[follower[i] objectForKey:@"user_name"]];
        
        [followerList addObject:[AlbumList followList:userID[i] user_name:user_name[i] user_img:user_img[i]]];
    }

}
-(void)AFNetworkingAD{
    [indicator startAnimating];
    NSString *i = [NSString stringWithFormat:@"4"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"foo":@"bar", @"user_id":i};
    [manager POST: @"http://mixhips.nowanser.cloulu.com/show_follower" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
    return followerList.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FollowerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"follower_cell" forIndexPath:indexPath];
    self.list = [followerList objectAtIndex:indexPath.row];
    [cell setPlaylistInfo:self.list];
    return cell;
}

-(void)dismissVC{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [self AFNetworkingAD];
    playCatagory = [PlaylistCatagory defaultCatalog];
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
    
    indicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(135, 200, 50, 50)];
    indicator.hidesWhenStopped = YES;
    [self.view addSubview:indicator];
    
    self.netView.hidden = YES;
    CALayer * l = [self.netView layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:6.0];

    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(dismissVC)];
    
  
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
