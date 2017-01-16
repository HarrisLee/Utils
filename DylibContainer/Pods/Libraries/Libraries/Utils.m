//
//  Utils.m
//  Libraries
//
//  Created by JianRongCao on 1/16/17.
//  Copyright © 2017 JianRongCao. All rights reserved.
//

#import "Utils.h"

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
}

@end
