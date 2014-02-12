//
//  MyPageViewController.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 1. 16..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "MyPageViewController.h"
#import "AlbumCatalog.h"
#import "AlbumList.h"
#import "MyPageCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "AFHTTPRequestOperationManager.h"
#import "MyAlbumViewController.h"
#import "FollowViewController.h"

@interface MyPageViewController ()<UIImagePickerControllerDelegate, UIActionSheetDelegate ,UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
//@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UILabel *Message;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *FollowingCount;
@property (weak, nonatomic) IBOutlet UILabel *FollowerCount;

@end

@implementation MyPageViewController{
    NSMutableArray *albumlist;
    NSString *follwer;
    NSString *following;
    NSString *userImg;
    NSString *userSay1;
    NSString *userID;
    NSString *userName;
    NSMutableArray *albumID;
    UITextField *searchField;
}


-(IBAction)getprofileMessage:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"MixHips" message:@"한마디" delegate:self cancelButtonTitle:@"취소" otherButtonTitles:@"등록", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.cancelButtonIndex == buttonIndex){
        NSLog(@"취소");
    }
    else if(alertView.firstOtherButtonIndex == buttonIndex){
        searchField = [alertView textFieldAtIndex:0];
        self.Message.text = searchField.text;
        [self AFNetworkingADSay];
    }
}

//액션버튼에서 사용자가 특정 버튼을 눌렀을 때 처리
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;

    if(buttonIndex == 0){
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            //에러 처리
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"오류" message:@"카메라가 지원되지 않는 기종입니다." delegate:nil cancelButtonTitle:@"확인" otherButtonTitles: nil];
            [alert show];
            return;
        }
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];
        //[self presentModalViewController:imagePicker animated:YES];
    }
    else if(buttonIndex == 1){
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //[self presentModalViewController:imagePicker animated:YES];
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    else if(buttonIndex == 2){
        
        //기본적인 이미지 나오면 그걸로 구현
        self.profileImage.image = nil;
    }
    else if(buttonIndex == actionSheet.cancelButtonIndex)
    {
        //[actionSheet showInView:self.view];
    }
}


//사진편집 버튼
-(IBAction)getProfileImage:(id)sender{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"취소" destructiveButtonTitle:nil otherButtonTitles:@"사진촬영",@"앨범에서 사진 선택",@"삭제", nil];
    [sheet showInView:self.view];
}


//바뀐 사진을 선택했을시 프로필 사진이 바뀐다.
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //편집된 이미지가 있으면 사용, 없으면 원본으로 사용
    UIImage *usingImage = (nil == editedImage)? originalImage : editedImage;
    self.profileImage.image = usingImage;
    
    //피커 감추기
    [picker dismissViewControllerAnimated:YES completion:nil];
    //[picker dismissModalViewControllerAnimated:YES];
}

//network say
-(void)AFNetworkingADSay{
   // NSString *d = [NSString stringWithFormat:@"%@",searchField.text];
    NSString *i = [NSString stringWithFormat:@"7"]; ///   본인 아이디
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"foo":@"bar", @"user_id":i , @"user_say":searchField.text};
    [manager POST: @"http://mixhips.nowanser.cloulu.com/update_user_say" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)test:(NSDictionary *)dic {
    NSDictionary *dd = [NSDictionary dictionaryWithDictionary:dic];
    
    userID = [NSString stringWithFormat:@"%@",[dd objectForKey:@"user_id"]];
    userName = [NSString stringWithFormat:@"%@",[dd objectForKey:@"user_name"]];
    follwer = [NSString stringWithFormat:@"%@",[dd objectForKey:@"follower"]];
    following = [NSString stringWithFormat:@"%@", [dd objectForKey:@"following"]];
    userImg = [NSString stringWithFormat:@"%@", [dd objectForKey:@"user_img_url"]];
    userSay1 = [NSString stringWithFormat:@"%@",[dd objectForKey:@"user_say"]];
    
    NSLog(@"img : %@",userImg);
    
    NSArray *album = [dd objectForKey:@"albums"];
    albumID = [[NSMutableArray alloc]init];
    NSMutableArray *albumImg = [[NSMutableArray alloc]init];
    NSMutableArray *albumName = [[NSMutableArray alloc]init];
    NSMutableArray *like = [[NSMutableArray alloc]init];
    albumlist = [[NSMutableArray alloc]init];
    for(int i=0;i<album.count;i++)
    {
        [albumID addObject:[album[i] objectForKey:@"album_id"]];
        [albumImg addObject:[album[i] objectForKey:@"album_img_url"]];
        [albumName addObject:[album[i] objectForKey:@"album_name"]];
        [like addObject:[album[i] objectForKey:@"like_count"]];
        
        [albumlist addObject:[AlbumList hotArtistAlbumlist:albumID[i] album_img:albumImg[i] album_name:albumName[i] like:like[i]]];
    }
    NSLog(@"arr %@",albumName);
    NSLog(@"counn ; %d",albumlist.count);
    [self.collectionView reloadData];
}

-(void)AFNetworkingAD{
    NSString *d = [NSString stringWithFormat:@"7"];
    NSString *i = [NSString stringWithFormat:@"7"]; ///   본인 아이디
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"foo":@"bar", @"my_id(user_id(본인))":i , @"user_id":d};
    [manager POST: @"http://mixhips.nowanser.cloulu.com/request_user" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"JSON: %@", responseObject);
        [self test:responseObject];
        [self setProfile];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(void)setProfile{
    self.title = userName;
    self.Message.text = userSay1;
    self.FollowerCount.text = [NSString stringWithFormat:@"%@",follwer];
    self.FollowingCount.text = [NSString stringWithFormat:@"%@",following];
    NSString *url = @"http://mixhips.nowanser.cloulu.com/";
     url = [url stringByAppendingString:userImg];
    NSURL *userURL = [NSURL URLWithString:userImg];
    [self.profileImage setImageWithURL:userURL];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:[NSString stringWithFormat:@"album"]]){
        MyAlbumViewController *dest = (MyAlbumViewController *)segue.destinationViewController;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
        dest.album_ID = albumID[indexPath.row];
        dest.user_ID = userID;
    }
    if([segue.identifier isEqualToString:@"following"]){
        FollowViewController *dest = (FollowViewController *)segue.destinationViewController;
        dest.user_ID = userID;
    }
    if([segue.identifier isEqualToString:@"follower"]){
        
    }
    
    //AlbumList *list = [[listCatalog defaultCatalog] albumAt:indexPath.row];
    //dest.list = list;
}

// -------------- 콜렉션 뷰-----------------

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"counn ; %d",albumlist.count);
	return albumlist.count+1;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	MyPageCollectionViewCell* cell;
    if (indexPath.row == albumlist.count) {
        cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"IMG_CELL_ID1" forIndexPath:indexPath];
    }
    else {
        
        cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"albumlist_cell" forIndexPath:indexPath];
        NSLog(@"rr r %d",albumlist.count);
        self.list = [albumlist objectAtIndex:indexPath.row];
        NSLog(@"%@",self.list);
        
        [cell setAlbumInfo:self.list];
    }
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


///////////////////////////////////////////////////////////////////////////


-(void)viewWillAppear:(BOOL)animated{
    [self AFNetworkingAD];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	
	
	//[self updateData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
