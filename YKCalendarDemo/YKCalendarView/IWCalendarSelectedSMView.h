//
//  IWCalendarSelectedSMView.h
//  Iwanna
//
//  Created by 易凯 on 16/6/16.
//  Copyright © 2016年 Iwanna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IWCalendarSelectedSMView : UIView
- (instancetype)initWithFrame:(CGRect)frame andWeekLabelH:(CGFloat)weekLabelH dayViewH:(CGFloat)dayViewH;
@property (nonatomic, strong) NSDictionary *dict;
@end
