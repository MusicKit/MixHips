//
//  PlayListViewController.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 1. 27..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "PlayListViewController.h"
#import "PlayListDB.h"
#import "PlaylistCell.h"
#import "Playlist.h"
#import "PlayerViewController.h"
#import "Catalog.h"
#import "PlaylistCatagory.h"
#import "Player.h"


@interface PlayListViewController () <UITableViewDataSource, UITableViewDelegate, AVAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIProgressView *progressBar;
@end



@implementation PlayListViewController{
    PlaylistCell *cell;
    PlayerViewController *player;
    PlayListDB *_playlist;
    PlaylistCatagory *play;
    Player *playerCata;
    NSInteger indexRow;
}


//
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    player = (PlayerViewController *)segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    NSLog(@"sjflsjdlf %d",indexPath.row);
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_playlist fetchMovies];
    ///////////

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(play.player.rate ==1 ){
        if(indexPath.row == playerCata.indexPathRow){
            PlayerViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"playerPart"];
            [self.navigationController pushViewController:nextVC animated:YES];
        }
        else{
            
            [playerCata setAlbumImg:[_playlist getalbumImgAtIndex:indexPath.row]];
            playerCata.indexPathRow = indexPath.row;
            indexRow = indexPath.row;
            NSString *soundID = [_playlist getSoundIdAtIndex:indexPath.row];
            NSLog(@"play soundID : %@",soundID);
            PlayerViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"playerPart"];

            [self.navigationController pushViewController:nextVC animated:YES];
            [play playStart:soundID];
        }
    }
    else{
        [playerCata setAlbumImg:[_playlist getalbumImgAtIndex:indexPath.row]];
        playerCata.indexPathRow = indexPath.row;
        indexRow = indexPath.row;
        NSString *soundID = [_playlist getSoundIdAtIndex:indexPath.row];
        NSLog(@"play soundID : %@",soundID);
        PlayerViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"playerPart"];
        [self.navigationController pushViewController:nextVC animated:YES];
        [play playStart:soundID];
    }
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(UITableViewCellEditingStyleDelete == editingStyle){
        [_playlist deleteMusic:indexPath];
    }
    [_playlist fetchMovies];
    [self.tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_playlist getNumberOfMovies];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [tableView dequeueReusableCellWithIdentifier:@"PLAYLIST_CELL" forIndexPath:indexPath];
    NSString *ddd = [_playlist getSoundIdAtIndex:indexPath.row];
    NSLog(@"soundidekekek : %@",ddd);
    NSString *name = [_playlist getNameOfMovieAtIndex:indexPath.row];
    NSString *nickName = [_playlist getNickNameOfMusicAtIndex:indexPath.row];
    [cell setPlaylistInfo:name nickName:nickName];
    
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

-(void)viewDidDisappear:(BOOL)animated{

}

-(void)viewWillAppear:(BOOL)animated
{
//    self.navigationController.toolbarHidden = YES;
    [_playlist fetchMovies];
    playerCata = [Player defaultCatalog];
    play = [PlaylistCatagory defaultCatalog];
    self.tabBarController.tabBar.hidden=NO;
    self.navigationController.toolbar.hidden = NO;
    [self.navigationController setNavigationBarHidden:NO];
    if(play.player.rate ==1){
        if(indexRow == playerCata.indexPathRow){
            //??? 멀까...
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    
    //self.progressBar = [[UIProgressView alloc] initWithFrame:CGRectMake(93, 25, 200, 2)];
    //[self.navigationController.toolbar addSubview:self.progressBar];
    play = [PlaylistCatagory defaultCatalog];
    
    _playlist = [PlayListDB sharedPlaylist];
    [_playlist fetchMovies];

    
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
