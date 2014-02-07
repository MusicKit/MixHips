//
//  NewsCatalog.h
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 7..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NewsViewController;
@interface NewsCatalog : NSObject
@property (nonatomic, strong) NewsViewController *newsVC;
-(void)selectDelegate:(id)delegate;
- (NSUInteger)numberOfNews;
- (id)newsAt:(NSUInteger)index;
+ (id)defaultCatalog;
@end
