//
//  MusicFileViewController.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 17..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "MusicFileViewController.h"
#import "MusicFileCell.h"
#import "EdicCell.h"
#import "AlbumEditViewController.h"
#import "EditCatagory.h"

@interface MusicFileViewController ()<UITableViewDataSource , UITableViewDelegate, UIAlertViewDelegate>

@end

@implementation MusicFileViewController{
    NSMutableArray *theFiles;
    NSMutableArray *fileList;
    NSString *documentsDirectory;
//    NSString *dataPath;
    EdicCell *editCell;
    EditCatagory *editCatagory;
    NSString *soundName;
    UITextField *searchField;
    NSString *ddd ;
    NSInteger index;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"곡명" message:@"두 글자이상 입력하세요." delegate:self cancelButtonTitle:@"취소" otherButtonTitles:@"등록", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    index = indexPath.row;
    [alert show];
    
    ddd = [NSString stringWithFormat:@"/%@",theFiles[indexPath.row]];
   }

-(BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView{

        searchField = [alertView textFieldAtIndex:0];
        return ([searchField.text length] > 2);

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

        if(alertView.cancelButtonIndex == buttonIndex){
            NSLog(@"취소");
        }
        else if(alertView.firstOtherButtonIndex == buttonIndex){
            
            ddd =[documentsDirectory stringByAppendingString:ddd];
            NSLog(@"%@",ddd);
            NSData *data  = [[NSData alloc]initWithContentsOfFile:ddd];
            searchField = [alertView textFieldAtIndex:0];
            soundName = searchField.text;
            NSString *fileName = [NSString stringWithFormat:@"%@",theFiles[index]];
            NSLog(@"ff %@",fileName);
            NSLog(@"dd %@",soundName);
            editCatagory = [EditCatagory defaultCatalog];
            //[editCatagory albumName:soundName];
//            [editCatagory setFileName:fileName];
            [editCatagory setFile:fileName];
            [editCatagory setArrTest:soundName];
            [editCatagory setData:data];
            //[editCatagory setData:data];
            [self.navigationController popViewControllerAnimated:YES];
        }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return theFiles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MusicFileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"list"];
    cell.listName.text = [theFiles objectAtIndex:indexPath.row];
    return cell;
}

-(void)dismissVC{
    [self.navigationController popViewControllerAnimated:YES];
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
    [self.navigationItem.backBarButtonItem setTitle:@" "];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDirectory = [paths objectAtIndex:0];
//    dataPath = [documentsDirectory stringByAppendingPathComponent:@"/Music"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:documentsDirectory])
        [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:NO attributes:nil error:nil];

    
    NSFileManager *manager = [NSFileManager defaultManager];
    fileList = [manager directoryContentsAtPath:documentsDirectory];
    
 //    [fileList addObject:[manager contentsAtPath:dataPath]];
    for (NSString *s in fileList){
        theFiles = fileList;
    }
    NSLog(@"%@",theFiles);
	// Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(dismissVC)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
