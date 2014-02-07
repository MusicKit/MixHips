//
//  LoginViewController.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 1. 23..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#define IMAGE_NUM 3

@interface ViewController () <UIScrollViewDelegate , FBLoginViewDelegate>
{
    UIScrollView *_scrollView;
    UIPageControl *pageControl;
    int loadedPageCount;
}
@end

@implementation ViewController

-(void)loadContentsPage:(int)pageNo{
    if(pageNo <0|| pageNo <loadedPageCount || pageNo >= IMAGE_NUM)
        return;
    
    if(pageNo == 0){
        FBLoginView *loginView = [[FBLoginView alloc] initWithReadPermissions:@[@"read_friendlists"]];
        
        // Align the button in the center horizontally
        loginView.frame = CGRectOffset(loginView.frame, (self.view.center.x - (loginView.frame.size.width / 2)), 5);
        loginView.center = CGPointMake(160, 160);
        loginView.delegate = self;
        
        [_scrollView addSubview:loginView];
        
    }
    else if(pageNo == 1){
        float width = _scrollView.frame.size.width;
        float height = _scrollView.frame.size.height;
        
        NSString *fileName = [NSString stringWithFormat:@"ball1"];
        NSString *filePath = [[NSBundle mainBundle]pathForResource:fileName ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        imageView.frame = CGRectMake(width * pageNo, 0, width, height);
        [_scrollView addSubview:imageView];
        
    }
    else{
        UIButton *button = [UIButton buttonWithType: UIButtonTypeDetailDisclosure];
        button.center = CGPointMake(160, 160);
        [_scrollView addSubview:button];
        
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    /*
     float width = _scrollView.frame.size.width;
     float height = _scrollView.frame.size.height;
     
     NSString *fileName = [NSString stringWithFormat:@"ball%d", pageNo];
     NSString *filePath = [[NSBundle mainBundle]pathForResource:fileName ofType:@"png"];
     UIImage *image = [UIImage imageWithContentsOfFile:filePath];
     UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
     imageView.frame = CGRectMake(width * pageNo, 0, width, height);
     [_scrollView addSubview:imageView];
     */
    loadedPageCount++;
}

-(void)click:(id)sender{
    [self performSegueWithIdentifier:@"login" sender:self];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    float width = scrollView.frame.size.width;
    float offsetX = scrollView.contentOffset.x;
    int pageNo = floor(offsetX / width);
    pageControl.currentPage = pageNo;
    
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
    
    pageControl = [[UIPageControl alloc]initWithFrame: CGRectMake(130, 400   , 60, 40)];
    [self.view addSubview:pageControl];
    pageControl.numberOfPages = IMAGE_NUM;
    
    loadedPageCount =0;
    
    [self loadContentsPage:0];
    
    [self loadContentsPage:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
