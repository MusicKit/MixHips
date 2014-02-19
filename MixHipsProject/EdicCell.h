//
//  EdicCell.h
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 5..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumCelldelegate.h"
#import "AlbumList.h"
#import "EditDelegate.h"

@interface EdicCell : UITableViewCell<UITextFieldDelegate>
@property (weak,nonatomic) id<EditDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *soundNum;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (nonatomic) NSInteger indexPathRow;
@property (weak, nonatomic) IBOutlet UILabel *soundname;

-(void)setInfo:(NSString *)soundname indexPath:(NSInteger)indexPathRow fileName:(NSString *)filename;
@end
