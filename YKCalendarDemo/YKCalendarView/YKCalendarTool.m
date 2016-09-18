//
//  YKCalendarTool.m
//  YKCalendarDemo
//
//  Created by 易凯 on 16/9/18.
//  Copyright © 2016年 易凯. All rights reserved.
//


#import "YKCalendarTool.h"

@implementation YKCalendarTool

// 判断是否是闰年
+ (BOOL)isLoopYear:(NSInteger)year{
    if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
        return true;
    }else
        return NO;
}

// 返回当前年
+ (NSInteger)getYear{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *nowDate = [NSDate date];
    NSDateComponents *nowDateComps = [[NSDateComponents alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    nowDateComps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:nowDate];
    
    return [nowDateComps year];
}

// 返回当前月
+ (NSInteger)getMonth{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *nowDate = [NSDate date];
    NSDateComponents *nowDateComps = [[NSDateComponents alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    nowDateComps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:nowDate];
    
    return [nowDateComps month];
}

// 返回当前日
+ (NSInteger)getDay{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *nowDate = [NSDate date];
    NSDateComponents *nowDateComps = [[NSDateComponents alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    nowDateComps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:nowDate];
    return [nowDateComps day];
}

// 返回指定Date的年
+ (NSInteger)getSpecifiedYearWithDate:(NSDate *)date{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear fromDate:date];
    return dateComponents.year;
}

// 返回指定Date的月
+ (NSInteger)getSpecifiedMonthWithDate:(NSDate *)date{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear fromDate:date];
    return dateComponents.month;
}

// 返回指定Date的日
+ (NSInteger)getSpecifiedDayWithDate:(NSDate *)date{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear fromDate:date];
    return dateComponents.day;
}

// 返回指定Date的时
+ (NSInteger)getSpecifiedHourWithDate:(NSDate *)date{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear fromDate:date];
    return dateComponents.hour;
}

// 返回指定Date的分
+ (NSInteger)getSpecifiedMinuteWithDate:(NSDate *)date{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear fromDate:date];
    return dateComponents.minute;
}

// 返回指定Date的秒
+ (NSInteger)getSpecifiedSecondWithDate:(NSDate *)date{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear fromDate:date];
    return dateComponents.second;
}

// 返回某一天是星期几
+ (NSInteger)getSpecifiedWeakdayWithDate:(NSDate *)date{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear fromDate:date];
    return dateComponents.weekday - 1;
}

// 获得某个月的第一天是星期几
+ (NSInteger)getWeekOfFirstDayOfMonth:(int)year withMonth:(int)month{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSString *firstWeekDayMonth = [[NSString alloc] initWithFormat:@"%d",year];
    firstWeekDayMonth = [firstWeekDayMonth stringByAppendingString:[[NSString alloc]initWithFormat:@"%s","-"]];
    firstWeekDayMonth = [firstWeekDayMonth stringByAppendingString:[[NSString alloc]initWithFormat:@"%d",month]];
    firstWeekDayMonth = [firstWeekDayMonth stringByAppendingString:[[NSString alloc]initWithFormat:@"%s","-"]];
    firstWeekDayMonth = [firstWeekDayMonth stringByAppendingString:[[NSString alloc]initWithFormat:@"%d",1]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *weekOfFirstDayOfMonth = [dateFormatter dateFromString:firstWeekDayMonth];
    NSDateComponents *newCom = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:weekOfFirstDayOfMonth];
    
    return  newCom.weekday - 1;
}

// 判断是否为是否为昨天
+ (BOOL)isYesterdayWithDate:(NSDate *)date{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    // 获得只有年月日的时间
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSDate *nowDate = [fmt dateFromString:nowString];
    NSString *selfString = [fmt stringFromDate:date];
    NSDate *selfDate = [fmt dateFromString:selfString];
    // 比较
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}

// 判断是否为今天
+ (BOOL)isTodayWithDate:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfCmps = [calendar components:unit fromDate:date];
    return nowCmps.year == selfCmps.year && nowCmps.month == selfCmps.month&& nowCmps.day == selfCmps.day;
}

// 判断是否为明天
+ (BOOL)isTomorrowWithDate:(NSDate *)date{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    // 获得只有年月日的时间
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSDate *nowDate = [fmt dateFromString:nowString];
    NSString *selfString = [fmt stringFromDate:date];
    NSDate *selfDate = [fmt dateFromString:selfString];
    // 比较
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    return cmps.year == 0 && cmps.month == 0 && cmps.day == -1;
}

// 判断是否为后天
+ (BOOL)isTheDayAfterTomorrowWithDate:(NSDate *)date{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    // 获得只有年月日的时间
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSDate *nowDate = [fmt dateFromString:nowString];
    NSString *selfString = [fmt stringFromDate:date];
    NSDate *selfDate = [fmt dateFromString:selfString];
    // 比较
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    return cmps.year == 0 && cmps.month == 0 && cmps.day == -2;
}

// 返回一个月有多少天
+ (NSInteger)getDaysOfMonth:(int)year withMonth:(int)month{
    NSInteger num_year  = year;
    NSInteger num_month = month;
    BOOL isrunNian = num_year%4==0 ? (num_year%100==0? (num_year%400==0?YES:NO):YES):NO;
    switch (num_month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:{
            return 31;
        }
            break;
        case 4:
        case 6:
        case 9:
        case 11:{
            return 30;
        }
            break;
        case 2:{
            if (isrunNian) {
                return 29;
            }else{
                return 28;
            }
        }
            break;
        default:
            break;
    }
    return 0;
}

@end
