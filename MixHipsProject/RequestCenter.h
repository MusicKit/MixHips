//
//  RequestCenter.h
//  Mudeum
//
//  Created by In Chung Yeul on 2014. 2. 4..
//  Copyright (c) 2014년 In Chung Yeul. All rights reserved.
//
typedef enum {
    kCurrentStateRequestFail = 20,
    kCurrentStateSuccess = 220,
    kCurrentStateNotUpdate = 221,
    kCurrentStateUpdate = 222, // 변경
    kCurrentStateNotData = 223, // 성공했지만 데이터가 없다
} RequestResultType;

#import <Foundation/Foundation.h>
#define MMD_CUSTOMER_INFO_ID @"MmdCustomerInformationId"
#define MMD_ORDER_INFO_ID @"MmdOrderInformationId"
#define SEARCH_DATE @"searchDate"

#define CURRENT_STATUS @"currentStatus"
#define PICKUP_RESERVATION_DATE @"pickingUpDate"
#define PICKUP_RESERVATION_TIME @"pickingUpTime"
#define PICKUP_COMPLETION_DATE @"dateB"
#define PICKUP_COMPLETION_TIME @"timeB"
#define WASH_COMPLETION_DATE @"dateC"
#define WASH_COMPLETION_TIME @"timeC"
#define DELIVERY_RESERVATION_DATE @"deliveryDate"
#define DELIVERY_RESERVATION_TIME @"deliveryTime"
#define DELIVERY_COMPLETION_DATE @""
#define DELIVERY_COMPLETION_TIME @""
#define DETAIL_CONTENTS @"detailedContents"
#define STATE_A @"A"
#define STATE_B @"B"
#define STATE_C @"C"
#define STATE_D @"D"
#define STATE_E @"E"

@interface RequestCenter : NSObject
//- (void) setAsyncRequest:(NSMutableURLRequest *)request withOption:(NSDictionary *)dic withDelegate:(id)delegate;
- (NSDictionary *)setSyncRequest:(NSMutableURLRequest *)request withOption:(NSDictionary *)dic;
@end
