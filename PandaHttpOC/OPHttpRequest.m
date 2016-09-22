//
//  OPHttpRequest.m
//  PandaHttpOC
//
//  Created by lingen on 16/9/22.
//  Copyright © 2016年 lingen.liu. All rights reserved.
//

#import "OPHttpRequest.h"

/*
 * 默认的一个网络请求的过期时间
 */
static NSTimeInterval DEFAULT_TIMEOUT = 60 * 2;

@interface OPHttpRequest()

@end

@implementation OPHttpRequest


/*
 * 根据URL,以及Method产生一个请求
 */
+(nonnull instancetype)jsonRequest:(nonnull NSString*)url method:(OPHttpRequestMethod)method{
    return [OPHttpRequest jsonRequest:url method:method params:nil timeout:DEFAULT_TIMEOUT];
}

/*
 * 根据URL,以及Method,params三个参数来产生一个请求
 */
+(nonnull instancetype)jsonRequest:(nonnull NSString*)url method:(OPHttpRequestMethod)method params:(nullable NSDictionary*)params{
    
    return [OPHttpRequest jsonRequest:url method:method params:params timeout:DEFAULT_TIMEOUT];
}

/*
 * 根据URL,Method,params和timeout来产生一个请求
 */
+(nonnull instancetype)jsonRequest:(nonnull NSString*)url method:(OPHttpRequestMethod)method params:(nullable NSDictionary*)params timeout:(NSTimeInterval)timeout{
    
    OPHttpRequest* request = [[OPHttpRequest alloc] init];
    request.url = url;
    request.method = method;
    request.params = params;
    request.timeout = timeout;
    return request;
    
}

@end
