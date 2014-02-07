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

@interface MyAlbumViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MyAlbumViewController{
    PlayListDB *playlist;
    MyAlbumCell *cell;
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

-(IBAction)allSelect:(id)sender{
    
}
/*
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[Catalog defaultCatalog] numberOfMusic];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [tableView dequeueReusableCellWithIdentifier:@"MUSIC_CELL" forIndexPath:indexPath];
    if(cell.accessoryType== UITableViewCellAccessoryCheckmark){
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
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
