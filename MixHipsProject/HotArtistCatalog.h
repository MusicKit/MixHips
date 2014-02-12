//
//  HotArtistCatalog.h
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 8..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotArtistCatalog : NSObject

+ (id)defaultCatalog;
- (NSUInteger)numberOfHotArtist;
- (id)artistAt:(NSUInteger)index;

@end
