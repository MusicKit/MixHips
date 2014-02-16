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
@end



@implementation PlayListViewController{
    PlayerViewController *player;
    PlayListDB *_playlist;
    PlaylistCatagory *play;
}

-(void)returnIndexPath{
    
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
    Player *playerCata = [Player defaultCatalog];
    playerCata.indexPathRow = indexPath.row;
    NSString *soundID = [_playlist getSoundIdAtIndex:indexPath.row];
    NSLog(@"play soundID : %@",soundID);
    [play playStart:soundID];
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
    PlaylistCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PLAYLIST_CELL" forIndexPath:indexPath];
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

-(void)viewWillAppear:(BOOL)animated
{
//    self.navigationController.toolbarHidden = YES;
    [_playlist fetchMovies];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    play = [[PlaylistCatagory defaultCatalog]init];
    _playlist = [PlayListDB sharedPlaylist];
    [_playlist fetchMovies];
    [self.navigationController setNavigationBarHidden:NO];
    
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
