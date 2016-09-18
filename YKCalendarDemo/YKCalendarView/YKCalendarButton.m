//
//  YKCalendarButton.m
//  YKCalendarDemo
//
//  Created by 易凯 on 16/9/18.
//  Copyright © 2016年 易凯. All rights reserved.
//

#import "YKCalendarButton.h"

@interface YKCalendarButton ()

@property (nonatomic, weak) UIImageView *topTinton;
@property (nonatomic, weak) UIImageView *bottomTinton;
@end

@implementation YKCalendarButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        CGFloat tintonWH = frame.size.width * 0.25;
        
        UIImageView *topTinton = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width - tintonWH, 0, tintonWH, tintonWH)];
        self.topTinton = topTinton;
        topTinton.image = [UIImage imageNamed:@"tinton"];
        topTinton.hidden = YES;
        [self addSubview:topTinton];
        
        UIImageView *bottomTinton = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width - tintonWH, frame.size.height - tintonWH, tintonWH, tintonWH)];
        self.bottomTinton = bottomTinton;
        bottomTinton.image = [UIImage imageNamed:@"tinton"];
        bottomTinton.hidden = YES;
        [self addSubview:bottomTinton];
    }
    return self;
}

- (void)setTintonHiddenWithData:(NSDictionary *)data{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:self.date];
    if (data[dateStr][@"am"]) {
        self.topTinton.hidden = NO;
    }
    if (data[dateStr][@"pm"]) {
        self.bottomTinton.hidden = NO;
    }
//    NSLog(@"self.date = %@---am =%@---pm=%@---data=%@", dateStr, data[dateStr][@"am"],data[dateStr][@"pm"],data);
}

@end
