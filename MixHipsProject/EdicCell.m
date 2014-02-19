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
    NSArray *mpArr;
    NSArray *soundName;
    NSInteger index;

}

-(void)setInfo:(NSString *)soundname indexPath:(NSInteger)indexPathRow fileName:(NSString *)filename{
    self.soundNum.text = [NSString stringWithFormat:@"%d",indexPathRow+1];
    self.soundname.text = [NSString stringWithFormat:@"%@ (%@)",soundname, filename];
    index = indexPathRow;
    //NSLog(@"%@",[[EditCatagory defaultCatalog]returnSoundName]);
}



-(IBAction)deleteButton:(id)sender{
        NSLog(@"5555 %d",index);
    [self.delegate deleteMusic:index];

//    [[EditCatagory defaultCatalog] deleteCell];
//    NSLog(@"-%d",[[EditCatagory defaultCatalog] getNumCell]);
//    [self.delegate reloadTable];
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
