//
//  NJTools.h
//  ZCS
//
//  Created by NinJa on 2019/5/7.
//  Copyright © 2019 NinJa. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    DateStyleDefaut,
    DateStyleYMD,
    DateStyleMDY,
    DateStyleMD,
} DateStyle;

//@class AVURLAsset;

NS_ASSUME_NONNULL_BEGIN

@interface NJTools : NSObject

/** 手机号 正则 */
+ (BOOL)isTelephoneNumber:(NSString *)mobile;

/** 字母和数字 正则 */
+ (BOOL)isLetterAndNumber:(NSString *)str;

/** 车牌 正则 */
+ (BOOL)isCarNumer:(NSString*)carNumber;

/** 字符串 转 json */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/** json 转 字符串 */
+ (NSString *)jsonStringWithDict:(NSDictionary *)dict;

/** 判断空字符串 */
+ (BOOL) isBlankString:(NSString *)string;

/** 时间转换 (仅针对2019-08-12T15:46:14)*/
+ (NSString *)dateToNomarl:(NSString *)date style:(DateStyle)style;

/** 时间字符串转小时分钟 */
+ (NSString *)timeString:(NSString *)time;



/**
 * 字母、中文正则判断（不包括空格）
 */
+ (BOOL)isInputRuleNotBlank:(NSString *)str;
/**
 * 字母、数字、中文正则判断
 */
+ (BOOL)isInputRuleAndBlank:(NSString *)str;
/**
 *  获得 kMaxLength长度的字符
 */
+(NSString *)getSubString:(NSString*)string withMaxlength:(NSInteger)maxlength;


/** 根据格式获取时间字符串 yyyy-MM-dd HH-mm-ss */
+ (NSString *)getCurrentDateWithFomatter:(NSString *)formatterStr;
+ (NSString *)getDateWithFomatter:(NSString *)formatterStr withDate:(NSDate *)date;


+ (UIImage *)compressWithLengthLimit:(NSUInteger)maxLength image:(UIImage *)image;
+ (UIImage *)compressWithOriginalImage:(UIImage *)image maxLength:(NSUInteger)maxLength;


/** 版本判断 */
+ (BOOL)checkUpdateWithResponseObject:(id)responseObject;
/** 车架号，发动机号后六位正则 */
+ (BOOL)isVinNumber:(NSString *)number;
/** 车架号，发动机后4位正则 */
+ (BOOL)isEngineNumber:(NSString *)number;
/**拨打电话*/
+ (void)callPhoneForView:(UIView *)view phone:(NSString *)phone;
/**视频格式转换 mov->mp4*/
//+ (void)convertMovToMp4FromAVURLAsset:(AVURLAsset*)urlAsset andCompeleteHandler:(void(^)(NSURL *fileUrl))fileUrlHandler;
@end

NS_ASSUME_NONNULL_END
