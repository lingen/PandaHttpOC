//
//  OPNetworkSession.m
//  PandaHttpOC
//
//  Created by lingen on 16/9/22.
//  Copyright © 2016年 lingen.liu. All rights reserved.
//

#import "OPNetworkSession.h"
#import "OPHttpResponse.h"
#import "OPHttpRequest.h"

static NSString* CONTENT_TYPE = @"Content-Type";

static NSString* CONTENT_TYPE_JSON = @"application/json";

static NSString* Content_Length = @"Content_Length";

@interface OPNetworkSession()

@end

@implementation OPNetworkSession


/*
 * 返回一个单例
 */
+(nonnull instancetype)sharedInstance{
    static OPNetworkSession* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[OPNetworkSession alloc] init];
    });
    return instance;
}

/*
 * 发出一个网络请求
 */
-(nonnull OPHttpResponse*)syncRequest:(nonnull OPHttpRequest*)request{
    __block OPHttpResponse* ophResponse = [[OPHttpResponse alloc] init];
    NSURL* url = [NSURL URLWithString:request.url];
    
    NSMutableURLRequest* urlRequest = [[NSMutableURLRequest alloc ] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:request.timeout];
    
    switch (request.method) {
        case OPH_HTTP_GET:
            [urlRequest setHTTPMethod:@"GET"];
            break;
            
        case OPH_HTTP_POST:
            [urlRequest setHTTPMethod:@"POST"];
            break;
            
        case OPH_HTTP_PUT:
            [urlRequest setHTTPMethod:@"PUT"];
            break;
            
        case OPH_HTTP_DELETE:
            [urlRequest setHTTPMethod:@"DELETE"];
            break;
    }
    
    if (request.params && request.params.count > 0) {
        [urlRequest setValue:CONTENT_TYPE_JSON forHTTPHeaderField:CONTENT_TYPE];
        NSData *requestData = [NSJSONSerialization dataWithJSONObject:request.params
                                                              options:NSJSONWritingPrettyPrinted
                                                                error:nil];
        [urlRequest setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:Content_Length];
        
        [urlRequest setHTTPBody: requestData];
        
    }
    
    NSURLSessionConfiguration* defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    NSURLSession* session = [NSURLSession sessionWithConfiguration:defaultConfiguration];
    
    [[session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        if (error) {
            ophResponse = [OPHttpResponse errorStatusCodeResponse:(int)httpResponse.statusCode error:error];
        }else{
            ophResponse = [OPHttpResponse okResponse:data];
        }
        
        dispatch_semaphore_signal(semaphore);
    }] resume];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    return ophResponse;
}
@end
