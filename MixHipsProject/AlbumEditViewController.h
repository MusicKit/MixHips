//
//  AlbumEditViewController.h
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 5..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumList.h"
#import "AppDelegate.h"

@interface AlbumEditViewController : UIViewController
{
    AppDelegate * appDelegate;
}
@property(nonatomic,retain) AppDelegate * appDelegate;
@property (strong,nonatomic) AlbumList *list;
@property (strong, nonatomic)    NSMutableArray *soundArr;
@end
