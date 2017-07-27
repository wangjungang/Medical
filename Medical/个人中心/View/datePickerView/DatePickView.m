//
//  DatePickView.m
//  Medical
//
//  Created by 李壮 on 2016/11/9.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "DatePickView.h"

@implementation DatePickView
#define PROVINCE_COMPONENT  0
#define CITY_COMPONENT      1
#define DISTRICT_COMPONENT  2
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self getDatePickerView];
    }
    return self;
}
- (UIButton*)cancleBtn
{
    if (!_cancleBtn) {
        _cancleBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_cancleBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _cancleBtn.tag=100;
        [self addSubview:_cancleBtn];
    }
    return _cancleBtn;
}
- (UIButton*)sureBtn
{
    if (!_sureBtn) {
        _sureBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _sureBtn.tag=101;
        [self addSubview:_sureBtn];
    }
    return _sureBtn;
}
- (void)getDatePickerView
{
    UIDatePicker*datePicker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0, F_I6_SIZE(25), DEVICE_WIDTH, F_I6_SIZE(190))];
    datePicker.datePickerMode=UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(oneDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:datePicker];
}
#pragma mark - 实现oneDatePicker的监听方法

- (void)oneDatePickerValueChanged:(UIDatePicker *) sender {
    
    NSDate *select = [sender date]; // 获取被选中的时间
    
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    
    selectDateFormatter.dateFormat = @"yyyy-MM-dd "; // 设置时间和日期的格式
    
    NSString *dateAndTime = [selectDateFormatter stringFromDate:select]; // 把date类型转为设置好格式的string类型
    _selectDate=dateAndTime;
}
- (void)btnClick:(UIButton*)btn
{
    if (!_selectDate)
    {
        NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
        selectDateFormatter.dateFormat = @"yyyy-MM-dd";
        _selectDate=[selectDateFormatter stringFromDate:[NSDate date]];
    }
    [_delegate btnIndex:btn.tag date:_selectDate];
}
@end
