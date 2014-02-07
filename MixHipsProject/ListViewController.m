//
//  ListViewController.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 1. 16..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ListViewController.h"
#define kCellID @"IMG_CELL_ID"

@interface ListViewController ()< UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *registrationView;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIButton *registrationButton;
@property (weak, nonatomic) IBOutlet UIControl *hideView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *searchButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *registButton;
@property (strong, nonatomic) UIProgressView *progressBar;

@property (strong, nonatomic) NSMutableArray* dataList;

@end

@implementation ListViewController

//앨범 검색 버튼 눌렀을때
-(IBAction)searchAlbum:(id)sender{
    float height = self.searchView.frame.size.height;
    self.collectionView.center = CGPointMake(self.collectionView.center.x, self.collectionView.center.y + height);
    [self.searchView becomeFirstResponder];
    self.hideView.hidden = NO;
    self.searchView.hidden = NO;
    self.searchButton.enabled = NO;
    self.registButton.enabled = NO;
}
//여백 눌렀을때 키보드 사라짐
-(IBAction)dismissKeyboard:(id)sender{
    float height = self.searchView.frame.size.height;
    self.collectionView.center = CGPointMake(self.collectionView.center.x, self.collectionView.center.y - height);

    [self.searchView resignFirstResponder];
    self.hideView.hidden = YES;
    self.searchView.hidden = YES;
    self.searchButton.enabled = YES;
    self.registButton.enabled = YES;
}
//등록 버튼을 눌렀을 때
-(IBAction)registrationButton:(id)sender{
    self.registrationView.hidden = NO;
    self.searchButton.enabled = NO;
}

-(IBAction)closeAction:(id)sender{
    self.registrationView.hidden = YES;
    self.searchButton.enabled = YES;
}





////////////////////////////////////////

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"albumjoin" sender:indexPath];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return 14;
}


- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	// 재사용 큐에 셀을 가져온다
	UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
	/*
	// 선택 상태에 따른 셀UI 업데이트
	// "#3. 셀에 대해 더 깊이 파고들어가보자" 글에 있는 약간의 수정 부분에 대한 해결방법. 아래의 두줄이 있을때와 없을때를 비교해보세요.
	cell.layer.borderColor = (cell.selected) ? [UIColor yellowColor].CGColor : nil;
	cell.layer.borderWidth = (cell.selected) ? 5.0f : 0.0f;
	
	// 표시할 이미지 설정
	UIImageView* imgView = (UIImageView*)[cell.contentView viewWithTag:100];
	if (imgView) imgView.image = self.dataList[indexPath.section][indexPath.row];
	*/
	return cell;
}


- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    /*
     // 요청된 Supplementary View가 헤더인지 확인
     if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
     
     // 재사용 큐에서 뷰를 가져온다
     UICollectionReusableView* view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSupplementaryViewID forIndexPath:indexPath];
     
     NSArray* titles = [[NSArray alloc] initWithObjects:@"Girls", @"Cars", @"Movies", nil];
     
     UILabel* lbl = (UILabel*)[view viewWithTag:100];
     if (lbl) lbl.text = titles[indexPath.section];
     
     return view;
     }
     */
	
	return nil;
}

////////////////////////////////////////////////

/*
 - (void)updateData
 {
 [self.dataList removeAllObjects];
 
 // girl
 NSMutableArray* girlList = [[NSMutableArray alloc] init];
 for (int i = 0; i <= 11; i++) {
 NSString* imgName = [[NSString alloc] initWithFormat:@"girl%02i.jpeg", i];
 UIImage* girlImg = [UIImage imageNamed:imgName];
 [girlList addObject:girlImg];
 }
 [self.dataList addObject:girlList];
 
 // car
 NSMutableArray* carList = [[NSMutableArray alloc] init];
 for (int i = 0; i <= 24; i++) {
 NSString* imgName = [[NSString alloc] initWithFormat:@"car%02i.jpg", i];
 UIImage* carImg = [UIImage imageNamed:imgName];
 [carList addObject:carImg];
 }
 [self.dataList addObject:carList];
 
 // Poster
 NSMutableArray* posterList = [[NSMutableArray alloc] init];
 for (int i = 0; i <= 11; i++) {
 NSString* imgName = [[NSString alloc] initWithFormat:@"poster%02i.jpeg", i];
 UIImage* posterImg = [UIImage imageNamed:imgName];
 [posterList addObject:posterImg];
 }
 [self.dataList addObject:posterList];
 
 [self.collectionView reloadData];
 }
 */

/////////////////////////////////////////////////////////



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
 
    
    UINib* nib = [UINib nibWithNibName:@"Cell" bundle:nil];
	[self.collectionView registerNib:nib forCellWithReuseIdentifier:kCellID];
	
	
	//[self updateData];
    [self.collectionView reloadData];
    self.registrationView.hidden = YES;
    self.hideView.hidden = YES;
    

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.searchView.hidden = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
