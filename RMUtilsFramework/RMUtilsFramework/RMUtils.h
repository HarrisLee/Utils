//
//  RMUtils.h
//  RMUtilsFramework
//
//  Created by JianRongCao on 15/12/14.
//  Copyright © 2015年 JianRongCao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RMUtils : NSObject

/*! Email地址合法性判断  非法：NO  合法：YES*/
+ (BOOL)isValidateEmail:(NSString *)email;

/*! 手机号码合法性判断    非法：NO  合法：YES*/
+ (BOOL)isValidatPhone:(NSString*)phone;

/*! 字符串是否是N位的纯数字和字母*/
+ (BOOL)isValidateNumberSymbol:(NSString *)string length:(NSInteger)length;


/*! 判断该对象是否是NSDictionary*/
+ (BOOL)isValidDictionary:(id)object;

/*! 判断该对象是否是NSArray*/
+ (BOOL)isValidArray:(id)object;

/*! 判断该对象是否是NSString*/
+ (BOOL)isValidString:(NSString*)string;


/*! 获取时间 格式如今天 12：11， 昨天：09：15等等*/
+ (NSString *)commonTimeFormat:(NSString*)msgCreateTime;

/*! 根据时间字符串获取时间*/
+ (NSString *)getTime:(NSString *)time oldFormat:(NSString *)oldFormat format:(NSString *)format;

/*! 根据时间戳获取时间*/
+ (NSString *)getTime:(NSTimeInterval)time format:(NSString *)format;


/*! 获取硬件型号，如iPhone 6S,iPad Pro等*/
+ (NSString *)getPlatformVersion;


/*! 返回运营商平台*/
+ (NSString *)checkChinaMobile;


/*! 将JSON字符串序列化成对象*/
+ (id)serializationString:(NSString *)jsonString;

/*! 将NSDictionary对象转换成成*/
+ (NSString *)serializationObject:(id)object;

/*! 获取Model的属性数组(getSuper   YES:获取父类属性  NO:不获取父类属性)*/
+ (NSArray *)getPropertyList:(Class)obj withSuper:(BOOL)getSuper;

/*! 获取NSDictionary的值，将Model对应的key进行赋值，以model的key值为标准*/
+ (void)setModelValue:(id)model fromDictionary:(NSDictionary *)param;


/*! App内部某个文件的位置*/
+ (NSString *)bundlePath:(NSString *)fileName;

/*! App Documents文件夹下某个文件的位置*/
+ (NSString *)documentsFilePath:(NSString *)fileName;

/*! App Documents文件夹下某个文件夹的位置*/
+ (NSString *)documentsDirectotyPath:(NSString *)direction;

/*! App Libiries/Caches下某个文件的位置*/
+ (NSString *)cacheFilePath:(NSString *)cacheName;

/*! App Libiries/Caches下某个文件夹的位置*/
+ (NSString *)cacheDirectionPath:(NSString *)direction;


/*! 优先使用ContentOfFile的方式加载图片*/
+ (UIImage *)loadImageByName:(NSString *)imageName;

@end
