//
//  YKCalendarTool.h
//  YKCalendarDemo
//
//  Created by 易凯 on 16/9/18.
//  Copyright © 2016年 易凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKCalendarTool : NSObject

+ (NSInteger)getYear; // 返回当前年
+ (NSInteger)getMonth; // 返回当前月
+ (NSInteger)getDay; // 返回当前日
+ (BOOL)isYesterdayWithDate:(NSDate *)date; // 判断是否为是否为昨天
+ (BOOL)isTodayWithDate:(NSDate *)date; // 判断是否为今天
+ (BOOL)isTomorrowWithDate:(NSDate *)date; // 判断是否为明天
+ (BOOL)isTheDayAfterTomorrowWithDate:(NSDate *)date; // 判断是否为后天
+ (NSInteger)getSpecifiedYearWithDate:(NSDate *)date; // 返回指定Date的年
+ (NSInteger)getSpecifiedMonthWithDate:(NSDate *)date; // 返回指定Date的月
+ (NSInteger)getSpecifiedDayWithDate:(NSDate *)date; // 返回指定Date的日
+ (NSInteger)getSpecifiedMinuteWithDate:(NSDate *)date; // 返回指定Date的分
+ (NSInteger)getSpecifiedSecondWithDate:(NSDate *)date; // 返回指定Date的秒
+ (BOOL)isLoopYear:(NSInteger)year; // 判断是否是闰年
+ (NSInteger)getSpecifiedWeakdayWithDate:(NSDate *)date; // 返回某一天是星期几
+ (NSInteger)getWeekOfFirstDayOfMonth:(int)year withMonth:(int)month; // 获得某个月的第一天是星期几
+ (NSInteger)getDaysOfMonth:(int)year withMonth:(int)month; // 返回一个月有多少天

@end
