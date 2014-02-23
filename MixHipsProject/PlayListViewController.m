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
#import "cacheList.h"


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
    cacheList *data;
    NSInteger indexRow;
    NSString *img;
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

//-(void)reloadTable{
//    [self.tableView reloadData];
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(play.player.rate ==1 ){
        if(indexPath.row == playerCata.indexPathRow){
            PlayerViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"playerPart"];
             [playerCata setAlbumImg:[_playlist getalbumImgAtIndex:indexPath.row]];
            [self.navigationController presentViewController:nextVC animated:YES completion:nil];
           // [self.navigationController pushViewController:nextVC animated:YES];
        }
        else{
            
            [playerCata setAlbumImg:[_playlist getalbumImgAtIndex:indexPath.row]];
            playerCata.indexPathRow = indexPath.row;
            indexRow = indexPath.row;
            NSString *soundID = [_playlist getSoundIdAtIndex:indexPath.row];
            NSLog(@"play soundID : %@",soundID);
            PlayerViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"playerPart"];
            [self.navigationController presentViewController:nextVC animated:YES completion:nil];
//            [self.navigationController pushViewController:nextVC animated:YES];
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
        [self.navigationController presentViewController:nextVC animated:YES completion:nil];
//        [self.navigationController pushViewController:nextVC animated:YES];
        [play playStart:soundID];
    }
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(UITableViewCellEditingStyleDelete == editingStyle){
        [_playlist deleteMusic:indexPath.row];
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
//        NSString *ddd = [_playlist getSoundIdAtIndex:indexPath.row];
        NSString *name = [_playlist getNameOfMovieAtIndex:indexPath.row];
        NSString *nickName = [_playlist getNickNameOfMusicAtIndex:indexPath.row];
    if(indexPath.row == playerCata.indexPathRow){
        img = [NSString stringWithFormat:@"gold.png"];
        [cell setPlaylistInfo:name nickName:nickName img:img];
    }
    else{
        NSString *ff = [NSString stringWithFormat:@"gray.png"];
        [cell setPlaylistInfo:name nickName:nickName img:ff];
    }
    
    
    return cell;
}

//- (void) loadData
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//    
//    NSMutableArray *fishList = [defaults objectForKey:@"fishList"];
//    if ( fishList ) {
//         [fishList removeAllObjects];
//        for( NSDictionary *dict in fishList ) {
//            data.index = [dict objectForKey:@"fish.index"];
//        }
//        NSLog(@"%@",data.index);
//        NSInteger ff = data.index;
//    }
//}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dismissVC{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDidDisappear:(BOOL)animated{

}

-(void)viewWillAppear:(BOOL)animated
{
    [_playlist fetchMovies];
    [self.tableView reloadData];
//    self.navigationController.toolbarHidden = YES;
    
    
    play = [PlaylistCatagory defaultCatalog];
    self.tabBarController.tabBar.hidden=NO;
    self.navigationController.toolbar.hidden = NO;
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(dismissVC)];
	// Do any additional setup after loading the view.

    
    //self.progressBar = [[UIProgressView alloc] initWithFrame:CGRectMake(93, 25, 200, 2)];
    //[self.navigationController.toolbar addSubview:self.progressBar];
    play = [PlaylistCatagory defaultCatalog];
    playerCata = [Player defaultCatalog];
    play.reloadDelegate = self;
    
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
