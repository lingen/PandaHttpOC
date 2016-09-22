//
//  PandaHttpOCTests.m
//  PandaHttpOCTests
//
//  Created by lingen on 9/22/16.
//  Copyright © 2016 lingen.liu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OPHttpRequest.h"
#import "OPHttpResponse.h"
#import "OPNetworkSession.h"

@interface PandaHttpOCTests : XCTestCase

@end

@implementation PandaHttpOCTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testGetJson {
    OPHttpRequest* request = [OPHttpRequest jsonRequest:@"http://openpanda.org:8081/account/search?search=l&page=1&pagesize=10" method:OPH_HTTP_GET];
    
    OPHttpResponse* response = [[OPNetworkSession sharedInstance] syncRequest:request];
    
    if ([response isRequestOk]) {
        NSDictionary* value = [response excepedDictionayResult];
        NSLog(@"结果是：%@",value);
    }
}

-(void)testPostJson {
    
    NSString* url = @"http://openpanda.org:8081/account";
    NSDictionary* params = @{
                             @"username":@"lingen",
                             @"password":@"123456",
                             @"nickname":@"御剑",
                             @"mobile":@"123456",
                             @"email":@"lingen@foxmail.com"
                             };
    
    OPHttpRequest* request = [OPHttpRequest jsonRequest:url method:OPH_HTTP_POST params:params];
    
    OPHttpResponse* response = [[OPNetworkSession sharedInstance] syncRequest:request];

    if ([response isRequestOk]) {
        NSDictionary* value = [response excepedDictionayResult];
        NSLog(@"结果是：%@",value);
    }
}

-(void)testPutJson {
    
    NSString* url = @"http://openpanda.org:8081//account/changePwd";
    NSDictionary* params = @{
                             @"user_id":@"123",
                             @"old_pwd":@"123",
                             @"new_pwd":@"123"
                             };
    
    OPHttpRequest* request = [OPHttpRequest jsonRequest:url method:OPH_HTTP_PUT params:params];
    
    OPHttpResponse* response = [[OPNetworkSession sharedInstance] syncRequest:request];
    
    if ([response isRequestOk]) {
        NSDictionary* value = [response excepedDictionayResult];
        NSLog(@"结果是：%@",value);
    }
    
}
@end
