//
//  NewsViewController.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 1. 16..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "NewsViewController.h"
#import "NetWorkingCenter.h"
#import "AFHTTPRequestOperationManager.h"
#import "NewsCell.h"
#import "NewsCatalog.h"
#import "Newslist.h"
#import "NewsDetailViewController.h"
#import "PlaylistCatagory.h"

@interface NewsViewController ()<UIAlertViewDelegate , UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation NewsViewController{
    Newslist *newlist;
    NetWorkingCenter *net;
    PlaylistCatagory *playCatagory;
}

-(IBAction)toggleButton:(id)sender{
    if(playCatagory.player.rate == 1.0){
        [playCatagory pause];
    }
    else{
        [playCatagory.player play];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:[NSString stringWithFormat:@"newlist"]]) {
        NewsDetailViewController *dest = (NewsDetailViewController *)segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        Newslist *list = [[NewsCatalog defaultCatalog] newsAt:indexPath.row];
        dest.newsList = list;
        NSLog(@"djskfjldf : %@",dest.newsList);
    }
    if([segue.identifier isEqualToString:[NSString stringWithFormat:@"musiclist"]]){
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return [[NewsCatalog defaultCatalog] numberOfNews];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NEWS_CELL"];
    newlist = [[NewsCatalog defaultCatalog] newsAt:indexPath.row];
    NSLog(@"%@",newlist);
    [cell setProductInfo:newlist];
    return cell;
}

-(void)reloadTable {
    [self.tableView reloadData];
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
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    playCatagory = [PlaylistCatagory defaultCatalog];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [[NewsCatalog defaultCatalog] selectDelegate:self];
    newlist = [NewsCatalog defaultCatalog];

    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
//    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
