//
//  CommentViewController.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 1. 28..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "CommentViewController.h"
#import "PlaylistCatagory.h"
#import "AFHTTPRequestOperationManager.h"
#import "CommentCell.h"
#import "SoundIDCatagory.h"


@interface CommentViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *textFieldView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIControl *hideView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIProgressView *progressBar;


@end

@implementation CommentViewController{
    SoundIDCatagory *soundCatagory;
    PlaylistCatagory *playCatagory;
    NSMutableArray *commentList;
    NSMutableArray *userID;
    NSMutableArray *userImg;
    NSMutableArray *userName;
    NSMutableArray *commentID;
    NSMutableArray *commentTime;
    NSMutableArray *contents;
    NSString *sound_ID;
}

-(IBAction)toggleButton:(id)sender{
    if(playCatagory.player.rate == 1.0){
        [playCatagory pause];
    }
    else{
        [playCatagory.player play];
    }
}

-(IBAction)dimissKeyboard:(id)sender{
    [self.textField resignFirstResponder];
}

-(IBAction)comment:(id)sender{
    [self AFNetworkingSearchListInputComment:self.textField.text];
    self.hideView.hidden = YES;
    self.textField.text = @"";
    [self.textField resignFirstResponder];
}

-(IBAction)dismiss:(id)sender{
    [self.textField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self AFNetworkingSearchListInputComment:self.textField.text];
    self.hideView.hidden = YES;
    self.textField.text = @"";
    [self.textField resignFirstResponder];
    return YES;
}

//network comment input
-(void)AFNetworkingSearchListInputComment:(NSString *)comment{
    NSString *i = [NSString stringWithFormat:@"7"];
    NSString *d = [NSString stringWithFormat:@"%@",sound_ID];
    NSString *x = [NSString stringWithFormat:@"%@",comment];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"foo":@"bar", @"user_id":i, @"sound_id":d, @"contents":x};
    [manager POST: @"http://mixhips.nowanser.cloulu.com/write_comment" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"JSON: %@", responseObject);
        [self AFNetworkingSearchList];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

//network
- (void)search:(NSDictionary *)dic {
    NSDictionary *dd = [NSDictionary dictionaryWithDictionary:dic];
    NSArray *commentlistFF = [dd objectForKey:@"comment_list"];
//    NSString *comment_count = [NSString stringWithFormat:@"%@",[dd objectForKey:@"comment_count"]];
    
    
    ////////////////////
    userID = [[NSMutableArray alloc]init];
    userImg = [[NSMutableArray alloc]init];
    userName = [[NSMutableArray alloc]init];
    commentID = [[NSMutableArray alloc ]init];
    commentTime = [[NSMutableArray alloc]init];
    contents = [[NSMutableArray alloc]init];
    commentList = [[NSMutableArray alloc]init];
    for(int i=0;i<commentlistFF.count;i++)
    {
        [userID addObject:[commentlistFF[i] objectForKey:@"user_id"]];
        [userImg addObject:[commentlistFF[i] objectForKey:@"user_img_url"]];
        [userName addObject:[commentlistFF[i] objectForKey:@"user_name"]];
        [commentID addObject:[commentlistFF[i] objectForKey:@"comment_id"]];
        [commentTime addObject:[commentlistFF[i] objectForKey:@"comment_time"]];
        [contents addObject:[commentlistFF[i] objectForKey:@"contents"]];
        
        [commentList addObject:[AlbumList comment:userID[i] user_name:userName[i] user_img:userImg[i] commentID:commentID[i] commentTime:commentTime[i] contents:contents[i]]];
        
    }
    [commentList reverseObjectEnumerator];
    NSLog(@"cou : %d",commentList.count);

    
}
-(void)AFNetworkingSearchList{
   // sound_ID = [NSString stringWithFormat:@"%d",21];
    NSString *i = [NSString stringWithFormat:@"%@",sound_ID];
    NSLog(@"idididi : %@", sound_ID);

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"foo":@"bar", @"sound_id":i};
    [manager POST: @"http://mixhips.nowanser.cloulu.com/request_comment" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"JSON: %@", responseObject);
        [self search:responseObject];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(void)AFNetworkingSearchListDelete:(NSInteger)indexpathRow{
    NSString *i = [NSString stringWithFormat:@"7"];
    NSString *d = [NSString stringWithFormat:@"%@",commentID[indexpathRow]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"foo":@"bar", @"user_id":i, @"comment_id":d};
    [manager POST: @"http://mixhips.nowanser.cloulu.com/delete_comment" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"JSON: %@", responseObject);
        [self AFNetworkingSearchList];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}
//////////////

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(UITableViewCellEditingStyleDelete == editingStyle){
        [self AFNetworkingSearchListDelete:indexPath.row];
    }
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return commentList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"COMMENT_CELL" forIndexPath:indexPath];
    self.list = [commentList objectAtIndex:indexPath.row];
    [cell setPlaylistInfo:self.list];
    return cell;
}

-(void)keyboardWillHide:(NSNotification *)noti{
    self.textFieldView.center = CGPointMake(self.textFieldView.center.x, self.textFieldView.center.y +122);
    self.hideView.hidden = NO;
}


-(void)keyboardWillShow:(NSNotification *)noti{
    self.textFieldView.center = CGPointMake(self.textFieldView.center.x, self.textFieldView.center.y - 122);
    self.hideView.hidden = NO;
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
    sound_ID = [[SoundIDCatagory defaultCatalog] getSoundid] ;
    NSLog(@"-- %@",sound_ID);
    playCatagory = [PlaylistCatagory defaultCatalog];
    [self AFNetworkingSearchList];
}

-(void)viewDidAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:Nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    //감시자 삭제
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.progressBar = [[UIProgressView alloc] initWithFrame:CGRectMake(93, 25, 200, 2)];
    [self.navigationController.toolbar addSubview:self.progressBar];
	// Do any additional setup after loading the view.
    self.hideView.hidden = YES;
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
