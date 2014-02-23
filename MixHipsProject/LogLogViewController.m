//
//  LogLogViewController.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 1. 23..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "LogLogViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "HomeViewController.h"
#define IMAGE_NUM 3

@interface LogLogViewController () <UIScrollViewDelegate , FBLoginViewDelegate>
{
    UIScrollView *_scrollView;
    int loadedPageCount;
}
@property (weak, nonatomic) IBOutlet UIView *agreementView;
@property (weak, nonatomic) IBOutlet UIView *faceBookView;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImg;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@end

@implementation LogLogViewController

-(void)loadContentsPage:(int)pageNo{
    if(pageNo <0|| pageNo <loadedPageCount || pageNo >= IMAGE_NUM)
        return;
    
    if(pageNo == 0){
        FBLoginView *loginView = [[FBLoginView alloc] initWithReadPermissions:@[@"read_friendlists"]];
        
        // Align the button in the center horizontally
        loginView.frame = CGRectOffset(loginView.frame, (self.view.center.x - (loginView.frame.size.width / 2)), 5);
        loginView.center = CGPointMake(160, 300);
        loginView.delegate = self;
        
        [_scrollView addSubview:loginView];
    }
    else if(pageNo == 1){
        //개인동의서
        
        float width = _scrollView.frame.size.width;
        float height = _scrollView.frame.size.height;
        
        UIView *view = [[UIView alloc]init];
        view.frame = CGRectMake(width *pageNo, 0, width, height);
        [_scrollView addSubview:view];
        
    }
    else if(pageNo == 2){
        //별명 작성 버튼
        
        float width = _scrollView.frame.size.width;
        float height = _scrollView.frame.size.height;
        
        UIView *view = [[UIView alloc]init];
        view.frame = CGRectMake(width *pageNo, 0, width, height);
        [_scrollView addSubview:view];
        
        UIButton *button = [UIButton buttonWithType: UIButtonTypeRoundedRect];
        [button setTitle:@"이동" forState:UIControlStateNormal];
        button.frame = CGRectMake(145, 300, 30, 30);
        [view addSubview:button];
        
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    loadedPageCount++;
}

/*
-(void)loadView:(int)pageNo{
    if(pageNo == 0){
        self.backgroundImg.image = [UIImage imageNamed:@""]
    }
    
}
 */
-(void)click:(id)sender{
    [self performSegueWithIdentifier:@"log" sender:sender];
    /*
    UIStoryboard *storyboard = self.storyboard;
    HomeViewController *home = (HomeViewController *)[storyboard instantiateViewControllerWithIdentifier:@"home"];
    [self presentViewController:home animated:YES completion:nil];
     */
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    float width = scrollView.frame.size.width;
    float offsetX = scrollView.contentOffset.x;
    int pageNo = floor(offsetX / width);
    self.pageControl.currentPage = pageNo;
    
    [self loadContentsPage:pageNo-1];
    [self loadContentsPage:pageNo];
    [self loadContentsPage:pageNo+1];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_scrollView];
    float width = _scrollView.bounds.size.width;
    float heigth = _scrollView.bounds.size.height;
    
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(width * IMAGE_NUM, heigth);
    
    
    
   
    self.pageControl.numberOfPages = IMAGE_NUM;
    
    loadedPageCount =0;
    
    [self loadContentsPage:0];
    
    [self loadContentsPage:1];
}

-(void)viewDidLayoutSubviews{
    
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"top_bAR.png"] forBarMetrics:UIBarMetricsDefault];
    //[[UIToolbar appearance]setBackgroundImage:[UIImage imageNamed:@"background_2.png"] forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
    [[UITabBar appearance]setBackgroundImage:[UIImage imageNamed:@"top_bAR.png"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
