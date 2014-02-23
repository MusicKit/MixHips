//
//  ListViewController.h
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 1. 16..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumList.h"
#import "AppDelegate.h"


@interface ListViewController : UIViewController
{
    AppDelegate * appDelegate;
}
@property(nonatomic,retain) AppDelegate * appDelegate;
@property (strong,nonatomic) AlbumList *list;
@end
