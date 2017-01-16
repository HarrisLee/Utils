//
//  Utils.m
//  Libraries
//
//  Created by JianRongCao on 1/16/17.
//  Copyright © 2017 JianRongCao. All rights reserved.
//

#import "Utils.h"
#import "Masonry.h"
#import "AFNetworking.h"


@implementation Utils

+ (Utils *)shareInstance
{
    static Utils *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[Utils alloc] init];
    });
    return shareInstance;
}

- (void)showMessage:(NSString *)message
{
    NSLog(@"+++ recive this message is:%@",message);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *URL = @"https://HarrisLee.github.io/found.json";
    [manager GET:URL
      parameters:nil
        progress:^(NSProgress * _Nonnull downloadProgress) {
        }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSLog(@"这里打印请求成功要做的事:%@",responseObject);
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             NSLog(@"%@",error);  //这里打印错误信息
         }];
}

@end
