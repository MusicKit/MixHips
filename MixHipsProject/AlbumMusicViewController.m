//
//  AlbumMusicViewController.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 1. 28..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "AlbumMusicViewController.h"
#import "PlayListDB.h"
#import "PlayListViewController.h"
#import "AlbumList.h"
#import "Catalog.h"
#import "AlbumCell.h"
#import "RequestCenter.h"
#import "AFHTTPRequestOperationManager.h"
#import "PlaylistCatagory.h"
#import "UIImageView+AFNetworking.h"

@interface AlbumMusicViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *albumName;
@property (weak, nonatomic) IBOutlet UIImageView *albumImg;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *artistName;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *listCount;
@end

@implementation AlbumMusicViewController{
    PlayListDB *playlist;
    NSString *is_like;
    NSString *soundName;
    NSString *soundURL;
    NSString *soundID;
    NSString *user_Id;
    NSString *albumName;
    NSString *list_count;
    NSString *albumImgURL;
    NSString *my_like;
    NSMutableArray *soundlist;
    NSArray *abc;
    NSMutableArray *soundIDArr;
    NSMutableArray *soundNameArr;
    NSMutableArray *soundURLArr;
}

-(IBAction)likeButton:(id)sender{
    NSLog(@"dfdf : %@",self.album_ID);
    NSLog(@"like ddd : %@",my_like);
    [self AFNetworkingADLike];
}

-(IBAction)allSelect:(id)sender{
    for (NSInteger r = 0; r < [self.tableView numberOfRowsInSection:0]; r++) {
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:r inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

-(IBAction)selectMusicPlay:(id)sender{
    PlayListViewController *dest = [[PlayListViewController alloc]init];
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSArray *indexPathArr = [self.tableView indexPathsForSelectedRows];
    for(indexPath in indexPathArr){
        AlbumList *albumlist = [[Catalog defaultCatalog] musicAt:indexPath.row];
        playlist = [PlayListDB sharedPlaylist];
        [playlist addMovieWithName:soundNameArr[indexPath.row] nickName:self.user_Name song_id:soundIDArr[indexPath.row]];
        NSLog(@"%@ name",self.user_Name);
        [playlist fetchMovies];
        dest.albumList = albumlist;
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//network like{
-(void)AFNetworkingADLike{
    NSString *d = [NSString stringWithFormat:@"%@",self.album_ID];
    NSString *i = [NSString stringWithFormat:@"7"]; ///   본인 아이디
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"user_id":i , @"album_id":d};
    [manager POST: @"http://mixhips.nowanser.cloulu.com/action_like" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


//Network

- (void)test:(NSDictionary *)dic {
    NSDictionary *dd = [NSDictionary dictionaryWithDictionary:dic];
    NSLog(@"%@",dd);
    albumName = [NSString stringWithFormat:@"%@",[dd objectForKey:@"album_name"]];
    albumImgURL = [NSString stringWithFormat:@"%@",[dd objectForKey:@"album_img_url"]];
    list_count = [NSString stringWithFormat:@"%@",[dd objectForKey:@"like_count"]];
    my_like = [NSString stringWithFormat:@"%@",[dd objectForKey:@"is_like:"]];
    NSLog(@"like : %@",my_like);
    NSLog(@"url %@",albumImgURL);
    
    NSArray *sound = [dd objectForKey:@"sounds"];
    soundIDArr = [[NSMutableArray alloc]init];
    soundNameArr = [[NSMutableArray alloc]init];
    soundURLArr = [[NSMutableArray alloc]init];
    soundlist = [[NSMutableArray alloc]init];
    for(int i=0;i<sound.count;i++)
    {
        [soundIDArr addObject:[sound[i] objectForKey:@"sound_id"]];
        [soundURLArr addObject:[sound[i] objectForKey:@"sound_url"]];
        [soundNameArr addObject:[sound[i] objectForKey:@"sound_name"]];
        
        [soundlist addObject:[AlbumList soundlist:soundNameArr[i] sound_id:soundIDArr[i] sound_url:soundURLArr[i]]];
    }
    [self.tableView reloadData];
    
}
-(void)AFNetworkingAD{
    NSString *d = [NSString stringWithFormat:@"%@",self.album_ID];
    NSLog(@"albumID : %@",self.album_ID);
    NSString *i = [NSString stringWithFormat:@"7"]; ///   본인 아이디
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"foo":@"bar", @"my_id(user_id(본인))":i , @"album_id":d};
    [manager POST: @"http://mixhips.nowanser.cloulu.com/request_album" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"JSON: %@", responseObject);
        [self test:responseObject];
        [self.tableView reloadData];
        [self setProfile];
        //[self setLike];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    
    return soundlist.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"music_CELL" forIndexPath:indexPath];
    self.albumList = [soundlist objectAtIndex:indexPath.row];
    [cell setProductInfo:self.albumList indexPath:indexPath.row];
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
/*
-(void)setLike{
    is_like = my_like;
    NSLog(@"is_like = %@",is_like);
    if([is_like isEqualToString:@"1"]){
        self.likeButton.titleLabel.text = [NSString stringWithFormat:@"1"];
        NSLog(@"like %@",my_like);
    }
    if ([is_like isEqualToString:@"0"])
    {
        self.likeButton.titleLabel.text = [NSString stringWithFormat:@"2"];
    }
}
*/
-(void)setProfile{
    NSLog(@"albumName  :  %@",albumName);
    NSLog(@"like count : %@",list_count);
    self.artistName.text = self.user_Name;
    self.albumName.text = [NSString stringWithFormat:@"%@",albumName];
    self.listCount.text = [NSString stringWithFormat:@"%@",list_count];
    NSString *url = @"http://mixhips.nowanser.cloulu.com";
    url = [url stringByAppendingString:albumImgURL];
    NSURL *imgURL = [NSURL URLWithString:url];
    [self.albumImg setImageWithURL:imgURL];
}

-(void)viewWillAppear:(BOOL)animated{
        [self AFNetworkingAD];
    
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

   
   
    

    

    NSLog(@"22222");
    	// Do any additional setup after loading the view.
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
