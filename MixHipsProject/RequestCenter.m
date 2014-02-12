//
//  RequestCenter.m
//  Mudeum
//
//  Created by In Chung Yeul on 2014. 2. 4..
//  Copyright (c) 2014년 In Chung Yeul. All rights reserved.
//

#import "RequestCenter.h"

@implementation RequestCenter


// 동기방식, 결과는 반환값으로 받는다.
- (NSDictionary *)setSyncRequest:(NSMutableURLRequest *)request withOption:(NSDictionary *)dic {
    NSDictionary *dicResult;
    NSUInteger option = kNilOptions;
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    __autoreleasing NSError *error;
    if (nil != dic) {
        NSData *postData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
        [request setHTTPBody:postData];
    }
    NSData *dResult = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error]; // 추가
    dicResult = [NSJSONSerialization JSONObjectWithData:dResult options:option error:&error];
    return dicResult;
}
@end