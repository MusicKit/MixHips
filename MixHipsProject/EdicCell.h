//
//  EdicCell.h
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 5..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EdicCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *soundName;
@property (weak, nonatomic) IBOutlet UILabel *soundNum;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (nonatomic) NSInteger indexPathRow;

-(void)setInfo:(NSInteger)indexPathRow;

@end
