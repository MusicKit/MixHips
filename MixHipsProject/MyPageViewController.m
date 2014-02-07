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

@interface MyPageViewController ()<UIImagePickerControllerDelegate, UIActionSheetDelegate ,UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
//@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UILabel *Message;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation MyPageViewController

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
        UITextField *searchField = [alertView textFieldAtIndex:0];
        NSLog(@"%@",searchField.text);
        self.Message.text = searchField.text;
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


// -------------- 콜렉션 뷰-----------------
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    if(indexPath.row == ([[AlbumCatalog defaultCatalog] numberOfAlbum])){
//        [self performSegueWithIdentifier:@"edit_cell" sender:nil];
//        
//        NSLog(@"%d",[[AlbumCatalog defaultCatalog]numberOfAlbum]);
//    }
//    else{
//        [self performSegueWithIdentifier:@"myalbumjoin" sender:nil];
//   }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return ([[AlbumCatalog defaultCatalog] numberOfAlbum] + 1);
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	MyPageCollectionViewCell* cell;
    if (indexPath.row == ([[AlbumCatalog defaultCatalog] numberOfAlbum])) {
        cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"IMG_CELL_ID1" forIndexPath:indexPath];
    }
    else {
        cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"albumlist_cell" forIndexPath:indexPath];
        AlbumList *albumlist = [[AlbumCatalog defaultCatalog] albumAt:indexPath.row];
        [cell setAlbumInfo:albumlist];
    }
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


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


///////////////////////////////////////////////////////////////////////////




- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	
	
	//[self updateData];
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
