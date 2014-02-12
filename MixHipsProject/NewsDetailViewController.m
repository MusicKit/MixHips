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
@interface NewsDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *contentsTextView;
@property (weak, nonatomic) IBOutlet UIImageView *urlImg;

@end

@implementation NewsDetailViewController{
    NSMutableArray *abc;
    NSString *adMenu;
    NSString *adTitle;
    NSString *adContents;
    NSString *adURL;
    
}

- (void)test:(NSDictionary *)dic {
    NSDictionary *dd = [NSDictionary dictionaryWithDictionary:dic];
    abc = [[NSMutableArray alloc]init];
    [abc  addObject:[dd objectForKey:@"ad_detail"]];
    NSLog(@"fffffff%@",abc[0]);
    
    adMenu = [NSString stringWithFormat:@"%@",[abc[0] objectForKey:@"ad_menu"]];
    NSLog(@"%@",adMenu);
    adContents = [NSString stringWithFormat:@"%@",[abc[0] objectForKey:@"ad_contents"]];
    NSLog(@"%@",adContents);
    adTitle = [NSString stringWithFormat:@"%@",[abc[0] objectForKey:@"ad_title"]];
    adURL = [NSString stringWithFormat:@"%@",[abc[0] objectForKey:@"ad_url"]];

}

-(void)AFNetworkingAD{
    NSString *i = [NSString stringWithFormat:@"%@",self.newsList.ad_id];
    NSLog(@"id: %@",self.newsList.ad_id);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"foo":@"bar", @"ad_id":i};
    [manager POST: @"http://mixhips.nowanser.cloulu.com/request_ad_detail" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"JSON: %@", responseObject);
        [self test:responseObject];
        [self setDetail];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(void)setDetail{
   self.contentsTextView.text = adContents;
    self.title = adTitle;
    
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

-(void)viewWillAppear:(BOOL)animated{
    [self AFNetworkingAD];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
