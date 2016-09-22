//
//  OPHttpResponse.h
//  PandaHttpOC
//
//  Created by lingen on 16/9/22.
//  Copyright © 2016年 lingen.liu. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * HTTP访问的响应结果
 */
@interface OPHttpResponse : NSObject

@property (assign,nonatomic) int statusCode;

@property (nullable,nonatomic,strong) NSData* data;

@property (nullable,nonatomic,strong) NSError* error;

/*
 * HTTP是否正确响应，正常响应为200
 */
-(BOOL)isRequestOk;

/*
 * HTTP返回了正确的响应
 */
+(nonnull instancetype)okResponse:(nullable NSData*)data;

/*
 * HTTP返回了错误的响应
 */
+(nonnull instancetype)errorStatusCodeResponse:(int)statusCode error:(nullable NSError*)error;

/*
 * 返回期望的String结果
 */
-(nullable NSString*)exceptedStringResult;

/*
 * 返回期望的NSDictionary的结果
 */
-(nullable NSDictionary*)excepedDictionayResult;

@end
