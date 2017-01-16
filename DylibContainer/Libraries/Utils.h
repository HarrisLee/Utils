//
//  Utils.h
//  Libraries
//
//  Created by JianRongCao on 1/16/17.
//  Copyright © 2017 JianRongCao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (Utils *)shareInstance;

- (void)showMessage:(NSString *)message;

@end
