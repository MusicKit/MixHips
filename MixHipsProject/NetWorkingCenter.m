//
//  NetWorkingCenter.m
//  MixHipsProject
//
//  Created by SDT-1 on 2014. 2. 7..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "NetWorkingCenter.h"
#import "AFHTTPRequestOperationManager.h"

#define NewsURL @"http://mixhips.nowanser.cloulu.com/request_ad_list"

@implementation NetWorkingCenter

- (void)test:(NSDictionary *)dic {
    NSDictionary *dd = [NSDictionary dictionaryWithDictionary:dic];
    NSLog(@"%@",dd);
    NSArray *abc = [dd objectForKey:@"ad_list"];
    for(int i=0;i<abc.count;i++)
    {
        NSLog(@"ad_id=%@",[abc[i] objectForKey:@"ad_id"]);
    }
}
-(void)AFNetworkingAD:(NSInteger)num{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"foo":@"bar"};
    [manager POST: @"http://mixhips.nowanser.cloulu.com/request_ad_list" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self test:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
