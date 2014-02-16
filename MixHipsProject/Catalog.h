//
//  Catalog.h
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 3..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Catalog : NSObject
+ (id)defaultCatalog;
- (NSUInteger)numberOfMusic;
- (id)musicAt:(NSUInteger)index;

@end
