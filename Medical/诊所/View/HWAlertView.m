//
//  HWAlertView.m
//  YeWenOwner
//
//  Created by 李壮 on 16/8/22.
//  Copyright © 2016年 李壮. All rights reserved.
//

#import "HWAlertView.h"
@interface HWAlertView ()<DatePickViewDelegate>
{
    NSTimer *timer;
    NSInteger _num;
}
@end

@implementation HWAlertView
- (id)initWithFrame:(CGRect)frame backImageFrame:(CGRect)imageRect imageName:(NSString*)imageName alertTitle:(NSString*)title
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.windowLevel = UIWindowLevelAlert;
        
        //背景遮盖
        UIView *backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        backView.backgroundColor = [UIColor blackColor];
        backView.alpha = 0.5;
        [self addSubview:backView];
        
        //弹窗背景图片
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        _imageView.frame = imageRect;
        _imageView.layer.cornerRadius=26;
        _imageView.clipsToBounds=YES;
        _imageView.center = CGPointMake(self.center.x, self.center.y);
        _imageView.contentMode = UIViewContentModeScaleToFill;
        _imageView.userInteractionEnabled = YES;
        _imageView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_imageView];
        
        //弹窗标题
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, imageRect.size.width-20, 30)];
        label.text = title;
        label.textAlignment=1;
        label.textColor=[UIColor blackColor];
        [_imageView addSubview:label];
        
        UILabel *lineLb=[[UILabel alloc]initWithFrame:CGRectMake(0, label.frame.size.height+10, imageRect.size.width, 1)];
        lineLb.backgroundColor=[UIColor grayColor];
        [_imageView addSubview:lineLb];
        
        //选项按钮
    }
    return self;
}
- (UIButton*)cancleBtn
{
    if (!_cancleBtn)
    {
        _cancleBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_cancleBtn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        _cancleBtn.tag=1994;
        [_imageView addSubview:_cancleBtn];
    }
    return _cancleBtn;
}
- (UIButton*)sureBtn
{
    if (!_sureBtn)
    {
        _sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
         [_sureBtn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        _sureBtn.tag=1993;
        [_imageView addSubview:_sureBtn];
    }
    return _sureBtn;
}
- (void)setTFNum:(NSInteger)numtf x:(CGFloat)x y:(CGFloat)y height:(CGFloat)height width:(CGFloat)width interval:(CGFloat)interval
{
    _num = numtf;
    for (NSInteger i=0; i<numtf; i++)
    {
        UITextView *TF=[[UITextView alloc]initWithFrame:CGRectMake(x, y+interval*i, height,width)];
        TF.tag=100+i;
        TF.backgroundColor =[UIColor whiteColor];
        [_imageView addSubview:TF];
    }
}
- (void)setLbNum:(NSInteger)numlb x:(CGFloat)x y:(CGFloat)y height:(CGFloat)height width:(CGFloat)width interval:(CGFloat)interval lbtitleAry:(NSArray*)titles
{
    for (NSInteger i=0; i<numlb; i++)
    {
        UILabel *lable1=[[UILabel alloc]initWithFrame:CGRectMake(x, y+interval*i, height, width)];
        lable1.text=titles[i];
        lable1.font=[UIFont systemFontOfSize:F_I6_SIZE(12)];
        [_imageView addSubview:lable1];
    }
}
- (void)show
{
    [self makeKeyAndVisible];
}

- (void)dismiss
{
    [self resignKeyWindow];
    [self removeFromSuperview];
}
- (void)btnOnClick:(UIButton*)btn
{
    if (btn.tag==1994)
    {
        [self setHidden:YES];
        [self dismiss];
    }
    else
    {
        [self finish];
    }
    
    [self endEditing:YES];
}
- (void)finish
{
    NSMutableArray *array=[NSMutableArray array];
    for (NSInteger i=0; i<_num; i++)
    {
        UITextView*TF=(UITextView*)[self viewWithTag:100+i];
        [array addObject:TF.text];
    }
    [_delegate alertView:self didSelectOptionButtonWithTag:1 TFContents:array];
}
- (DatePickView*)datePick
{
    if (!_datePick)
    {
        _datePick =[[DatePickView alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT, DEVICE_WIDTH,F_I6_SIZE(215) )];
        _datePick=[[DatePickView alloc]init];
        _datePick.delegate=self;
        _datePick.cancleBtn.frame=CGRectMake(0, 0, F_I6_SIZE(50), F_I6_SIZE(25));
        _datePick.sureBtn.frame=CGRectMake( DEVICE_WIDTH-F_I6_SIZE(50),0, F_I6_SIZE(50), F_I6_SIZE(25));
        [_datePick.cancleBtn setTitle:@"取消" forState:0];
        [_datePick.sureBtn setTitle:@"完成" forState:0];
        [_datePick.sureBtn setTitleColor:[UIColor wjColorFloat:KMedical_Blue] forState:0];
        [_datePick.cancleBtn setTitleColor:[UIColor grayColor] forState:0];
        UITextView*tf=(UITextView*)[self viewWithTag:102];
        _timeTF=tf;
        tf.inputView=_datePick;
        
    }
    return _datePick;
}

#pragma mark-
#pragma mark-Date协议方法
-(void)btnIndex:(NSInteger)index date:(NSString *)str
{
        
        if (index==100)
        {
           
        }else
        {
            _timeTF.text=str ;
        }
     [_timeTF resignFirstResponder];
}

#pragma mark -
#pragma mark 键盘下落
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}
@end
