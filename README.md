# PandaHttpSwift
PandaHttp的OC版本，基于Object-C语言而开发

## 前言

PandaHttpOC是为 IOS Object-C开发提供的一个基础 HTTP 封装框架，它的特点及原则如下:

1. 限定同步式的网络操作
2. 提供对 JSON以及 Form两种请求方式的支持
3. 简化对网络的操作

## 为什么需要这个框架

> 请参阅我个人的 [IOS 开发规范（OC）](http://http://ios-guildline.lingenliu.com)以理解我的编码风格及规范，这个 HTTP 框架是支持此规范的重要实现(Swift版)

我在进行移动开发的两个重要的理念

1. 服务层异步，数据库及网络层同步
   
   我的开发规范中，一个 APP 分为【UI层】，【服务层】，【网络层】，【数据库层】，【工具层】几层，它们是严格限制调用的
   
   其中，服务层是异步处理的，但网络层以及数据库层都使用同步方式来实现，这样在一个服务中，处理多个网络或数据库行为时，就不会存在大量异步及回调，使得逻辑非常混乱 
   
2. 一种选择好于多种选择

  APP与 API 交互的模式有非常多种，比如 JSON,XML或其它等；对于我个人而言，以支持 JSON 为主，无论是请求，还是返回，都以 JSON 为交互对象
  
  因此，我的网络请求框架会重点考虑适配一种模式，这样以简化移动端的网络开发，越单一，越容易抽像

## 有哪些版本
会提供 OC,Swift,Java三种版本，以支持 Android和 IOS 的开发

#使用示例

### GET请求的示例

~~~object-c
    OPHttpRequest* request = [OPHttpRequest jsonRequest:@"http://openpanda.org:8081/account/search?search=l&page=1&pagesize=10" method:OPH_HTTP_GET];
    
    OPHttpResponse* response = [[OPNetworkSession sharedInstance] syncRequest:request];
    
    if ([response isRequestOk]) {
        NSDictionary* value = [response excepedDictionayResult];
        NSLog(@"结果是：%@",value);
    }

~~~

> 返回结果

~~~

结果是：{
    msg = "Everything is ok";
    result =     {
        page = 1;
        pageCount = 10;
        total = 1;
        totalPage = 1;
        values =         (
                        {
                createTime = 1474461815379;
                email = "lingen@foxmail.com";
                enable = 1;
                mobile = 123456;
                nickname = "\U5fa1\U5251";
                updateTime = 1474461815379;
                username = lingen;
                uuid = "c1ef7ea0-502b-4513-940c-57bfae08732b";
                version = 0;
            }
        );
    };
    status = 0;
}

~~~

返回的值也是一个 JSON

### Post请求

~~~Object-C

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
        
        
~~~

>返回结果

~~~

结果是：{
    msg = "mobile exists";
    result = "<null>";
    status = 10011;
}

~~~

### Put请求

>> Pust请求与 Post请求基本一致，使用OPH_HTTP_PUT

### Delete请求

>> 参照Get请求，使用OPH_HTTP_DELETE

