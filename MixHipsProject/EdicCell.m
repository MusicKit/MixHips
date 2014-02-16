    //
//  EdicCell.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 5..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "EdicCell.h"
#import "EditCatagory.h"

@implementation EdicCell{
    NSMutableArray *Arr;
    NSArray *dfsdf;
    EditCatagory *editCatagory;

}

-(void)setInfo:(NSInteger)indexPathRow{
    self.soundNum.text = [NSString stringWithFormat:@"%d",indexPathRow+1];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    editCatagory = [EditCatagory defaultCatalog];
    editCatagory.soundName = [NSString stringWithFormat:@"%@",self.soundName.text];
    [[EditCatagory defaultCatalog] setArrTest:self.soundName.text];
    NSLog(@"%d",Arr.count);
 
    NSLog(@"jsdlfjlsf %@",editCatagory.soundName);
    
    
    
    [self.soundName resignFirstResponder];
    return YES;
}

-(IBAction)deleteButton:(id)sender{
    //음악파일 잇는곳으로 이동...
}






- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
