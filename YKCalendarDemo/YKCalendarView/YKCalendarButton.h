//
//  YKCalendarButton.h
//  YKCalendarDemo
//
//  Created by 易凯 on 16/9/18.
//  Copyright © 2016年 易凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKCalendarButton : UIButton
@property (nonatomic, strong) NSDate *date;
- (void)setTintonHiddenWithData:(NSDictionary *)data;
@end
