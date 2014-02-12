//
//  NewsCatalog.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 7..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "NewsCatalog.h"
#import "NetWorkingCenter.h"
#import "Newslist.h"
#import "AFHTTPRequestOperationManager.h"
#import "NewsViewController.h"
@implementation NewsCatalog{
    NetWorkingCenter *networkingCenter;
    NSArray *abc;
    NSMutableArray *newslist;
    NSMutableArray *adID;
    NSMutableArray *adMenu;
    NSMutableArray *adTitle;
    NSArray *good;
}
-(void)selectDelegate:(NewsViewController *)delegate {
    self.newsVC = delegate;
}
static NewsCatalog *_instance = nil;
+ (id)defaultCatalog
{

    if (nil == _instance) {
        _instance = [[NewsCatalog alloc] init];
    }
    return _instance;
}

- (id) init
{
    self = [super init];
    if (self) {
        [self AFNetworkingAD];
        good = [[NSArray alloc] init];
 
    }
    
    return self;
}

- (void)test:(NSDictionary *)dic {
    NSDictionary *dd = [NSDictionary dictionaryWithDictionary:dic];
    abc = [dd objectForKey:@"ad_list"];
    adID = [[NSMutableArray alloc]init];
    adMenu = [[NSMutableArray alloc]init];
    adTitle = [[NSMutableArray alloc]init];
    newslist = [[NSMutableArray alloc]init];
    for(int i=0;i<abc.count;i++)
    {
        [adID addObject:[abc[i] objectForKey:@"ad_id"]];
        [adMenu addObject:[abc[i] objectForKey:@"ad_menu"]];
        [adTitle addObject:[abc[i] objectForKey:@"ad_title"]];
        [newslist addObject:[Newslist newsList:adID[i] ad_menu:adMenu[i] ad_title:adTitle[i]]];

    }
    good = newslist;
    [self.newsVC reloadTable];
    
}
-(void)AFNetworkingAD{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"foo":@"bar"};
    [manager POST: @"http://mixhips.nowanser.cloulu.com/request_ad_list" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
        [self test:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


- (NSUInteger)numberOfNews
{
    return [good count];
}

- (id)newsAt:(NSUInteger)index
{
    return [good objectAtIndex:index];
}


@end
