//
//  HotArtistCatalog.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 8..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "HotArtistCatalog.h"
#import "RequestCenter.h"
#import "AlbumList.h"

@implementation HotArtistCatalog
{
    NSMutableArray *albumlist;
    NSArray *good;
}

static HotArtistCatalog *_instance = nil;

//-(void)selectDelegate:(listViewController *)delegate {
//    self.newsVC = delegate;
//}


+ (id)defaultCatalog
{
    if (nil == _instance) {
        _instance = [[HotArtistCatalog alloc] init];
    }
    return _instance;
}

- (id) init
{
    self = [super init];
    if (self) {
        [self net];
        good =[[NSArray alloc]init];
        good = albumlist;
    }
    return self;
}

-(void)net{
    RequestCenter *requestCenter = [[RequestCenter alloc] init];
    NSURL *urlCurrent = [NSURL URLWithString:@"http://mixhips.nowanser.cloulu.com/request_hot_user"];
    NSMutableURLRequest *requestCurrent = [NSMutableURLRequest requestWithURL:urlCurrent];
    NSDictionary *dicRequest = @{@"키":@"값"};
    NSDictionary *dicResult = [requestCenter setSyncRequest:requestCurrent withOption:dicRequest];
    
    ////////////////////
    NSArray *abc = [dicResult objectForKey:@"hot_user"];
    NSMutableArray *userID = [[NSMutableArray alloc]init];
    NSMutableArray *image = [[NSMutableArray alloc]init];
    NSMutableArray *userName = [[NSMutableArray alloc]init];
    albumlist = [[NSMutableArray alloc]init];
    for(int i=0;i<3;i++)
    {
        [userID addObject:[abc[i] objectForKey:@"user_id"]];
        [image addObject:[abc[i] objectForKey:@"user_img_url"]];
        
        [userName addObject:[abc[i] objectForKey:@"user_name"]];
        [albumlist addObject:[AlbumList hotArtistList:userID[i] userName:userName[i] userImg:image[i]]];
    }
    
    //    [self.newsVC reloadTable];
    //good = albumlist;

}

- (NSUInteger)numberOfHotArtist
{
    return [good count];
}

- (id)artistAt:(NSUInteger)index
{
    return [good objectAtIndex:index];
}




@end
