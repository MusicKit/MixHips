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

@interface AlbumMusicViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AlbumMusicViewController{
    PlayListDB *playlist;
}

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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[Catalog defaultCatalog] numberOfMusic];}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"music_CELL" forIndexPath:indexPath];
    AlbumList *albumlist = [[Catalog defaultCatalog] musicAt:indexPath.row];
    [cell setProductInfo:albumlist];
    
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
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
