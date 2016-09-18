//
//  IWCalendarSelectedSMView.m
//  Iwanna
//
//  Created by 易凯 on 16/6/16.
//  Copyright © 2016年 Iwanna. All rights reserved.
//

#import "IWCalendarSelectedSMView.h"
#import "YKCalendarTool.h"
#import "UIView+Extension.h"

@interface IWCalendarSelectedSMView ()

@property (nonatomic, weak) UILabel *oneLable;
@property (nonatomic, weak) UILabel *twoLable;
@property (nonatomic, strong) NSArray *weekStrDatas;

@end

@implementation IWCalendarSelectedSMView

- (instancetype)initWithFrame:(CGRect)frame andWeekLabelH:(CGFloat)weekLabelH dayViewH:(CGFloat)dayViewH{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor orangeColor];
        UILabel *oneLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, weekLabelH)];
        self.oneLable = oneLable;
        oneLable.font = [UIFont systemFontOfSize:14];
        oneLable.textColor = [UIColor whiteColor];
        oneLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:oneLable];
        
        UILabel *twoLable = [[UILabel alloc] initWithFrame:CGRectMake(0, weekLabelH, self.width, dayViewH)];
        self.twoLable = twoLable;
        twoLable.textColor = [UIColor whiteColor];
        twoLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:twoLable];
        self.weekStrDatas = @[@"一", @"二", @"三", @"四", @"五", @"六", @"日"];
    }
    return self;
}

- (void)setDict:(NSDictionary *)dict{
    _dict = dict;
    NSInteger week = [YKCalendarTool getSpecifiedWeakdayWithDate:dict[@"date"]];
    if (week == 0) {
        week = 7;
    }
    self.oneLable.text = self.weekStrDatas[week - 1];
    self.twoLable.text = self.dict[@"day"];
}

@end
