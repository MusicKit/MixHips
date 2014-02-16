//
//  ListViewController.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 1. 16..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ListViewController.h"
#import "RequestCenter.h"
#import "AlbumList.h"
#import "ListViewCell.h"
#import "AFHTTPRequestOperationManager.h"
#import "AlbumMusicViewController.h"
#import "PlaylistCatagory.h"
#define kCellID @"IMG_CELL_ID"

@interface ListViewController ()< UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIControl *hideView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *searchButton;
@property (strong, nonatomic) UIProgressView *progressBar;

@property (strong, nonatomic) NSMutableArray* dataList;

@end

@implementation ListViewController{
    PlaylistCatagory *playCatagory;
    NSString *collectIndex;
    NSMutableArray *albumID;
    NSMutableArray *albumImg;
    NSMutableArray *albumName;
    NSMutableArray *userName;
    NSMutableArray *like_count;
    NSMutableArray *albumlistCU;
    NSArray *albumlist;
    NSString *lastData;
    int index;
}

-(IBAction)toggleButton:(id)sender{
    if(playCatagory.player.rate == 1.0){
        [playCatagory pause];
    }
    else{
        [playCatagory.player play];
    }
}

//앨범 검색 버튼 눌렀을때
-(IBAction)searchAlbum:(id)sender{
    float height = self.searchView.frame.size.height;
    self.collectionView.center = CGPointMake(self.collectionView.center.x, self.collectionView.center.y + height);
    [self.searchView becomeFirstResponder];
    self.hideView.hidden = NO;
    self.searchView.hidden = NO;
    self.searchButton.enabled = NO;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self AFNetworkingSearchList:[NSString stringWithFormat:@"1"] searchText:self.searchView.text];
    float height = self.searchView.frame.size.height;
    self.collectionView.center = CGPointMake(self.collectionView.center.x, self.collectionView.center.y - height);
    [self.searchView resignFirstResponder];
    [self.collectionView reloadData];
    
    self.hideView.hidden = YES;
    self.searchView.hidden = YES;
    self.searchButton.enabled = YES;
    
}
//여백 눌렀을때 키보드 사라짐
-(IBAction)dismissKeyboard:(id)sender{
    float height = self.searchView.frame.size.height;
    self.collectionView.center = CGPointMake(self.collectionView.center.x, self.collectionView.center.y - height);

    [self.searchView resignFirstResponder];
    self.hideView.hidden = YES;
    self.searchView.hidden = YES;
    self.searchButton.enabled = YES;
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:[NSString stringWithFormat:@"albumjoin"]]){
        AlbumMusicViewController *dest = (AlbumMusicViewController *)segue.destinationViewController;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
        dest.album_ID = albumID[indexPath.row];
        dest.user_Name = userName[indexPath.row];
        //AlbumList *list = [[listCatalog defaultCatalog] albumAt:indexPath.row];
        //dest.list = list;
    }
    
}

//network search album
- (void)search:(NSDictionary *)dic {
    NSDictionary *dd = [NSDictionary dictionaryWithDictionary:dic];
    albumlist = [dd objectForKey:@"album_list"];
    ////////////////////
    NSLog(@"%@",albumlist);
    albumID = [[NSMutableArray alloc]init];
    albumImg = [[NSMutableArray alloc]init];
    albumName = [[NSMutableArray alloc]init];
    userName = [[NSMutableArray alloc ]init];
    like_count = [[NSMutableArray alloc]init];
    albumlistCU = [[NSMutableArray alloc]init];
    for(int i=0;i<albumlist.count;i++)
    {
        [albumID addObject:[albumlist[i] objectForKey:@"album_id"]];
        [albumImg addObject:[albumlist[i] objectForKey:@"album_img_url"]];
        [albumName addObject:[albumlist[i] objectForKey:@"album_name"]];
        [like_count addObject:[albumlist[i] objectForKey:@"like_count"]];
        [userName addObject:[albumlist[i] objectForKey:@"user_name"]];
        
        [albumlistCU addObject:[AlbumList Albumlist:albumID[i] album_img:albumImg[i] album_name:albumName[i] like:like_count[i] user_name:userName[i]]];
        
    }
    NSLog(@"dfdf%d",albumlistCU.count);
    [self.collectionView reloadData];
    
}
-(void)AFNetworkingSearchList:(NSString *)indexf searchText:(NSString *)searchText{
    NSString *i = [NSString stringWithFormat:@"%@",indexf];
    NSString *d = searchText;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"foo":@"bar", @"page_index":i , @"name":d};
    [manager POST: @"http://mixhips.nowanser.cloulu.com/search_album" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"JSON: %@", responseObject);
        [self search:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


//network album list
- (void)test:(NSDictionary *)dic {
    NSDictionary *dd = [NSDictionary dictionaryWithDictionary:dic];
    albumlist = [dd objectForKey:@"album_list"];
    ////////////////////
    NSLog(@"%d",albumlist.count);
    albumID = [[NSMutableArray alloc]init];
    albumImg = [[NSMutableArray alloc]init];
    albumName = [[NSMutableArray alloc]init];
    userName = [[NSMutableArray alloc ]init];
    like_count = [[NSMutableArray alloc]init];
    lastData = [NSString stringWithFormat:@"%@",albumlist[(albumlist.count-1)]];
    
    for(int i=0;i<albumlist.count;i++)
    {
        [albumID addObject:[albumlist[i] objectForKey:@"album_id"]];
        [albumImg addObject:[albumlist[i] objectForKey:@"album_img_url"]];
        [albumName addObject:[albumlist[i] objectForKey:@"album_name"]];
        [like_count addObject:[albumlist[i] objectForKey:@"like_count"]];
        [userName addObject:[albumlist[i] objectForKey:@"user_name"]];
        
        [albumlistCU addObject:[AlbumList Albumlist:albumID[i] album_img:albumImg[i] album_name:albumName[i] like:like_count[i] user_name:userName[i]]];
        
    }
    NSLog(@"dfdf%d",albumlistCU.count);
    [self.collectionView reloadData];
    
}
-(void)AFNetworkingAD:(NSString *)indexff{
    NSLog(@"index : %@",indexff);
    NSString *i = [NSString stringWithFormat:@"%@",indexff];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"foo":@"bar", @"page_index":i};
    [manager POST: @"http://mixhips.nowanser.cloulu.com/request_album_list" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"JSON: %@", responseObject);
        [self test:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


////////////////////////////////////////

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = self.collectionView.contentOffset;
    CGRect bounds = self.collectionView.bounds;
    CGSize size = self.collectionView.contentSize;
    UIEdgeInsets inset = self.collectionView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    
    float reload_distance = 15;
    //마지막에 널값이 나오면... 이제 더이상 로드를 안한다...

    if(y > h + reload_distance)
    {
        if(albumlist.count < 15*index){
            NSLog(@"메롱");
             }
        else{
        index++;
        NSString *indexSt = [NSString stringWithFormat:@"%d",index];
        [self AFNetworkingAD:indexSt];
        }
       
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"%d", (int)albumlistCU.count);
	return albumlistCU.count;
}


- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	// 재사용 큐에 셀을 가져온다
	ListViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    NSIndexPath *iP = [[self.collectionView indexPathsForVisibleItems] lastObject];
    if (iP.section == indexPath.section && iP.row == indexPath.row) {
       // self.flashScrollIndicators = NO;
        [self.collectionView flashScrollIndicators];
    }
    self.list = [albumlistCU objectAtIndex:indexPath.row];
    [cell setPlaylistInfo:self.list];
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
    self.progressBar = [[UIProgressView alloc] initWithFrame:CGRectMake(93, 25, 200, 2)];
    [self.navigationController.toolbar addSubview:self.progressBar];
 
	
	//[self updateData];
    [self.collectionView reloadData];
    self.hideView.hidden = YES;
    

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    index = 1;
    albumlistCU = [[NSMutableArray alloc]init];
    albumlist = [[NSArray alloc]init];
    collectIndex = [NSString stringWithFormat:@"%d",index];
    [self AFNetworkingAD:collectIndex];
    playCatagory = [PlaylistCatagory defaultCatalog];
    self.searchView.hidden = YES;
//    [self.navigationController setToolbarHidden:NO];
    [self.navigationController setToolbarHidden:NO animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
