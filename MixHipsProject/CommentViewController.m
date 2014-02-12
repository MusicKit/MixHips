//
//  CommentViewController.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 1. 28..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "CommentViewController.h"

@interface CommentViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *textFieldView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIControl *hideView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation CommentViewController

-(IBAction)dimissKeyboard:(id)sender{
    [self.textField resignFirstResponder];
}

-(IBAction)comment:(id)sender{
    [self.textField resignFirstResponder];
}

-(IBAction)dismiss:(id)sender{
    [self.textField resignFirstResponder];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"COMMENT_CELL" forIndexPath:indexPath];
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
