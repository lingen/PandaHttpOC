//
//  OPHttpResponse.m
//  PandaHttpOC
//
//  Created by lingen on 16/9/22.
//  Copyright © 2016年 lingen.liu. All rights reserved.
//

#import "OPHttpResponse.h"

static int OK_STATUS = 200;
@interface OPHttpResponse()

@end
@implementation OPHttpResponse


/*
 * HTTP是否正确响应，正常响应为200
 */
-(BOOL)isRequestOk{
    return _statusCode == OK_STATUS;
}

/*
 * HTTP返回了正确的响应
 */
+(nonnull instancetype)okResponse:(nullable NSData*)data{
    OPHttpResponse* response = [[OPHttpResponse alloc] init];
    response.statusCode = OK_STATUS;
    response.data = data;
    return response;
}

/*
 * HTTP返回了错误的响应
 */
+(nonnull instancetype)errorStatusCodeResponse:(int)statusCode error:(nullable NSError*)error{
    OPHttpResponse* response = [[OPHttpResponse alloc] init];
    response.statusCode = statusCode;
    response.error = error;
    return response;
}

/*
 * 返回期望的String结果
 */
-(nullable NSString*)exceptedStringResult{
    if (![self isRequestOk]) {
        return nil;
    }
    
    return  [[NSString alloc] initWithData:_data encoding:NSASCIIStringEncoding];
}

/*
 * 返回期望的NSDictionary的结果
 */
-(nullable NSDictionary*)excepedDictionayResult{
    
    if (![self isRequestOk]) {
        return nil;
    }
    
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:_data
                                                         options:kNilOptions
                                                           error:nil];
    return json;
}

@end
