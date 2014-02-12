
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

@interface AlbumEditViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (weak, nonatomic) IBOutlet UIButton *albumNameButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AlbumEditViewController

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ([[Catalog defaultCatalog] numberOfMusic] +1);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyAlbumCell *cell;
    
    if(indexPath.row == ([[Catalog defaultCatalog] numberOfMusic])){
        cell = [tableView dequeueReusableCellWithIdentifier:@"add_cell" forIndexPath:indexPath];
        
    }
    else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"list_cell" forIndexPath:indexPath];
        AlbumList *albumlist = [[Catalog defaultCatalog] musicAt:indexPath.row];
        [cell setProductInfo:albumlist indexPath:indexPath.row];
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
