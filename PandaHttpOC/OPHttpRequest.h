//
//  OPHttpRequest.h
//  PandaHttpOC
//
//  Created by lingen on 16/9/22.
//  Copyright © 2016年 lingen.liu. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * 网络请求方式
 */
typedef NS_ENUM(NSInteger,OPHttpRequestMethod) {
    
    /*
     * GET请求
     */
    OPH_HTTP_GET,
    
    /*
     * Post请求
     */
    OPH_HTTP_POST,
    
    /*
     * Put请求
     */
    OPH_HTTP_PUT,
    
    /*
     * Delete请求
     */
    OPH_HTTP_DELETE
};

/*
 * 网络请求的ContentType类型
 */
typedef NS_ENUM(NSInteger,OPHHttpContentType) {

    /*
     *JSON格式类型的请求TYPE
     */
    JSON_CONTENT_TYPE
    
};


@interface OPHttpRequest : NSObject


/*
 * 超时时间
 */
@property (assign,nonatomic) NSTimeInterval timeout;

/*
 * HTTP请求的方式
 */
@property (assign,nonatomic) OPHttpRequestMethod method;

/*
 * 请求的contentType
 */
@property (assign,nonatomic) OPHHttpContentType contentType;

/*
 * 请求参数
 */
@property (nullable,nonatomic,strong) NSDictionary* params;

/*
 * 请求URL
 */
@property (nonnull,nonatomic,strong) NSString* url;

/*
 * 根据URL,以及Method产生一个请求
 */
+(nonnull instancetype)jsonRequest:(nonnull NSString*)url method:(OPHttpRequestMethod)method;

/*
 * 根据URL,以及Method,params三个参数来产生一个请求
 */
+(nonnull instancetype)jsonRequest:(nonnull NSString*)url method:(OPHttpRequestMethod)method params:(nullable NSDictionary*)params;

/*
 * 根据URL,Method,params和timeout来产生一个请求
 */
+(nonnull instancetype)jsonRequest:(nonnull NSString*)url method:(OPHttpRequestMethod)method params:(nullable NSDictionary*)params timeout:(NSTimeInterval)timeout;

@end


