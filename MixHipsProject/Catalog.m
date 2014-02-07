//
//  Catalog.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 3..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "Catalog.h"
#import "AlbumList.h"

@implementation Catalog
{
    NSArray *albumList;
}

// 싱글톤 메소드
static Catalog *_instance = nil;

+ (id)defaultCatalog
{
    if (nil == _instance) {
        _instance = [[Catalog alloc] init];
    }
    return _instance;
}

- (id) init
{
    self = [super init];
    if (self) {
        albumList = @[[AlbumList albumlist:@"let it go" singerName:@"Idina Menzel" image:@""],
                      [AlbumList albumlist:@"Love is an open door" singerName:@"Kristen Bell" image:@""]];
    }
    return self;
}

- (NSUInteger)numberOfMusic
{
    return [albumList count];
}

- (id)musicAt:(NSUInteger)index
{
    return [albumList objectAtIndex:index];
}


@end
