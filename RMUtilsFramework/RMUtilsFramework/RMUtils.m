//
//  RMUtils.m
//  RMUtilsFramework
//
//  Created by JianRongCao on 15/12/14.
//  Copyright © 2015年 JianRongCao. All rights reserved.
//

#import "RMUtils.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <mach/mach.h>
#import <objc/runtime.h>
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation RMUtils

#pragma mark 正则验证
+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)isValidatPhone:(NSString*)phone
{
    NSString *regex = @"^((1[0-9][0-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:phone];
}

+ (BOOL)isValidateNumberSymbol:(NSString *)string length:(NSInteger)length
{
    NSString *emailRegex = [NSString stringWithFormat:@"[a-zA-Z0-9]{%ld}",length];
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    
    return [emailTest evaluateWithObject:string];
}

+ (BOOL)isValidDictionary:(id)object
{
    return object && [object isKindOfClass:[NSDictionary class]];
}

+ (BOOL)isValidArray:(id)object
{
    return object && [object isKindOfClass:[NSArray class]];
}

+ (BOOL)isValidString:(id)object
{
    return object && [object isKindOfClass:[NSString class]];
}

#pragma mark 时间格式化
+ (NSString *)commonTimeFormat:(NSString*)msgCreateTime
{
    //获取当前时间
    NSDate *date = [NSDate date];
    double intervalTime = [date timeIntervalSince1970] - [msgCreateTime doubleValue] ;
    
    long lTime = (long)intervalTime;
    
    long iDays = 60*60*24;
    long iTwoDay = iDays *2;
    long iMonth = iDays * 30;
    long iYears = iMonth * 12;
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:[msgCreateTime doubleValue]];
    NSString *showtimeNew;
    
    if ((0 < lTime) && ( lTime < iDays))
    {
        [formatter1 setDateFormat:@"yyyy-MM-dd"];
        showtimeNew = [NSString stringWithFormat:@"%@",[formatter1 stringFromDate:d]];
        NSString * nowDate = [NSString stringWithFormat:@"%@",[formatter1 stringFromDate:date]];
        if ([showtimeNew isEqualToString:nowDate])
        {
            [formatter1 setDateFormat:@"HH:mm"];
            showtimeNew = [NSString stringWithFormat:@"%@",[formatter1 stringFromDate:d]];
        }
        else
        {
            [formatter1 setDateFormat:@"HH:mm"];
            showtimeNew = [NSString stringWithFormat:@"%@ %@",@"昨天",[formatter1 stringFromDate:d]];
        }
    }
    
    else if ((lTime > iDays) && (lTime < iTwoDay))
    {
        [formatter1 setDateFormat:@"yyyy-MM-dd"];
        NSDate * yestoday =   [NSDate dateWithTimeIntervalSinceNow:-iDays];
        showtimeNew = [NSString stringWithFormat:@"%@",[formatter1 stringFromDate:d]];
        NSString * nowDate = [NSString stringWithFormat:@"%@",[formatter1 stringFromDate:yestoday]];
        if ([showtimeNew isEqualToString:nowDate])
        {
            [formatter1 setDateFormat:@"HH:mm"];
            showtimeNew = [NSString stringWithFormat:@"%@ %@",@"昨天",[formatter1 stringFromDate:d]];
        }
        else
        {
            [formatter1 setDateFormat:@"MM-dd"];
            showtimeNew = [NSString stringWithFormat:@"%@",[formatter1 stringFromDate:d]];
        }
    }
    else if ((lTime > iTwoDay) && (lTime < iYears))
    {
        [formatter1 setDateFormat:@"MM-dd"];
        showtimeNew = [NSString stringWithFormat:@"%@",[formatter1 stringFromDate:d]];
    }
    else if (lTime < 0)
    {
        [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm"];
        showtimeNew = [NSString stringWithFormat:@"%@",[formatter1 stringFromDate:d]];
    }
    else if (lTime > iYears)
    {
        [formatter1 setDateFormat:@"yyyy-MM-dd"];
        showtimeNew = [NSString stringWithFormat:@"%@",[formatter1 stringFromDate:d]];
    }
    return showtimeNew;
}

+ (NSString *)getTime:(NSString *)time oldFormat:(NSString *)oldFormat format:(NSString *)format
{
    NSDateFormatter *fromat = [[NSDateFormatter alloc] init];
    [fromat setDateFormat:oldFormat];
    NSDate *date = [fromat dateFromString:time];
    [fromat setDateFormat:format];
    NSString *dateString = [fromat stringFromDate:date];
    return dateString;
}

+ (NSString *)getTime:(NSTimeInterval)time format:(NSString *)format
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *fromat = [[NSDateFormatter alloc] init];
    [fromat setDateFormat:format];
    NSString *dateString = [fromat stringFromDate:date];
    return dateString;
}

#pragma mark 获取iOS设备型号
+ (NSString *)getPlatformVersion
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char *)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    
    NSDictionary *paltformDictionary = [NSDictionary dictionaryWithContentsOfFile:
                                        [[NSBundle mainBundle] pathForResource:@"iOSPlatform" ofType:@"plist"]];
    //NSDictionary *paltformDictionary = [RMUtils platformVersion];
    NSString *paltformName = [paltformDictionary valueForKey:platform];

    return  paltformName ? paltformName : @"Unknown Platform";
}

#pragma mark 检测手机运营商
+ (NSString *)checkChinaMobile
{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    if (carrier == nil) {

        return nil;
    }
    
    NSString *code = [carrier mobileNetworkCode];
    
    if (code == nil) {
        return nil;
    }
    if ([code isEqualToString:@"00"] || [code isEqualToString:@"02"] || [code isEqualToString:@"07"]) {
        return @"中国移动";
    }else if ([code isEqualToString:@"01"]){
        return @"中国联通";
    }else if([code isEqualToString:@"20"]) {
        return @"中国铁通";
    }else if([code isEqualToString:@"03"]) {
        return @"中国电信";
    }

    return nil;
}

#pragma mark Json String、NSDictionary以及对象互转
+ (id)serializationString:(NSString *)jsonString
{
    if (![self isValidString:jsonString]) {
        return nil;
    }
    NSError *error = nil;
    id obj = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]
                                             options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        return nil;
    }
    return obj;
}

+ (NSString *)serializationObject:(id)object
{
    if (!object) {
        return nil;
    }
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
    if (!jsonData) {
        return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

+ (void)setModelValue:(id)model fromDictionary:(NSDictionary *)param
{
    NSArray *properties = [self getPropertyList:[model class] withSuper:YES];
    for (NSString *key in properties) {
        id value = [param objectForKey:key];
        [model setValue:value forKey:key];
    }
}

+ (NSArray *)getPropertyList:(Class)obj withSuper:(BOOL)getSuper
{
    NSMutableArray *propertiesArray = [[NSMutableArray alloc] init];
    id peopleClass = obj;
    do {
        unsigned int outCount;
        //获取指向当前类的所有属性
        objc_property_t *properties = class_copyPropertyList(peopleClass, &outCount);
        for (int idx = 0; idx < outCount; idx++) {
            objc_property_t property = properties[idx];
            //获取当前属性的NSString名称
            NSString *propName = [NSString stringWithUTF8String:property_getName(property)];
            [propertiesArray addObject:propName];
        }
        peopleClass = [peopleClass superclass];
        
    } while (![[obj description] isEqualToString:@"NSObject"] && getSuper);
    return propertiesArray;
}

#pragma mark 获取App内部文件路径
+ (NSString *)bundlePath:(NSString *)fileName
{
    return [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:fileName];
}

#pragma mark 获取Documents内文件路径
+ (NSString *)documentsFilePath:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}

+ (NSString *)documentsDirectotyPath:(NSString *)direction
{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *docDir = [docPath stringByAppendingPathComponent:direction];
    BOOL directory = YES;
    NSError *error = nil;
    if (![[NSFileManager defaultManager] fileExistsAtPath:docDir isDirectory:&directory]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:docDir
                                  withIntermediateDirectories:NO
                                                   attributes:nil
                                                        error:&error];
        if (error) {
            NSLog(@"创建缓存目录 --->  %@失败",docDir);
            return nil;
        }
    }
    return docDir;
}

#pragma mark 获取缓存路径文件路径
+ (NSString *)cacheFilePath:(NSString *)cacheName
{
    if ([RMUtils isValidString:cacheName]) {
        return nil;
    }
    if (cacheName.length == 0) {
        return nil;
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:cacheName];
}

+ (NSString *)cacheDirectionPath:(NSString *)direction
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *cacheDir = [cachePath stringByAppendingPathComponent:direction];
    BOOL directory = YES;
    NSError *error = nil;
    if (![[NSFileManager defaultManager] fileExistsAtPath:cacheDir isDirectory:&directory]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:cacheDir
                                  withIntermediateDirectories:NO
                                                   attributes:nil
                                                        error:&error];
        if (error) {
            NSLog(@"创建缓存目录 --->  %@失败",cacheDir);
            return nil;
        }
    }
    return cacheDir;
}

#pragma mark 对于不需要频繁使用的图片，使用ContentOfFile的方式加载
+ (UIImage *)imageNameWithString:(NSString *)imageName
{
    if (nil == imageName || YES == [imageName isEqualToString:@""])
        return nil;
    NSString *sImagePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:imageName];
    UIImage *image = [UIImage imageWithContentsOfFile:sImagePath];
    if (nil == image)
        image = [UIImage imageNamed:imageName];
    return image;
}

@end
