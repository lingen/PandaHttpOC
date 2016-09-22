//
//  OPNetworkSession.h
//  PandaHttpOC
//
//  Created by lingen on 16/9/22.
//  Copyright © 2016年 lingen.liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OPHttpRequest;
@class OPHttpResponse;
/*
 *网络请求的核心方法
 */
@interface OPNetworkSession : NSObject

/*
 * 返回一个单例
 */
+(nonnull instancetype)sharedInstance;

/*
 * 发出一个网络请求
 */
-(nonnull OPHttpResponse*)syncRequest:(nonnull OPHttpRequest*)request;

@end
