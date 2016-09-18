//
//  YKCalendarView.h
//  YKCalendarDemo
//
//  Created by 易凯 on 16/9/18.
//  Copyright © 2016年 易凯. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    YKCalendarViewTypeMonth,
    YKCalendarViewTypeWeek
} YKCalendarViewType;

typedef enum : NSUInteger {
    YKCalendarViewAnimationTypeNull,
    YKCalendarViewAnimationTypeLeft,
    YKCalendarViewAnimationTypeRight,
    YKCalendarViewAnimationTypeOglFlip
} YKCalendarViewAnimationType;

@class YKCalendarButton;

@protocol YKCalendarViewDelegate <NSObject>

- (void)changeCalendarViewHeightWithType:(YKCalendarViewType)type andDayViewRow:(int)row AnimationType:(YKCalendarViewAnimationType)animationType;

- (void)changeCalendarDayButtonClick:(YKCalendarButton *)dayButton;

@end

@interface YKCalendarView : UIView

@property (nonatomic, strong) NSDate *selectedDate; // 选中的date
@property (nonatomic, strong) NSDate *monthTypeAccordingDate; // 月模式显示的date
@property (nonatomic, strong) NSDate *weekTypeAccordingDate; // 星期模式显示的date
@property (nonatomic, strong) NSArray *activityDateArray;
@property (nonatomic, weak) id <YKCalendarViewDelegate> delegate;

- (instancetype)initWithDayViewHeight:(CGFloat)dayViewHeight weekLabelHeight:(CGFloat)weekLabelHeight andCalendarViewType:(YKCalendarViewType)type;
- (void)changeCalendarType:(YKCalendarViewType)type withDayViewHeight:(CGFloat)dayViewHeigth AnimationType:(YKCalendarViewAnimationType)animationType; // 改变日历的格式

@end
