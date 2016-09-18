//
//  YKCalendarView.m
//  YKCalendarDemo
//
//  Created by 易凯 on 16/9/18.
//  Copyright © 2016年 易凯. All rights reserved.
//

#import "YKCalendarView.h"
#import "YKCalendarTool.h"
#import "UIView+Extension.h"
#import "YKCalendarButton.h"

@interface YKCalendarView () <UIGestureRecognizerDelegate>
@property (nonatomic, assign) YKCalendarViewType type;
@property (nonatomic, strong) NSDateFormatter *formatter;
@property (nonatomic, strong) NSMutableArray *weekViweArray; // 保存表示星期label的数组
@property (nonatomic, strong) NSMutableArray *dayViweArray; // 保存表示日期button的数组
@property (nonatomic, strong) NSMutableDictionary *activityDateDict; // 保存活动日期的字典
@property (nonatomic, strong) NSArray *monthTypeStrDatas; // 月模式下显示星期的文字数组
@property (nonatomic, strong) NSArray *weekTypeStrDatas; // 星期模式下显示星期的文字数组
@property (nonatomic, assign) CGFloat childViewW; // 子控件的宽度
@property (nonatomic, assign) NSTimeInterval dayInterval; // 一天的时差
@property (nonatomic, assign) NSTimeInterval weekInterval; // 一星期的时差
@property (nonatomic, assign) NSTimeInterval monthInterval; // 一个月的时差

@property (nonatomic, strong) UIColor *monthTypeWeekLabelBGC; // 月模式下weekLabel的背景色
@property (nonatomic, strong) UIColor *weekTypeWeekLabelBGC; // 周模式下weekLabel的背景色
@property (nonatomic, strong) UIColor *monthTypeWeekLabelTextC; // 月模式下WeekLabel的文字颜色
@property (nonatomic, strong) UIColor *weekTypeWeekLabelTextC; // 周模式下WeekLabel的文字颜色
@property (nonatomic, strong) UIColor *monthTypeWeekLabelBC; // 月模式下WeekLabel的边框颜色
@property (nonatomic, strong) UIColor *weekTypeWeekLabelBC; // 周模式下WeekLabel的边框颜色
@property (nonatomic, strong) UIColor *monthTypeDayViewBGC; // 月模式下dayView的背景色
@property (nonatomic, strong) UIColor *weekTypeDayViewBGC;  // 周模式下dayView的背景色
@property (nonatomic, strong) UIColor *monthTypeDayViewTextC; // 月模式下dayView的文字颜色
@property (nonatomic, strong) UIColor *weekTypeDayViewTextC; // 周模式下dayView的文字颜色
@property (nonatomic, strong) UIColor *monthTypeDayViewBC; // 月模式下dayView的边框颜色
@property (nonatomic, strong) UIColor *weekTypeDayViewBC; // 周模式下dayView的边框颜色

@end

@implementation YKCalendarView

- (instancetype)initWithDayViewHeight:(CGFloat)dayViewHeight weekLabelHeight:(CGFloat)weekLabelHeight andCalendarViewType:(YKCalendarViewType)type{
    if (self = [super init]) {
        self.type = type;
        NSString *dateStr = [self.formatter stringFromDate:[NSDate date]];
        NSArray *dayArray = [dateStr componentsSeparatedByString:@"-"];
        NSInteger dayNum = [YKCalendarTool getDaysOfMonth:[dayArray[0] intValue] withMonth:[dayArray[1] intValue]];
        self.dayInterval = 24 * 60 * 60 * 1;
        self.weekInterval = 24 * 60 * 60 * 7;
        self.monthInterval = 24 * 60 * 60 * dayNum;
        self.childViewW = [UIScreen mainScreen].bounds.size.width / 7;
        self.selectedDate = self.weekTypeAccordingDate = self.monthTypeAccordingDate = [NSDate date]; // 月模式下的展示Data为当时时间
        int weekNum = (int)[YKCalendarTool getSpecifiedWeakdayWithDate:self.weekTypeAccordingDate];
        int fistWeekIntervalNum = abs(weekNum - 1);
        self.weekTypeAccordingDate = [NSDate dateWithTimeInterval:- (fistWeekIntervalNum * self.dayInterval) sinceDate:self.monthTypeAccordingDate];  // 周模式下的展示Data为当时时间对应该星期的星期一的时间(根据需要调整)
        if (self.type == YKCalendarViewTypeWeek) {
            self.size = CGSizeMake([UIScreen mainScreen].bounds.size.width, weekLabelHeight + dayViewHeight);
        }else if (self.type == YKCalendarViewTypeMonth) {
            NSString *dateStr = [self.formatter stringFromDate:self.monthTypeAccordingDate];
            NSArray *dayArray = [dateStr componentsSeparatedByString:@"-"];
            NSInteger dayNum = [YKCalendarTool getDaysOfMonth:[dayArray[0] intValue] withMonth:[dayArray[1] intValue]];
            NSInteger fistWeek = [YKCalendarTool getWeekOfFirstDayOfMonth:[dayArray[0] intValue] withMonth:[dayArray[1] intValue]];
            NSInteger row = [self getRowWithDayNum:dayNum FistWeek:fistWeek];
            self.size = CGSizeMake([UIScreen mainScreen].bounds.size.width, weekLabelHeight + dayViewHeight * row);
        }
        self.activityDateDict = [NSMutableDictionary dictionary];
        self.weekViweArray = [NSMutableArray array];
        self.dayViweArray = [NSMutableArray array];
        self.monthTypeStrDatas = @[@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六"];
        self.weekTypeStrDatas = @[@"一", @"二", @"三", @"四", @"五", @"六", @"日"];
        
        /**********************************凯凯各种颜色设置**********************************/
        self.monthTypeWeekLabelBGC = [UIColor redColor];
        self.weekTypeWeekLabelBGC = [UIColor whiteColor];
        self.monthTypeWeekLabelTextC = [UIColor whiteColor];
        self.weekTypeWeekLabelTextC = [UIColor blueColor];
        self.monthTypeWeekLabelBC = [UIColor blackColor];
        self.weekTypeWeekLabelBC = [UIColor clearColor];
        self.monthTypeDayViewBGC = [UIColor redColor];
        self.weekTypeDayViewBGC = [UIColor whiteColor];
        self.monthTypeDayViewTextC = [UIColor whiteColor];
        self.weekTypeDayViewTextC = [UIColor blueColor];
        self.monthTypeDayViewBC = [UIColor blackColor];
        self.weekTypeDayViewBC = [UIColor clearColor];
        /**********************************凯凯各种颜色设置**********************************/
        
        for (int i = 0; i < 7; i ++) {
            UILabel *weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(i * self.childViewW, 0, self.childViewW, weekLabelHeight)];
            weekLabel.font = [UIFont systemFontOfSize:14];
            weekLabel.textAlignment = NSTextAlignmentCenter;
            weekLabel.layer.borderWidth = 0.5;
            if (type == YKCalendarViewTypeMonth) {
                weekLabel.text = self.monthTypeStrDatas[i];
                weekLabel.backgroundColor = self.monthTypeWeekLabelBGC;
                weekLabel.textColor = self.monthTypeWeekLabelTextC;
                weekLabel.layer.borderColor = self.monthTypeWeekLabelBC.CGColor;
            }else if (type == YKCalendarViewTypeWeek){
                weekLabel.text = self.weekTypeStrDatas[i];
                weekLabel.backgroundColor = self.weekTypeWeekLabelBGC;
                weekLabel.textColor = self.weekTypeWeekLabelTextC;
                weekLabel.layer.borderColor = self.weekTypeWeekLabelBC.CGColor;
            }
            [self.weekViweArray addObject:weekLabel];
            [self addSubview:weekLabel];
        }
        
        UISwipeGestureRecognizer *recognizerRight;
        recognizerRight.delegate = self;
        recognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
        [recognizerRight setDirection:UISwipeGestureRecognizerDirectionRight];
        [self addGestureRecognizer:recognizerRight];
        
        
        UISwipeGestureRecognizer *recognizerLeft;
        recognizerLeft.delegate = self;
        recognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
        [recognizerLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
        [self addGestureRecognizer:recognizerLeft];
        if (self.type == YKCalendarViewTypeWeek) {
            [self addWeekTypeDayButtonWithTrigger:YKCalendarViewAnimationTypeNull];
        }else if (self.type == YKCalendarViewTypeMonth){
            [self addMonthTypeDayButtonWithTrigger:YKCalendarViewAnimationTypeNull];
        }
        
    }
    return self;
}

// 添加周模式日历的子控件
- (void)addWeekTypeDayButtonWithTrigger:(YKCalendarViewAnimationType)animationType{
    [self removeButtonFromeCalendarView];
    if ([self.delegate respondsToSelector:@selector(changeCalendarViewHeightWithType:andDayViewRow:AnimationType:)]) {
        [self.delegate changeCalendarViewHeightWithType:self.type andDayViewRow:1 AnimationType:animationType];
    }
    NSInteger week = [YKCalendarTool getSpecifiedWeakdayWithDate:self.weekTypeAccordingDate];
    for (int i = 0; i < 7; i ++) {
        NSDate *tempDate = [NSDate dateWithTimeInterval:self.dayInterval * (i - week + 1) sinceDate:self.weekTypeAccordingDate];
        YKCalendarButton *dayButton = [[YKCalendarButton alloc] initWithFrame:CGRectMake(i * self.childViewW, 44, self.childViewW, self.height - 44)];
        dayButton.layer.borderWidth = 0.5;
        dayButton.layer.borderColor = self.weekTypeDayViewBC.CGColor;
        [dayButton setTitle:[NSString stringWithFormat:@"%zd", [YKCalendarTool getSpecifiedDayWithDate:tempDate]] forState:UIControlStateNormal];
        [dayButton setTitleColor:self.weekTypeDayViewTextC forState:UIControlStateNormal];
        dayButton.date = tempDate;
        dayButton.backgroundColor = [UIColor blueColor];
        [dayButton addTarget:self action:@selector(dayButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        dayButton.backgroundColor = self.weekTypeDayViewBGC;
        [self.dayViweArray addObject:dayButton];
        [self addSubview:dayButton];
    }
}

// 添加月模式日历的子控件
- (void)addMonthTypeDayButtonWithTrigger:(YKCalendarViewAnimationType)animationType{
    [self removeButtonFromeCalendarView];
    NSString *dateStr = [self.formatter stringFromDate:self.monthTypeAccordingDate];
    NSArray *dayArray = [dateStr componentsSeparatedByString:@"-"];
    // 本月有多少天
    NSInteger dayNum = [YKCalendarTool getDaysOfMonth:[dayArray[0] intValue] withMonth:[dayArray[1] intValue]];
    // 本月的1号是星期几
    NSInteger fistWeek = [YKCalendarTool getWeekOfFirstDayOfMonth:[dayArray[0] intValue] withMonth:[dayArray[1] intValue]];
    NSInteger row = [self getRowWithDayNum:dayNum FistWeek:fistWeek];
    
    if ([self.delegate respondsToSelector:@selector(changeCalendarViewHeightWithType:andDayViewRow:AnimationType:)]) {
        [self.delegate changeCalendarViewHeightWithType:self.type andDayViewRow:(int)row AnimationType:animationType];
    }
    
    CGFloat childViewH = (self.height - 44) / row;
    for (int i = 0; i < 7 * row; i ++) {
        int row = i / 7;
        int loc = i % 7;
        YKCalendarButton *dayButton = [[YKCalendarButton alloc] initWithFrame:CGRectMake(loc * self.childViewW, row * childViewH + 44, self.childViewW, childViewH)];
        dayButton.layer.borderWidth = 0.5;
        dayButton.layer.borderColor = self.monthTypeDayViewBC.CGColor;
        if (i >= fistWeek && i < dayNum + fistWeek) {
            [dayButton setTitle:[NSString stringWithFormat:@"%zd", i - fistWeek + 1] forState:UIControlStateNormal];
            [dayButton setTitleColor:self.monthTypeDayViewTextC forState:UIControlStateNormal];
            [dayButton addTarget:self action:@selector(dayButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            NSString *dateStr = [NSString stringWithFormat:@"%@-%@-%02zd", dayArray[0], dayArray[1], i - fistWeek + 1];
            NSDate *date= [self.formatter dateFromString:dateStr];
            dayButton.date = date;
        }
        dayButton.backgroundColor = [UIColor blueColor];
        dayButton.backgroundColor = self.monthTypeDayViewBGC;
        [self.dayViweArray addObject:dayButton];
        [self addSubview:dayButton];
    }
}

// 从右向左滑动
- (void)swipeLeft:(UISwipeGestureRecognizer *)swipe{
    if (self.type == YKCalendarViewTypeMonth) {
        self.weekTypeAccordingDate = self.monthTypeAccordingDate = [NSDate dateWithTimeInterval:+ self.monthInterval sinceDate:self.monthTypeAccordingDate];
        NSString *dateStr = [self.formatter stringFromDate:self.weekTypeAccordingDate];
        NSArray *dayArray = [dateStr componentsSeparatedByString:@"-"];
        NSInteger dayNum = [YKCalendarTool getDaysOfMonth:[dayArray[0] intValue] withMonth:[dayArray[1] intValue]];
        self.monthInterval = 24 * 60 * 60 * dayNum;
        [self addMonthTypeDayButtonWithTrigger:YKCalendarViewAnimationTypeRight];
    }else if (self.type == YKCalendarViewTypeWeek){
        self.monthTypeAccordingDate = self.weekTypeAccordingDate = [NSDate dateWithTimeInterval:+ self.weekInterval sinceDate:self.weekTypeAccordingDate];
        [self addWeekTypeDayButtonWithTrigger:YKCalendarViewAnimationTypeRight];
    }
}

// 从左向右滑动
- (void)swipeRight: (UISwipeGestureRecognizer *)swipe{
    if (self.type == YKCalendarViewTypeMonth) {
        self.weekTypeAccordingDate = self.monthTypeAccordingDate = [NSDate dateWithTimeInterval:- self.monthInterval sinceDate:self.monthTypeAccordingDate];
        NSString *dateStr = [self.formatter stringFromDate:self.weekTypeAccordingDate];
        NSArray *dayArray = [dateStr componentsSeparatedByString:@"-"];
        NSInteger dayNum = [YKCalendarTool getDaysOfMonth:[dayArray[0] intValue] withMonth:[dayArray[1] intValue]];
        self.monthInterval = 24 * 60 * 60 * dayNum;
        [self addMonthTypeDayButtonWithTrigger:YKCalendarViewAnimationTypeLeft];
    }else if (self.type == YKCalendarViewTypeWeek){
        self.monthTypeAccordingDate = self.weekTypeAccordingDate = [NSDate dateWithTimeInterval:- self.weekInterval sinceDate:self.weekTypeAccordingDate];
        [self addWeekTypeDayButtonWithTrigger:YKCalendarViewAnimationTypeLeft];
    }
}

// 日期的button点击事件
- (void)dayButtonClick:(YKCalendarButton *)button{
    self.selectedDate = button.date;
    if ([self.delegate respondsToSelector:@selector(changeCalendarDayButtonClick:)]) {
        [self.delegate changeCalendarDayButtonClick:button];
    }
}

// 这个月应该分几行显示
- (NSInteger)getRowWithDayNum:(NSInteger)dayNum FistWeek:(NSInteger)fistWeek{
    NSInteger spareNum = fistWeek; // 前面应空出不是本月的天数
    return (dayNum + 6 + spareNum) / 7;
}

// 清除所有的button
- (void)removeButtonFromeCalendarView{
    if (self.dayViweArray.count > 0) {
        for (YKCalendarButton *dayButton in self.dayViweArray) {
            [dayButton removeFromSuperview];
        }
        [self.dayViweArray removeAllObjects];
    }
}

// 改变日历的格式
- (void)changeCalendarType:(YKCalendarViewType)type withDayViewHeight:(CGFloat)dayViewHeigth AnimationType:(YKCalendarViewAnimationType)animationType{
    self.type = type;
    int i = 0;
    switch (type) {
        case YKCalendarViewTypeWeek:
            self.weekTypeAccordingDate = self.selectedDate;
            NSLog(@"%zd", self.weekTypeStrDatas.count);
            for (UILabel *childLabel in self.weekViweArray) {
                childLabel.text = self.weekTypeStrDatas[i];
                childLabel.textColor = self.weekTypeWeekLabelTextC;
                childLabel.backgroundColor = self.weekTypeWeekLabelBGC;
                childLabel.layer.borderColor = self.weekTypeWeekLabelBC.CGColor;
                i ++;
            }
            [self addWeekTypeDayButtonWithTrigger:animationType];
            break;
        case YKCalendarViewTypeMonth:
            self.monthTypeAccordingDate = self.selectedDate;
            for (UILabel *childLabel in self.weekViweArray) {
                childLabel.text = self.monthTypeStrDatas[i];
                childLabel.textColor = self.monthTypeWeekLabelTextC;
                childLabel.backgroundColor = self.monthTypeWeekLabelBGC;
                childLabel.layer.borderColor = self.monthTypeWeekLabelBC.CGColor;
                i ++;
            }
            [self addMonthTypeDayButtonWithTrigger:animationType];
            break;
        default:
            break;
    }
}

// 判断铃铛是否应该显示的数组
- (void)setActivityDateArray:(NSArray *)activityDateArray{
    _activityDateArray = activityDateArray;
    [self.activityDateDict removeAllObjects];
    NSRange range = {0, 2};
    for (NSString *activityDateStr in activityDateArray) {
        NSArray *activityArray = [activityDateStr componentsSeparatedByString:@" "];
        NSDictionary *dict = @{activityArray[0] : [[activityArray[1] substringWithRange:range] integerValue] < 12 ? @"am" : @"pm"};
        if (self.activityDateDict[activityArray[0]]) {
            NSMutableDictionary *dict = [self.activityDateDict[activityArray[0]] mutableCopy];
            dict[[[activityArray[1] substringWithRange:range] integerValue] < 12 ? @"am" : @"pm"] = @YES;
            self.activityDateDict[activityArray[0]] = dict;
        }else{
            self.activityDateDict[activityArray[0]] = @{dict[activityArray[0]] : @YES};
        }
    }
    NSLog(@"%@", self.activityDateDict);
    for (YKCalendarButton *dayButton in self.dayViweArray) {
        [dayButton setTintonHiddenWithData:self.activityDateDict];
    }
}

- (NSDateFormatter *)formatter{
    if (!_formatter) {
        _formatter = [[NSDateFormatter alloc] init];
        _formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        _formatter.dateFormat = @"yyyy-MM-dd";
    }
    return _formatter;
}

@end
