//
//  FollowViewController.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 1. 28..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "FollowViewController.h"

@interface FollowViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIControl *hideView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *searchButton;
@property (weak, nonatomic) IBOutlet UISearchBar *searchView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation FollowViewController

//앨범 검색 버튼 눌렀을때
-(IBAction)searchAlbum:(id)sender{
    float height = self.searchView.frame.size.height;
    self.collectionView.center = CGPointMake(self.collectionView.center.x, self.collectionView.center.y + height);
    [self.searchView becomeFirstResponder];
    self.hideView.hidden = NO;
    self.searchView.hidden = NO;
    self.searchButton.enabled = NO;
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

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 15;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"follow_cell" forIndexPath:indexPath];
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
    self.hideView.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
