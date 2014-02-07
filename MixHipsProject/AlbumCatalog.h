//
//  AlbumCatalog.h
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 5..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlbumCatalog : NSObject
+ (id)defaultCatalog;
- (NSUInteger)numberOfAlbum;
- (id)albumAt:(NSUInteger)index;
@end
