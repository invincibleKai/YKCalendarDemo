//
//  ViewController.m
//  YKCalendarDemo
//
//  Created by 易凯 on 16/9/18.
//  Copyright © 2016年 易凯. All rights reserved.
//

#import "ViewController.h"
#import "YKCalendarView.h"
#import "IWCalendarSelectedView.h"
#import "IWCalendarSelectedSMView.h"
#import "YKCalendarButton.h"
#import "UIView+Extension.h"

@interface ViewController () <YKCalendarViewDelegate, UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YKCalendarView *calendarView;
@property (nonatomic, assign) YKCalendarViewType calendarViewType;
@property (nonatomic, strong) IWCalendarSelectedView *selectecView;
@property (nonatomic, strong) IWCalendarSelectedSMView *selectecSMView;
@property (nonatomic, assign) CGFloat monthTypeDayViewHeight;
@property (nonatomic, assign) CGFloat weekTypeDayViewHeight;
@property (nonatomic, assign) CGFloat weekLabelHeight;
@property (nonatomic, strong) UIButton *navigationRightButton;
@property (nonatomic, strong) NSArray *activityDateArray;
@property (nonatomic, strong) NSArray *sourceDataArray;
@end

@implementation ViewController

- (IWCalendarSelectedView *)selectecView{
    if (!_selectecView) {
        CGFloat SCREENW = [UIScreen mainScreen].bounds.size.width;
        CGFloat WH = SCREENW / 7 / 5 + SCREENW / 7;
        _selectecView = [[IWCalendarSelectedView alloc] initWithFrame:CGRectMake(0, 0, WH, WH)];
    }
    return _selectecView;
}

- (IWCalendarSelectedSMView *)selectecSMView{
    if (!_selectecSMView) {
        CGFloat SCREENW = [UIScreen mainScreen].bounds.size.width;
        _selectecSMView = [[IWCalendarSelectedSMView alloc] initWithFrame:CGRectMake(0, 0, SCREENW / 7, self.weekLabelHeight + self.weekTypeDayViewHeight) andWeekLabelH:self.weekLabelHeight dayViewH:self.weekTypeDayViewHeight];
    }
    return _selectecSMView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.monthTypeDayViewHeight = 50;
    self.weekTypeDayViewHeight = 60;
    self.weekLabelHeight = 44;
    self.calendarViewType = YKCalendarViewTypeWeek;
    self.activityDateArray = [NSArray arrayWithObjects:@"2016-07-31 00:00:00", @"2016-07-28 00:00:00", @"2016-07-23 00:00:00", @"2016-07-19 00:00:00", @"2016-07-16 00:00:00", @"2016-07-14 00:00:00", @"2016-07-14 00:00:00", @"2016-07-12 19:19:26", nil];
    self.sourceDataArray = [NSArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", nil];
    
    [self setNavigation];
    [self addCalendarView];
    [self addTableView];
}

- (void)setNavigation{
    
    self.navigationRightButton = [[UIButton alloc] init];
    [self.navigationRightButton setTitle:[self dateStringWithDate:[NSDate date] andDateType:3] forState:UIControlStateNormal];
    [self.navigationRightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.navigationRightButton sizeToFit];
    [self.navigationRightButton addTarget:self action:@selector(rightBarButtonItemClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.navigationRightButton];
}

- (void)addCalendarView{
    CGFloat height;
    if (self.calendarViewType == YKCalendarViewTypeWeek) {
        height = self.weekTypeDayViewHeight;
    }else if (self.calendarViewType == YKCalendarViewTypeMonth){
        height = self.monthTypeDayViewHeight;
    }
    self.calendarView = [[YKCalendarView alloc] initWithDayViewHeight:height weekLabelHeight:self.weekLabelHeight andCalendarViewType:self.calendarViewType];
    self.calendarView.x = 0;
    self.calendarView.y = 64;
    self.calendarView.delegate = self;
    [self.view addSubview:self.calendarView];
}

- (void)addTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.calendarView.height + 64, self.view.width, self.view.height - self.calendarView.height - 64)];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - calendarView delegate
// calendarView的模式切换和滑动都会走此方法
- (void)changeCalendarViewHeightWithType:(YKCalendarViewType)type andDayViewRow:(int)row AnimationType:(YKCalendarViewAnimationType)animationType{
    [self.selectecView removeFromSuperview];
    [self.selectecSMView removeFromSuperview];
    switch (type) {
        case YKCalendarViewTypeWeek:{
            [self.navigationRightButton setTitle:[self dateStringWithDate:self.calendarView.weekTypeAccordingDate andDateType:3] forState:UIControlStateNormal];
            [self.navigationRightButton sizeToFit];
            // 如果需要在这里加上网络请求
        }
            break;
        case YKCalendarViewTypeMonth:{
            [self.navigationRightButton setTitle:[self dateStringWithDate:self.calendarView.monthTypeAccordingDate andDateType:3] forState:UIControlStateNormal];
            [self.navigationRightButton sizeToFit];
            // 如果需要在这里加上网络请求
        }
            break;
            
        default:
            break;
    }
    
    CGFloat changeHeight;
    if (type == YKCalendarViewTypeWeek) {
        changeHeight = self.weekTypeDayViewHeight;
    }else if (type == YKCalendarViewTypeMonth){
        changeHeight = self.monthTypeDayViewHeight;
    }
    if (animationType == YKCalendarViewAnimationTypeLeft) {
        [self setAnimationWithType:kCATransitionPush SubType:kCATransitionFromLeft andFunctionName:kCAMediaTimingFunctionEaseInEaseOut];
    }else if (animationType == YKCalendarViewAnimationTypeRight) {
        [self setAnimationWithType:kCATransitionPush SubType:kCATransitionFromRight andFunctionName:kCAMediaTimingFunctionEaseInEaseOut];
    }else if (animationType == YKCalendarViewAnimationTypeOglFlip){
        [self setAnimationWithType:@"oglFlip" SubType:nil andFunctionName:kCAMediaTimingFunctionDefault];
    }
    
    self.calendarView.height = self.weekLabelHeight + changeHeight * row;
    self.tableView.y = self.calendarView.height + 64;
    self.tableView.height = self.view.height - self.calendarView.height;
}

// calendarView的日期button被点击
- (void)changeCalendarDayButtonClick:(YKCalendarButton *)dayButton{
    NSLog(@"%@",dayButton.titleLabel.text);
    // 当选中日期的时候也可以加上网络请求
    if (self.calendarViewType == YKCalendarViewTypeWeek) {
        NSDictionary *dict = @{@"date" : dayButton.date, @"day" : dayButton.titleLabel.text};
        self.selectecSMView.x = dayButton.x;
        self.selectecSMView.y = 0;
        self.selectecSMView.dict = dict;
        [self.calendarView addSubview:self.selectecSMView];
    }else{
        self.selectecView.center = dayButton.center;
        [self.selectecView.titleLabel setText:dayButton.titleLabel.text];
        [self.calendarView addSubview:self.selectecView];
    }
}

// 添加动画
- (void)setAnimationWithType:(NSString *)type SubType:(NSString *)subType andFunctionName:(NSString *)functionName{
    CATransition *animation = [CATransition animation];
    [animation setDelegate:self];
    if (type) {
        [animation setType:type];
    }
    if (subType) {
        [animation setSubtype:subType];
    }
    [animation setDuration:0.50];
    if (functionName) {
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:functionName]];
    }
    [self.calendarView.layer addAnimation:animation forKey:kCATransition];
}

- (void)rightBarButtonItemClick:(UIBarButtonItem *)item{
    CGFloat viewHeight;
    switch (self.calendarViewType) {
        case YKCalendarViewTypeWeek:
            self.calendarViewType = YKCalendarViewTypeMonth;
            viewHeight = self.monthTypeDayViewHeight;
            break;
        case YKCalendarViewTypeMonth:
            self.calendarViewType = YKCalendarViewTypeWeek;
            viewHeight = self.weekTypeDayViewHeight;
            break;
        default:
            break;
    }
    [self.calendarView changeCalendarType:self.calendarViewType withDayViewHeight:viewHeight AnimationType:YKCalendarViewAnimationTypeOglFlip];
    [self.navigationRightButton setTitle:[self dateStringWithDate:self.calendarView.selectedDate andDateType:3] forState:UIControlStateNormal];
}

// 返回date的字符串 1 为 yyyy-MM 2 为 yyyy-MM-dd 3为yyyy/MM
- (NSString *)dateStringWithDate:(NSDate *)date andDateType:(int)dayeType{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    switch (dayeType) {
        case 1:
            [dateFormatter setDateFormat:@"yyyy-MM"];
            break;
        case 2:
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            break;
        case 3:
            [dateFormatter setDateFormat:@"yyyy/MM"];
            break;
            
        default:
            break;
    }
    return [dateFormatter stringFromDate:date];
}

#pragma mark - UITableViewDelegate and UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sourceDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"YIKAI";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%@行数据", self.sourceDataArray[indexPath.row]];
    return cell;
}

@end
