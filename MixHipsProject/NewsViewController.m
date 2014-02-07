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

@interface NewsViewController ()<UIAlertViewDelegate , UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *searchButton;
@property (weak, nonatomic) IBOutlet UIView *hideView;

@end

@implementation NewsViewController{
    Newslist *newlist;
    NetWorkingCenter *net;
}


-(IBAction)searchNews:(id)sender{
    float height = self.searchView.frame.size.height;
    
    self.tableView.center = CGPointMake(self.tableView.center.x, self.tableView.center.y + height);
    [self.searchView becomeFirstResponder];
    self.hideView.hidden= NO;
    self.searchButton.enabled = NO;
    self.searchView.hidden = NO;
}

-(IBAction)closeSearchbar:(id)sender{
    float height = self.searchView.frame.size.height;
    
    self.tableView.center = CGPointMake(self.tableView.center.x, self.tableView.center.y - height);
    [self.searchView resignFirstResponder];
    self.hideView.hidden = YES;
    self.searchButton.enabled =YES;
    self.searchView.hidden = YES;
}
//- (void)test:(NSDictionary *)dic {
//    NSDictionary *dd = [NSDictionary dictionaryWithDictionary:dic];
//    NSLog(@"%@",dd);
//    NSArray *abc = [dd objectForKey:@"ad_list"];
//    for(int i=0;i<abc.count;i++)
//    {
//        NSLog(@"ad_id=%@",[abc[i] objectForKey:@"ad_id"]);
//    }
//
//
//    
//}
//-(void)AFNetworkingAD:(NSInteger)num{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    NSDictionary *parameters = @{@"foo":@"bar"};
//    [manager POST: @"http://mixhips.nowanser.cloulu.com/request_ad_list" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//      [self test:responseObject];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"count: %d", [[NewsCatalog defaultCatalog] numberOfNews]);
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
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [[NewsCatalog defaultCatalog] selectDelegate:self];
    newlist = [NewsCatalog defaultCatalog];
    
    self.hideView.hidden = YES;
    self.searchView.hidden = YES;
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
//    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
