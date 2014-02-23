//
//  NewsDetailViewController.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 11..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIImageView+AFNetworking.h"
#import "PlaylistCatagory.h"
#import "PlayListViewController.h"
@interface NewsDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *contentsTextView;
@property (weak, nonatomic) IBOutlet UIView *netView;
@property (weak, nonatomic) IBOutlet UIButton *renetButton;

@property (weak, nonatomic) IBOutlet UIImageView *urlImg;
@property (strong,nonatomic) UIProgressView *progressBar;

@end

@implementation NewsDetailViewController{
    PlaylistCatagory *playCatagory;
    NSMutableArray *abc;
    NSString *adMenu;
    NSString *adTitle;
    NSString *adContents;
    NSString *adURL;
    UIActivityIndicatorView *indicator;
}

-(IBAction)listJoin:(id)sender{
    PlayListViewController *nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"playlist"];
    [self.navigationController pushViewController:nextVC animated:YES];
}

-(IBAction)restartNet:(id)sender{
    [self AFNetworkingAD];
    self.netView.hidden = YES;
}

-(IBAction)urlJoin:(id)sender{
    NSString *fff = [NSString stringWithFormat:@"http://%@",adURL];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: fff]
     ];
    NSLog(@"%@%@",@"Failed to open url:",[adURL description]);

    NSLog(@"%@",adURL);
}

- (void)test:(NSDictionary *)dic {
    NSDictionary *dd = [NSDictionary dictionaryWithDictionary:dic];
    NSLog(@"dfdf %@",dd);
    abc = [[NSMutableArray alloc]init];
    [abc  addObject:[dd objectForKey:@"ad_detail"]];
    NSLog(@"fffffff%@",abc);
    
    adMenu = [NSString stringWithFormat:@"%@",[abc[0] objectForKey:@"ad_menu"]];
    NSLog(@"%@",adMenu);
    adContents = [NSString stringWithFormat:@"%@",[abc[0] objectForKey:@"ad_contents"]];
    NSLog(@"%@",adContents);
    adTitle = [NSString stringWithFormat:@"%@",[abc[0] objectForKey:@"ad_title"]];
    adURL = [NSString stringWithFormat:@"%@",[abc[0] objectForKey:@"ad_url"]];
}

-(void)AFNetworkingAD{
    [indicator startAnimating];
    NSString *i = [NSString stringWithFormat:@"%@",self.newsList.ad_id];
    NSLog(@"id: %@",self.newsList.ad_id);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"foo":@"bar", @"ad_id":i};
    [manager POST: @"http://mixhips.nowanser.cloulu.com/request_ad_detail" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"JSON: %@", responseObject);
        [self test:responseObject];
        [indicator stopAnimating];
        [self setDetail];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [indicator stopAnimating];
        self.netView.hidden = NO;
    }];
}

-(void)setDetail{
   self.contentsTextView.text = adContents;
   // self.title = adTitle;
    
   NSString *url = @"http://mixhips.nowanser.cloulu.com/";
   url = [url stringByAppendingString:adURL];
    NSURL *ad_URL = [NSURL URLWithString:url];
   [self.urlImg setImageWithURL:ad_URL];
}

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

-(void)viewWillAppear:(BOOL)animated{

    [self AFNetworkingAD];
    playCatagory = [PlaylistCatagory defaultCatalog];


}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.netView.hidden = YES;
    CALayer * l = [self.netView layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:6.0];
    
    
    indicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(135, 200, 50, 50)];
    indicator.hidesWhenStopped = YES;
    [self.view addSubview:indicator];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(dismissVC)];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
