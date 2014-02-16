
//
//  AlbumEditViewController.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 5..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "AlbumEditViewController.h"
#import "AlbumList.h"
#import "MyAlbumCell.h"
#import "Catalog.h"
#import "AFHTTPRequestOperationManager.h"
#import "EdicCell.h"
#import "EditCatagory.h"

@interface AlbumEditViewController ()<UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (weak, nonatomic) IBOutlet UIButton *albumNameButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *albumNameTextField;
@property (weak, nonatomic) IBOutlet UIImageView *albumImg;
@property (weak, nonatomic) IBOutlet UIControl *hideView;
@property (weak, nonatomic) IBOutlet UIButton *albumNameEdit;
@property (weak, nonatomic) IBOutlet UILabel *albumName;

@end

@implementation AlbumEditViewController{
    EdicCell *editCell;
    NSInteger numCell;
    EditCatagory *editCatagory;
    NSArray *soundNameArr;
    NSString *soundName;
    UITextField *searchField;
    NSString *albumName;
    UIAlertView *alert;
    UIAlertView *alert1;
}

-(IBAction)albumNameEdit:(id)sender{
    alert = [[UIAlertView alloc]initWithTitle:@"MixHips" message:@"앨범명" delegate:self cancelButtonTitle:@"취소" otherButtonTitles:@"입력", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView == alert){
        if(alert.cancelButtonIndex == buttonIndex){
            NSLog(@"취소");
        }
        else if(alert.firstOtherButtonIndex == buttonIndex){
            searchField = [alertView textFieldAtIndex:0];
            self.albumName.text = searchField.text;
            albumName = [NSString stringWithFormat:@"%@",searchField.text];
            NSLog(@"sff%@",albumName);
        }
    }
    if(alertView == alert1){
        
    }
    
}

//사진편집 버튼
-(IBAction)getProfileImage:(id)sender{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"취소" destructiveButtonTitle:nil otherButtonTitles:@"사진촬영",@"앨범에서 사진 선택",@"삭제", nil];
    [sheet showInView:self.view];
}

-(IBAction)albumUploadButton:(id)sender{
//    if(numCell >1 && numCell <11){
    soundName = [[EditCatagory defaultCatalog] returnSoundName];
    soundNameArr = [[NSMutableArray alloc]init];
    soundNameArr = [[EditCatagory defaultCatalog]getArrTest];
    
    
    NSLog(@"ffff %d",soundNameArr.count);
    
    
    [self AFNetworkingUploadAlbum];
//     }
//    else{
//        alert1 = [[UIAlertView alloc]initWithTitle:@"MixHips" message:@"2곡이상 등록하세요." delegate:self cancelButtonTitle:nil otherButtonTitles:@"확인", nil];
//        alert1.alertViewStyle = UIAlertViewStyleDefault;
//        [alert1 show];
//
//    }
}

-(IBAction)getProfileImageff:(id)sender{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"취소" destructiveButtonTitle:nil otherButtonTitles:@"사진촬영",@"앨범에서 사진 선택",@"삭제", nil];
    [sheet showInView:self.view];
}

-(IBAction)getProfileImagedd:(id)sender{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"취소" destructiveButtonTitle:nil otherButtonTitles:@"사진촬영",@"앨범에서 사진 선택",@"삭제", nil];
    [sheet showInView:self.view];
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
        self.albumImg.image = nil;
    }
    else if(buttonIndex == actionSheet.cancelButtonIndex)
    {
        //[actionSheet showInView:self.view];
    }
}



//바뀐 사진을 선택했을시 프로필 사진이 바뀐다.
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //편집된 이미지가 있으면 사용, 없으면 원본으로 사용
    UIImage *usingImage = (nil == editedImage)? originalImage : editedImage;
    self.albumImg.image = usingImage;
    //피커 감추기
    [picker dismissViewControllerAnimated:YES completion:nil];
    //[picker dismissModalViewControllerAnimated:YES];
}




//uploadAlbum
-(void)AFNetworkingUploadAlbum{
    
    NSString *d = [NSString stringWithFormat:@"%@",albumName];
    NSString *i = [NSString stringWithFormat:@"7"]; ///   본인 아이디
    NSString *x = [NSString stringWithFormat:@"%d",soundNameArr.count];
    
    
    NSData *imageData = UIImageJPEGRepresentation(self.albumImg.image, 0.5);
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];


    NSDictionary *parameters = @{@"foo":@"bar", @"user_id":i, @"album_name":d, @"sounds_name":soundNameArr, @"sound_count":x};
    [manager POST: @"http://mixhips.nowanser.cloulu.com/upload_album" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        [formData appendPartWithFileData:imageData name:@"album_img" fileName:@"Mixhips" mimeType:@"image/jpeg"];
        [formData appendPartWithFileData:imageData name:@"sounds_file" fileName:@"Mixhips" mimeType:@"image/jpeg"];
    }success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(void)keyboardWillHide:(NSNotification *)noti{
    
    self.view.center = CGPointMake(self.view.center.x, self.view.center.y +122);
    self.hideView.hidden = NO;
}


-(void)keyboardWillShow:(NSNotification *)noti{
    self.view.center = CGPointMake(self.view.center.x, self.view.center.y - 122);
    self.hideView.hidden = NO;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == numCell){
        if(numCell ==10){
            
        }
        else{
        numCell++;
        NSLog(@"click    %d",numCell);
        [self.tableView reloadData];
        }
    }
    else{
        editCell.indexPathRow = indexPath.row;
        
    }
}
//
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(UITableViewCellEditingStyleDelete == editingStyle){
        
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return numCell+1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EdicCell *cell;
    
    if(indexPath.row == (numCell)){
        cell = [tableView dequeueReusableCellWithIdentifier:@"add_cell" forIndexPath:indexPath];
        
    }
    else{
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"list_cell" forIndexPath:indexPath];
        [cell setInfo:indexPath.row];
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

-(void)viewDidAppear:(BOOL)animated{
    editCell = [[EdicCell alloc]init];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:Nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    //감시자 삭제
    [[NSNotificationCenter defaultCenter] removeObserver:self];
   
}

-(void)viewWillAppear:(BOOL)animated{
    numCell = 0;
     self.hideView.hidden = YES;
    self.soundArr = [[NSMutableArray alloc]init];
    
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
