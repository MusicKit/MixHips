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
#import "PlaylistCatagory.h"
#import "MypageCatagory.h"
#import "Player.h"
#import "PlayerViewController.h"

@interface MyAlbumViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *albumNameLable;
@property (weak, nonatomic) IBOutlet UIImageView *albumImg;
@property (weak, nonatomic) IBOutlet UIButton *allSelectButton;
@property (strong, nonatomic) UIProgressView *progressBar;

@end

@implementation MyAlbumViewController{
    NSString *soundID;
    NSString *albumName;
    NSString *albumImgURL;
    NSString *userName;
    NSMutableArray *soundIDArr;
    NSMutableArray *soundNameArr;
    NSMutableArray *soundURLArr;
    NSMutableArray *soundlist;
    PlayListDB *playlist;
    MyAlbumCell *cell;
    PlaylistCatagory *playCatagory;
    MypageCatagory *myCatagory;
    Player *playerCatagory;
    NSArray *listTrack;
}

-(IBAction)toggleButton:(id)sender{
    if(playCatagory.player.rate == 1.0){
        [playCatagory pause];
    }
    else{
        [playCatagory.player play];
    }
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
    if(self.allSelectButton.tag == 0){
    for (NSInteger r = 0; r < [self.tableView numberOfRowsInSection:0]; r++) {
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:r inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        self.allSelectButton.tag = 1;
    }
    }
    else if(self.allSelectButton.tag == 1){
    for (NSInteger r = 0; r < [self.tableView numberOfRowsInSection:0]; r++) {
        [self.tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:r inSection:0] animated:NO];
        self.allSelectButton.tag =0;
    }
    }
}

-(IBAction)selectMusicPlay:(id)sender{
    PlayListViewController *dest = [[PlayListViewController alloc]init];
    Player *playerlist =[Player defaultCatalog];
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSArray *indexPathArr = [self.tableView indexPathsForSelectedRows];
    if(indexPathArr.count >0){
        for(indexPath in indexPathArr){
            AlbumList *albumlist = [[Catalog defaultCatalog] musicAt:indexPath.row];
            playlist = [PlayListDB sharedPlaylist];
            [playlist addMovieWithName:soundNameArr[indexPath.row] nickName:userName song_id:soundIDArr[indexPath.row] album_img:albumImgURL];
            [playlist fetchMovies];
            [playerlist setAlbumImg:albumImgURL];
            [playerlist setSoundId:soundID];
            dest.albumList = albumlist;
            playerlist.indexPathRow = playlist.data.count;
        }
        
        listTrack =  [playlist data];
        
        playerlist.indexPathRow =  playerlist.indexPathRow - indexPathArr.count;
        soundID = [NSString stringWithFormat:@"%@",listTrack[playerlist.indexPathRow]];
        
        [playCatagory playStart:soundID];
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        //고치자    [self.navigationController pushViewController:dest animated:NO];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"MixHips" message:@"한곡이상 선택해주세요" delegate:self cancelButtonTitle:nil otherButtonTitles:@"확인", nil];
        alert.alertViewStyle = UIAlertViewStyleDefault;
        [alert show];
    }
    PlayerViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"playerPart"];
    [self.navigationController pushViewController:nextVC animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


//-(IBAction)selectMusicPlay:(id)sender{
//    PlayListViewController *dest = [[PlayListViewController alloc]init];
//    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//    NSArray *indexPathArr = [self.tableView indexPathsForSelectedRows];
//    for(indexPath in indexPathArr){
//        AlbumList *albumlist = [[Catalog defaultCatalog] musicAt:indexPath.row];
//        playlist = [PlayListDB sharedPlaylist];
//        [playlist addMovieWithName:soundNameArr[indexPath.row] nickName:userName song_id:soundIDArr[indexPath.row]];
//        [playlist fetchMovies];
//        dest.albumList = albumlist;
//    }
//    [[Player defaultCatalog] setAlbumImg:albumImgURL];
//    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
//    //[self.navigationController popToRootViewControllerAnimated:YES];
//}

- (void)test:(NSDictionary *)dic {
    NSLog(@"dic : %@", dic);
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
        NSLog(@"JSON: %@", responseObject);
        [self test:responseObject];
        [self setProfile];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(void)setProfile{
    self.albumNameLable.text = albumName;
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
    cell.soundid = [soundIDArr objectAtIndex:indexPath.row];
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
    self.album_ID = [[MypageCatagory defaultCatalog] getalbumID];
    [self AFNetworkingAD];
    playCatagory = [PlaylistCatagory defaultCatalog];
    self.allSelectButton.tag =0;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.progressBar = [[UIProgressView alloc] initWithFrame:CGRectMake(93, 25, 200, 2)];
    [self.navigationController.toolbar addSubview:self.progressBar];
	// Do any additional setup after loading the view.
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
