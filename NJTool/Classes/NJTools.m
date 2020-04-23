//
//  NJTools.m
//  ZCS
//
//  Created by NinJa on 2019/5/7.
//  Copyright © 2019 NinJa. All rights reserved.
//

#import "NJTools.h"

@implementation NJTools

NJSingle_M(NJTools)

//正则判断手机号
+ (BOOL)isTelephoneNumber:(NSString *)mobile
{
    NSString *phoneRegex = @"^(13[0-9]|14[5|7|9]|15[0|1|2|3|5|6|7|8|9]|16[6]|17[0|1|2|3|5|6|7|8]|18[0-9]|19[8|9])\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

//正则判断车牌号车架号
+ (BOOL)isVinNumber:(NSString *)number
{
    NSString *phoneRegex = @"^[a-zA-Z0-9]{6}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:number];
}

//正则判断车牌号车架号
+(BOOL)isEngineNumber:(NSString *)number
{
    NSString *phoneRegex = @"^[a-zA-Z0-9]{4}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:number];
}

//正则判断省份
+ (BOOL)isCarNumer:(NSString*)carNumber
{
    //至少包含一个数字和字母，且为后6位  ^[A-Z]
    NSString *carRegex = @"^(([京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领][A-Z](([0-9]{5}[DF])|([DF]([A-HJ-NP-Z0-9])[0-9]{4})))|([京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领][A-Z][A-HJ-NP-Z0-9]{4}[A-HJ-NP-Z0-9挂学警港澳使领]))$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:carNumber];
}

//字符串转json
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        return nil;
    }
    return dic;
}

//json 转字符串
+ (NSString *)jsonStringWithDict:(NSDictionary *)dict {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
    
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return jsonString;
}

//判断空字符串
+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if([string isEqual:@"(null)"])
    {
        return YES;
    }
    if([string isEqual:@"null"])
    {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

//字母和数字
+ (BOOL)isLetterAndNumber:(NSString *)str
{
    BOOL result = false;
    if ([str length] >= 6){
        // 判断长度大于6位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,18}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:str];
    }
    return result;
}


 /**
 小写a-z
 大写A-Z
 汉字\u4E00-\u9FA5
 数字\u0030-\u0039
 @param str 要过滤的字符
 @return YES 只允许输入字母和汉字
 */

/**
 * 字母、中文正则判断（不包括空格）
 */
+ (BOOL)isInputRuleNotBlank:(NSString *)str {
    NSString *pattern = @"^[a-zA-Z\u4E00-\u9FA5\\s]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}
/**
 * 字母、数字、中文正则判断
 */
+ (BOOL)isInputRuleAndBlank:(NSString *)str {
    
    NSString *pattern = @"^[a-zA-Z\u4E00-\u9FA5\\d\\s]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}
/**
 *  获得 kMaxLength长度的字符
 */
+(NSString *)getSubString:(NSString*)string withMaxlength:(NSInteger)maxlength
{
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* data = [string dataUsingEncoding:encoding];
    NSInteger length = [data length];
    if (length > maxlength) {
        NSData *data1 = [data subdataWithRange:NSMakeRange(0, maxlength)];
        NSString *content = [[NSString alloc] initWithData:data1 encoding:encoding];//【注意4】：当截取kMaxLength长度字符时把中文字符截断返回的content会是nil
        if (!content || content.length == 0) {
            data1 = [data subdataWithRange:NSMakeRange(0, maxlength - 1)];
            content =  [[NSString alloc] initWithData:data1 encoding:encoding];
        }
        return content;
    }
    return nil;
}

/**
 *  过滤字符串中的emoji
 */
+ (NSString *)disable_emoji:(NSString *)text{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}

+ (NSString *)dateToNomarl:(NSString *)date style:(DateStyle)style
{
    if (style == DateStyleDefaut) {//年月日
        return [date substringToIndex:10];
    }
    
    if (style == DateStyleYMD){//yyyy年mm月tt日
        NSString *y = [date substringWithRange:NSMakeRange(0, 4)];
        NSString *m = [date substringWithRange:NSMakeRange(5, 2)];
        NSString *t = [date substringWithRange:NSMakeRange(8, 2)];
        return [NSString stringWithFormat:@"%@年%@月%@日",y,m,t];
    }
    
    if (style == DateStyleMDY){//mm.ttyyyy
        NSString *y = [date substringWithRange:NSMakeRange(0, 4)];
        NSString *m = [date substringWithRange:NSMakeRange(5, 2)];
        NSString *t = [date substringWithRange:NSMakeRange(8, 2)];
        return [NSString stringWithFormat:@"%@.%@%@",m,t,y];
    }
    
    if (style == DateStyleMD) {//月日
        return [date substringWithRange:NSMakeRange(5, 5)];
    }
    return date;
}

+ (NSString *)timeString:(NSString *)time
{
    int num = [time intValue];
    int min = num % 60;
    int h = num / 60;
    if (h == 0) {
        NSString *str = [NSString stringWithFormat:@"%dmin",min];
        return str;
    }else{
        NSString *str = [NSString stringWithFormat:@"%dh%dmin",h,min];
        return str;
    }
}



+ (NSString *)getCurrentDateWithFomatter:(NSString *)formatterStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate date];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:formatterStr];
    return [formatter stringFromDate:date];
}


+ (NSString *)getDateWithFomatter:(NSString *)formatterStr withDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatterStr];
    return [formatter stringFromDate:date];
}



+ (UIImage *)compressWithLengthLimit:(NSUInteger)maxLength image:(UIImage *)image{
    // Compress by quality
    
    CGFloat maxLengthB = maxLength * 1024 * 1024;
    
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    //NSLog(@"Before compressing quality, image size = %ld KB",data.length/1024);
    if (data.length < maxLengthB) return [UIImage imageWithData:data];
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        //NSLog(@"Compression = %.1f", compression);
        //NSLog(@"In compressing quality loop, image size = %ld KB", data.length / 1024);
        if (data.length < maxLengthB * 0.9) {
            min = compression;
        } else if (data.length > maxLengthB) {
            max = compression;
        } else {
            break;
        }
    }
    //NSLog(@"After compressing quality, image size = %ld KB", data.length / 1024);
    if (data.length < maxLengthB) return [UIImage imageWithData:data];
    UIImage *resultImage = [UIImage imageWithData:data];
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLengthB && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLengthB / data.length;
        //NSLog(@"Ratio = %.1f", ratio);
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
        NSLog(@"In compressing size loop, image size = %ld KB", data.length / 1024);
    }
    NSLog(@"After compressing size loop, image size = %ld KB", data.length / 1024);
    return [UIImage imageWithData:data];
}


+ (UIImage *)compressWithOriginalImage:(UIImage *)image maxLength:(NSUInteger)maxLength{
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length <= maxLength) {
        return [UIImage imageWithData:data];
    }
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        
        UIImage *resultImage = [UIImage imageWithData:data];
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)), (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        data = UIImageJPEGRepresentation(resultImage, 1);
        compression = (max + min) / 2;
        
        if (data.length <= maxLength) {
            return [UIImage imageWithData:data];
        }
        if (data.length < maxLength) {
            min = compression;
        } else if (data.length > maxLength * 0.9) {
            max = compression;
        } else {
            break;
        }
        
        data = UIImageJPEGRepresentation(resultImage, compression);
        if (data.length <= maxLength) {
            return [UIImage imageWithData:data];
        }
    }
    return  [UIImage imageWithData:data];
}

+ (BOOL)checkUpdateWithResponseObject:(id)responseObject
{
    //本地版本
    NSString * VER = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    //阶段字段
    NSString *stageVersion = [VER substringToIndex:1];
    //大版本字段
    NSString *bigVersion = [VER substringWithRange:NSMakeRange(2, 1)];
    //小版本字段
    NSString *smallVersion = [VER substringWithRange:NSMakeRange(4, 1)];
    
    NSInteger currentVersion = [[NSString stringWithFormat:@"%@%@%@",stageVersion,bigVersion,smallVersion] integerValue];
    
    //appstore版本
    NSString *appstore = [[[responseObject objectForKey:@"results"] objectAtIndex:0] valueForKey:@"version"];
    //阶段字段
    NSString *stageServerVersion = [appstore substringToIndex:1];
    //大版本字段
    NSString *bigServerVersion = [appstore substringWithRange:NSMakeRange(2, 1)];
    //小版本字段
    NSString *smallServerVersion = [appstore substringWithRange:NSMakeRange(4, 1)];
    
    NSInteger Version = [[NSString stringWithFormat:@"%@%@%@",stageServerVersion,bigServerVersion,smallServerVersion] integerValue];
    
    if (Version > currentVersion) {
        return YES;
    }
    return NO;
}

+ (void)callPhoneForView:(UIView *)view phone:(NSString *)phone
{
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phone]]]];
    [view addSubview:callWebview];
}


+ (void)convertMovToMp4FromAVURLAsset:(AVURLAsset*)urlAsset andCompeleteHandler:(void(^)(NSURL *fileUrl))fileUrlHandler{

    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:urlAsset.URL options:nil];
    
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    //中等质量 可以通过WIFI网络分享
    if ([compatiblePresets containsObject:AVAssetExportPresetMediumQuality]){
       
        //  在Documents目录下创建一个名为FileData的文件夹
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"Cache/VideoData"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isDir = FALSE;
        BOOL isDirExist = [fileManager fileExistsAtPath:path isDirectory:&isDir];
        if(!(isDirExist && isDir)) {
            BOOL bCreateDir = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
            if(!bCreateDir){
                NSLog(@"创建文件夹失败！%@",path);
            }
            NSLog(@"创建文件夹成功，文件路径%@",path);
        }

        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        [formatter setDateFormat:@"yyyy_MM_dd_HH_mm_ss"]; //每次启动后都保存一个新的文件中
        NSString *dateStr = [formatter stringFromDate:[NSDate date]];

        NSString *resultPath = [path stringByAppendingFormat:@"/%@.mp4",dateStr];
        NSLog(@"file path:%@",resultPath);

        NSLog(@"resultPath = %@",resultPath);

        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset
                                                                               presetName:AVAssetExportPresetMediumQuality];
        exportSession.outputURL = [NSURL fileURLWithPath:resultPath];
        exportSession.outputFileType = AVFileTypeMPEG4;
        exportSession.shouldOptimizeForNetworkUse = YES;

        [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
         {
             switch (exportSession.status) {
                 case AVAssetExportSessionStatusUnknown:
                     NSLog(@"AVAssetExportSessionStatusUnknown");
                     fileUrlHandler(nil);
                     break;
                 case AVAssetExportSessionStatusWaiting:
                     NSLog(@"AVAssetExportSessionStatusWaiting");
                     fileUrlHandler(nil);
                     break;
                 case AVAssetExportSessionStatusExporting:
                     NSLog(@"AVAssetExportSessionStatusExporting");
                     fileUrlHandler(nil);
                     break;
                 case AVAssetExportSessionStatusCompleted:
                     NSLog(@"AVAssetExportSessionStatusCompleted");
                     fileUrlHandler(exportSession.outputURL);
                     break;
                 case AVAssetExportSessionStatusFailed:
                     NSLog(@"AVAssetExportSessionStatusFailed");
                     fileUrlHandler(nil);
                     break;

                 case AVAssetExportSessionStatusCancelled:
                     NSLog(@"AVAssetExportSessionStatusCancelled");
                     fileUrlHandler(nil);
                     break;
             }
         }];
    }
}



@end
