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
#import "PlaylistCatagory.h"

@interface MyPageViewController ()<UIImagePickerControllerDelegate, UIActionSheetDelegate ,UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *toggleButton;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *Message;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *FollowingCount;
@property (weak, nonatomic) IBOutlet UILabel *FollowerCount;

@end

@implementation MyPageViewController{
    PlaylistCatagory *playCatagory;
    NSMutableArray *albumlist;
    NSString *follwer;
    NSString *following;
    NSString *userImg;
    NSString *userSay1;
    NSString *userID;
    NSString *userName;
    NSMutableArray *albumID;
    UITextField *searchField;
    UIAlertView *alert;
    UIAlertView *alert1;
    NSString *album_id;
    BOOL editChange;
}


-(IBAction)toggleButton:(id)sender{
    if(playCatagory.player.rate == 1.0){
        [playCatagory pause];
    }
    else{
        [playCatagory.player play];
    }
}

-(IBAction)getprofileMessage:(id)sender{
    alert = [[UIAlertView alloc]initWithTitle:@"MixHips" message:@"한마디" delegate:self cancelButtonTitle:@"취소" otherButtonTitles:@"등록", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

-(IBAction)editBOOL:(id)sender{
    if(editChange == YES){
        editChange =NO;
        NSLog(@"%hhd",editChange);
    }
    else if(editChange == NO){
        editChange =YES
        ;
        NSLog(@"%hhd",editChange);
    }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView == alert){
    if(alertView.cancelButtonIndex == buttonIndex){
        NSLog(@"취소");
    }
    else if(alertView.firstOtherButtonIndex == buttonIndex){
        searchField = [alertView textFieldAtIndex:0];
        self.Message.text = searchField.text;
        [self AFNetworkingADSay];
    }
    }
    else if(alertView == alert1)
    {
        if(alertView.cancelButtonIndex == buttonIndex){
            NSLog(@"취소");
        }
        else if(alertView.firstOtherButtonIndex == buttonIndex){
            [self AFNetworkingDeleteAlbum:album_id];
        }
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
            alert = [[UIAlertView alloc]initWithTitle:@"오류" message:@"카메라가 지원되지 않는 기종입니다." delegate:nil cancelButtonTitle:@"확인" otherButtonTitles: nil];
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
    [self AFNetworkingUploadImg:usingImage];
    //피커 감추기
    [picker dismissViewControllerAnimated:YES completion:nil];
    //[picker dismissModalViewControllerAnimated:YES];
}

//uploadImg
-(void)AFNetworkingUploadImg:(UIImage *)img{
    // NSString *d = [NSString stringWithFormat:@"%@",searchField.text];
    NSString *i = [NSString stringWithFormat:@"7"]; ///   본인 아이디
    NSData *imageData = UIImageJPEGRepresentation(img, 0.5);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"foo":@"bar", @"user_id":i};
    [manager POST: @"http://mixhips.nowanser.cloulu.com/upload_user_img" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        [formData appendPartWithFileData:imageData name:@"user_img" fileName:@"Mixhips" mimeType:@"image/jpeg"];
    }success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self AFNetworkingAD];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

//network deleteAlbum
-(void)AFNetworkingDeleteAlbum:(NSString *)albumid{
    // NSString *d = [NSString stringWithFormat:@"%@",searchField.text];
    NSString *i = [NSString stringWithFormat:@"7"]; ///   본인 아이디
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"foo":@"bar", @"user_id":i , @"album_id":albumid};
    [manager POST: @"http://mixhips.nowanser.cloulu.com/delete_album" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self AFNetworkingAD];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
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
    NSArray *album = [[NSArray alloc]init];
    album = [dd objectForKey:@"albums"];
    NSString *string =  [NSString stringWithFormat:@"%@",[dd objectForKey:@"albums"]];
//    NSLog(@"%d",album.count);
    if([string isEqualToString:@"<null>"])
    {
        NSLog(@"NYL");
    }
    else{
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
        
    
    }
    [self.collectionView reloadData];
}

-(void)AFNetworkingAD{
    NSString *d = [NSString stringWithFormat:@"7"];
    NSString *i = [NSString stringWithFormat:@"7"]; ///   본인 아이디
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"foo":@"bar", @"my_id(user_id(본인))":i , @"user_id":d};
    [manager POST: @"http://mixhips.nowanser.cloulu.com/request_user" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"JSON: %@", responseObject);
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
    NSString *url = @"http://mixhips.nowanser.cloulu.com";
     url = [url stringByAppendingString:userImg];
    NSLog(@" ----%@",url);
    NSURL *userURL = [NSURL URLWithString:userImg];
    [self.profileImage setImageWithURL:userURL];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    if([segue.identifier isEqualToString:[NSString stringWithFormat:@"addAlbum"]]){
//        
//    }
//    if([segue.identifier isEqualToString:[NSString stringWithFormat:@"album"]]){
//        
//    }
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

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(editChange == NO){
        if(indexPath.row < albumlist.count){
            album_id = [NSString stringWithFormat:@"%@", albumID[indexPath.row]];
            alert1 = [[UIAlertView alloc]initWithTitle:@"MixHips" message:@"삭제하시겠습니까?" delegate:self cancelButtonTitle:@"취소" otherButtonTitles:@"삭제", nil];
            alert.alertViewStyle = UIAlertViewStyleDefault;
            [alert1 show];
        }
        else{
//            [self prepareForSegue:@"album" sender:self];
        }
    }
    else if(editChange == YES){
        if(indexPath.row < albumlist.count){
            MyAlbumViewController *dest = [[MyAlbumViewController alloc]init];
            dest.album_ID = albumID[indexPath.row];
            dest.user_ID = userID;
            
            [self.navigationController pushViewController:dest animated:NO];
        }
        else{
            
        }
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"counn ; %d",albumlist.count);
	return albumlist.count+1;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	MyPageCollectionViewCell* cell;
    if (indexPath.row == albumlist.count) {
        cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"add_cell" forIndexPath:indexPath];
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
    editChange = YES;
    [self AFNetworkingAD];
    playCatagory = [PlaylistCatagory defaultCatalog];
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
