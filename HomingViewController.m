//
//  HomingViewController.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 1. 23..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "HomingViewController.h"
#import "PlayListViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "AFHTTPRequestOperationManager.h"
#import "PlaylistCatagory.h"
#define IMAGE_NUM 3

@interface HomingViewController ()<UIScrollViewDelegate>
{
    int loadedPageCount;
    UIScrollView *_scrollView;
    UIPageControl *pageControl;
    NSTimer *timer;
}
@property (strong, nonatomic) IBOutlet UIBarButtonItem *toggleButton;
@property (strong, nonatomic) UIProgressView *progressBar;


@end

@implementation HomingViewController{
    PlayListViewController *playerVC;
    PlaylistCatagory *playCatagory;
}

-(IBAction)toggleButton:(id)sender{
 
    
    
    if(playCatagory.player.playing == YES){
        [timer invalidate];
        timer = nil;
        NSMutableArray *items = [self.toolbarItems mutableCopy];
        [items removeObjectAtIndex:1];
        [items insertObject:self.toggleButton atIndex:1];
        [self.navigationController.toolbar setItems:items animated:NO];
        [playCatagory stop];
        NSLog(@"555");
    }
    else if(playCatagory.player.playing==NO){
        timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateProgress:) userInfo:nil repeats:YES];

        NSMutableArray *items = [self.toolbarItems mutableCopy];
        UIBarButtonItem *pauseButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"cart.jpeg"] style:UIBarButtonItemStyleDone target:self action:@selector(toggleButton:)];
        [items removeObjectAtIndex:1];
        [items insertObject:pauseButton atIndex:1];
        [self.navigationController.toolbar setItems:items animated:NO];
        [playCatagory playStart];
       //json
        
    }
}

-(void)updateProgress:(NSTimer *)timer{
    self.progressBar.progress = playCatagory.player.currentTime / playCatagory.player.duration;
}





///////////////////////////////////

-(void)loadContentsPage:(int)pageNo{
    if(pageNo <0|| pageNo <loadedPageCount || pageNo >= IMAGE_NUM)
        return;
    
    if(pageNo == 0){
        float width = _scrollView.frame.size.width;
        float height = _scrollView.frame.size.height;
        
//        NSString *fileName = [NSString stringWithFormat:@"ball%d", pageNo];
//        NSString *filePath = [[NSBundle mainBundle]pathForResource:fileName ofType:@"png"];
//        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.frame = CGRectMake(width * pageNo, 0, width, height);
        [_scrollView addSubview:imageView];

        
         
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
    }
    loadedPageCount++;
     
    
    /*
    if(pageNo <0|| pageNo <loadedPageCount || pageNo >= IMAGE_NUM)
        return;
    
    float width = _scrollView.frame.size.width;
    float height = _scrollView.frame.size.height;
    
    NSString *fileName = [NSString stringWithFormat:@"ball%d", pageNo];
    NSString *filePath = [[NSBundle mainBundle]pathForResource:fileName ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.frame = CGRectMake(width * pageNo, 0, width, height);
    [_scrollView addSubview:imageView];
    loadedPageCount++;
     */
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

//-(void)AFNetworking{
//    NSNumber *k = [NSNumber numberWithInt:1];
//    NSNumber *j = [NSNumber numberWithInt:15];
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    NSDictionary *parameters = @{@"user_id": k,
//                                 @"album_id":j};
//    [manager POST:@"http://mixhips.nowanser.cloulu.com/request_album" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
//}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

       playCatagory = [[PlaylistCatagory defaultCatalog]init];
    self.progressBar = [[UIProgressView alloc] initWithFrame:CGRectMake(93, 25, 200, 2)];
    [self.navigationController.toolbar addSubview:self.progressBar];

    
    
    //float width = _scrollView.frame.size.width;
    float heigth = _scrollView.bounds.size.height;
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, 320, 160)];
    [self.view addSubview:_scrollView];
    
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(320 * IMAGE_NUM, heigth);
    _scrollView.backgroundColor = [UIColor clearColor];
    
    pageControl.frame = CGRectMake(160, 52, 39, 37);
    pageControl.numberOfPages = IMAGE_NUM;
    
    [_scrollView addSubview:pageControl];
    loadedPageCount =0;
    
    [self loadContentsPage:0];
    [self loadContentsPage:1];
    
   // [self AFNetworking];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
    //[self.navigationController setToolbarHidden:NO];
//    playCatagory = [[PlaylistCatagory defaultCatalog]init];
    if(playCatagory.player.playing==NO){
        NSMutableArray *items = [self.toolbarItems mutableCopy];

        [items removeObjectAtIndex:1];
        [items insertObject:self.toggleButton atIndex:1];
        [self.navigationController.toolbar setItems:items animated:NO];
        NSLog(@"aa");
    }
    else if(playCatagory.player.playing==YES){
        NSMutableArray *items = [self.toolbarItems mutableCopy];
        [items removeObjectAtIndex:1];
        UIBarButtonItem *pauseButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"cart.jpeg"] style:UIBarButtonItemStyleDone target:self action:@selector(toggleButton:)];
        [items insertObject:pauseButton atIndex:1];
        [self.navigationController.toolbar setItems:items animated:NO];
        NSLog(@"bb");
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



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
