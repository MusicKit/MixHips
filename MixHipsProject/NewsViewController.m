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
#import "PlayListViewController.h"


@interface NewsViewController ()<UIAlertViewDelegate , UITableViewDataSource, UITableViewDelegate, playDelegate3>
@property (strong, nonatomic) UIButton *testButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *renetButton;
@property (weak, nonatomic) IBOutlet UIView *netView;
@property (strong, nonatomic) UIProgressView *progressBar;
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation NewsViewController{
    Newslist *newlist;
    NetWorkingCenter *net;
    PlaylistCatagory *playCatagory;
    NSString *userName1;
    NSString *soundName1;
    NSString *soundid11;
    UIActivityIndicatorView *indicator;
    BOOL ch;
}
-(IBAction)listJoin:(id)sender{
    PlayListViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"playlist"];
    [self.navigationController pushViewController:nextVC animated:YES];
}


-(void)toggleButton:(id)sender{
    if(ch == YES){
        [playCatagory playStart:soundid11];
        [self.testButton setImage:[UIImage imageNamed:@"stop.png"] forState:UIControlStateNormal];
    }
    else{
        if(playCatagory.player.rate == 1.0){
            [playCatagory.player pause];
            [self.testButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        }
        else{
            [playCatagory.player play];
            [self.testButton setImage:[UIImage imageNamed:@"stop.png"] forState:UIControlStateNormal];
        }
        
    }

}

-(void)notiPlay{
    ch = NO;
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

-(void)updateProgressViewWithPlayer:(NSString *)string time:(float)time{
    self.progressBar.progress = time;
    self.progressBar.progress = [[PlaylistCatagory defaultCatalog] getTime];
    if(playCatagory.player.rate == 1.0){
        [self.testButton setImage:[UIImage imageNamed:@"stop.png"] forState:UIControlStateNormal];
    }
    else{
        [self.testButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    }
}

-(void)setUser:(NSString *)userNamef setSound:(NSString *)soundNamef{
    soundName1 = soundNamef;
    userName1 = userNamef;
    if(soundName1 == NULL){
        
    }
    else{
        [self.titleLabel setText:[NSString stringWithFormat:@"%@ - %@",soundName1, userName1]];
    }
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) loadData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *userName11 = [defaults objectForKey:@"userName"];
    NSString *soundName11 = [defaults objectForKey:@"soundName"];
    soundid11 = [defaults objectForKey:@"soundId"];
    [self.titleLabel setText:[NSString stringWithFormat:@"%@ - %@",soundName11, userName11]];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
     playCatagory.delegate3 = self;
    [self.tableView reloadData];
    playCatagory = [PlaylistCatagory defaultCatalog];
    self.progressBar.progress = [[PlaylistCatagory defaultCatalog] getTime];
    
    if(playCatagory.player.rate == 1.0){
        [self.testButton setImage:[UIImage imageNamed:@"stop.png"] forState:UIControlStateNormal];
    }
    else{
        [self.testButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    }
    

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ch = YES;
	// Do any additional setup after loading the view.
    [[NewsCatalog defaultCatalog] selectDelegate:self];
    newlist = [NewsCatalog defaultCatalog];
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(92 , 7, 200, 20)];
    [self.titleLabel setFont:[UIFont fontWithName:@"system - system" size:10]];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setTextColor:[UIColor blackColor]];
    [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [self.navigationController.toolbar addSubview:self.titleLabel];
    [self loadData];
    
	// Do any additional setup after loading the view.
    
    //프로그래스
    self.progressBar = [[UIProgressView alloc] initWithFrame:CGRectMake(93, 30, 200, 4)];
     [self.progressBar setTintColor:[UIColor blackColor]];
    [self.navigationController.toolbar addSubview:self.progressBar];
    
    //재생버튼
    self.testButton = [[UIButton alloc]initWithFrame:CGRectMake( 50,2,40 ,40)];
    [self.testButton addTarget:self action:@selector(toggleButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.testButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    [self.navigationController.toolbar addSubview:self.testButton];
    
    //indicator
    indicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(135, 215, 50, 50)];
    indicator.hidesWhenStopped = YES;
    [self.view addSubview:indicator];
    
    
    playCatagory = [PlaylistCatagory defaultCatalog];
   

    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
//    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
