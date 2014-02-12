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

@interface PlayListViewController () <UITableViewDataSource, UITableViewDelegate, AVAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end



@implementation PlayListViewController{
    PlayerViewController *player;
    PlayListDB *_playlist;
}
//
-(NSString *)returnIndexRow:(NSInteger)indexRow{
    NSString *soundID = [_playlist getSoundIdAtIndex:indexRow];
    NSLog(@"soundid L : %@",soundID);
    return soundID;
}
//
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    PlayerViewController *dest = (PlayerViewController *)segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_playlist fetchMovies];
    ///////////
    [player returnIndexPath:indexPath.row];
    NSString *soundID = [_playlist getSoundIdAtIndex:indexPath.row];
    
    dest.soundID = soundID;
    
    NSLog(@"soundid: %@",soundID);
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    
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

-(void)viewWillAppear:(BOOL)animated{
    [_playlist fetchMovies];
}

@end
