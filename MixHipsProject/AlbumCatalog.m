//
//  AlbumCatalog.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 5..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "AlbumCatalog.h"
#import "AlbumList.h"

@implementation AlbumCatalog{
    NSArray *albumlist;
}

static AlbumCatalog *_instance = nil;

+ (id)defaultCatalog
{
    if (nil == _instance) {
        _instance = [[AlbumCatalog alloc] init];
    }
    return _instance;
}

- (id) init
{
    self = [super init];
    if (self) {
        albumlist = @[[AlbumList album:@"MIL" image:@"album1.png" like:@"98" nickName:@"CHA BOOM"],
                      [AlbumList album:@"MONEY" image:@"album2.png" like:@"21" nickName:@"CHA BOOM"],
                      [AlbumList album:@"ALOHA" image:@"Album3.png" like:@"11" nickName:@"CHA BOOM"]];
    }
    return self;
}

- (NSUInteger)numberOfAlbum
{
    return [albumlist count];
}

- (id)albumAt:(NSUInteger)index
{
    NSLog(@"%d, %d", [albumlist count], index);	
    return [albumlist objectAtIndex:index];
}



@end
