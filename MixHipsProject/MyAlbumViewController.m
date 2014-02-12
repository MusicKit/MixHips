//
//  MyAlbumViewController.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 1. 28..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "MyAlbumViewController.h"
#import "AlbumList.h"
#import "MyAlbumCell.h"
#import "Catalog.h"
#import "PlayListViewController.h"
#import "PlayListDB.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIImageView+AFNetworking.h"
#import "PlayListDB.h"

@interface MyAlbumViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *albumName;
@property (weak, nonatomic) IBOutlet UIImageView *albumImg;

@end

@implementation MyAlbumViewController{
    NSString *albumName;
    NSString *albumImgURL;
    NSString *userName;
    NSMutableArray *soundIDArr;
    NSMutableArray *soundNameArr;
    NSMutableArray *soundURLArr;
    NSMutableArray *soundlist;
    PlayListDB *playlist;
    MyAlbumCell *cell;
}

/* 보류
-(IBAction)selectMusicPlay:(id)sender{
    PlayListViewController *dest = [[PlayListViewController alloc]init];
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSArray *indexPathArr = [self.tableView indexPathsForSelectedRows];
    for(indexPath in indexPathArr){
        AlbumList *albumlist = [[Catalog defaultCatalog] musicAt:indexPath.row];
        playlist = [PlayListDB sharedPlaylist];
        [playlist addMovieWithName:albumlist.songTitle nickName:albumlist.nickName];
        [playlist fetchMovies];
        dest.albumList = albumlist;
    }
}
 */

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
        [playlist addMovieWithName:soundNameArr[indexPath.row] nickName:userName song_id:soundIDArr[indexPath.row]];
        [playlist fetchMovies];
        dest.albumList = albumlist;
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)test:(NSDictionary *)dic {
    NSDictionary *dd = [NSDictionary dictionaryWithDictionary:dic];
    albumName = [NSString stringWithFormat:@"%@",[dd objectForKey:@"album_name"]];
    albumImgURL = [NSString stringWithFormat:@"%@",[dd objectForKey:@"album_img_url"]];
    userName = [NSString stringWithFormat:@"%@",[dd objectForKey:@"user_name"]];
    //list_count = [NSString stringWithFormat:@"%@",[dd objectForKey:@"like_count"]];
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
        [self setProfile];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(void)setProfile{
    self.albumName.text = albumName;
    NSString *url = @"http://mixhips.nowanser.cloulu.com";
    url = [url stringByAppendingString:albumImgURL];
    NSURL *imgURL = [NSURL URLWithString:url];
    [self.albumImg setImageWithURL:imgURL];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return soundlist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [tableView dequeueReusableCellWithIdentifier:@"MUSIC_CELL" forIndexPath:indexPath];
    if(cell.accessoryType== UITableViewCellAccessoryCheckmark){
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    AlbumList *albumlist = [soundlist objectAtIndex:indexPath.row];
    [cell setProductInfo:albumlist indexPath:indexPath.row];
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
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
