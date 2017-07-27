//
//  MyCaseController.m
//  Medical
//
//  Created by 李壮 on 2016/11/10.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "MyCaseController.h"
#import "NSString+Extend.h"
#import "LZAlertView.h"
#import "NSObject+MBProgressHUD.h"
@interface MyCaseController ()<UITextViewDelegate,UIScrollViewDelegate>
{
    UITextField*nameTF;
    UITextField*caseNameTF;
    UITextView *caseAboutTV;
    UILabel    *_palceHolderLb;
    UIScrollView *scrollView;
    UIButton *sureBtn;
    MBProgressHUD*_MB;
}
@end

@implementation MyCaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back.png" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"编辑病例"];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock=^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    self.view.backgroundColor =[UIColor whiteColor];
    [self createUI];
    if (!_isAdd) {
        [self setData];
    }
    [self notificationCenterForKeyboard];
}
- (void)createUI
{
    scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64)];
    scrollView.contentSize =CGSizeMake(DEVICE_WIDTH, DEVICE_HEIGHT-64);
    scrollView.scrollsToTop=YES;
    scrollView.delegate =self;
    [self.view addSubview:scrollView];
    
    
    
    nameTF=[[UITextField alloc]initWithFrame:CGRectMake(F_I6_SIZE(80), F_I6_SIZE(10), DEVICE_WIDTH-F_I6_SIZE(80), F_I6_SIZE(20))];
    caseNameTF=[[UITextField alloc]initWithFrame:CGRectMake(F_I6_SIZE(80), F_I6_SIZE(50), DEVICE_WIDTH-F_I6_SIZE(80), F_I6_SIZE(20))];
    caseAboutTV=[[UITextView alloc]initWithFrame:CGRectMake(F_I6_SIZE(10), F_I6_SIZE(120), DEVICE_WIDTH-F_I6_SIZE(20), F_I6_SIZE(260))];
    caseAboutTV.layer.borderColor=[Line_Color CGColor];
    caseAboutTV.layer.borderWidth=1.0f;
    UILabel *nameLb= [[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(10), 0, F_I6_SIZE(65), F_I6_SIZE(40))];
    UILabel *phoneLb= [[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(10), F_I6_SIZE(40), F_I6_SIZE(65), F_I6_SIZE(40))];
    UILabel *infoLb= [[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(10), F_I6_SIZE(80), DEVICE_WIDTH-F_I6_SIZE(10), F_I6_SIZE(40))];
    
    
    _palceHolderLb=[[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(10)   , F_I6_SIZE(6), F_I6_SIZE(200), F_I6_SIZE(26))];
    _palceHolderLb.text = @"请输入..";
    _palceHolderLb.font =[UIFont systemFontOfSize:F_I6_SIZE(16)];
    _palceHolderLb.textColor=[UIColor wjColorFloat:@"d6d6d6"];
    _palceHolderLb.enabled = NO;//lable必须设置为不可用
    _palceHolderLb.backgroundColor = [UIColor clearColor];
    
    caseAboutTV.delegate=self;
    
    infoLb.font=[UIFont systemFontOfSize:F_I6_SIZE(16)];
    nameLb.font =[UIFont systemFontOfSize:F_I6_SIZE(16)];
    phoneLb.font = [UIFont systemFontOfSize:F_I6_SIZE(16)];
    nameTF.font =[UIFont systemFontOfSize:F_I6_SIZE(16)];
    caseNameTF.font=[UIFont systemFontOfSize:F_I6_SIZE(16)];
    caseAboutTV.font =[UIFont systemFontOfSize:F_I6_SIZE(16)];
    
    nameLb.text=@"姓名";
    phoneLb.text=@"病症名称";
    infoLb.text=@"病症介绍";
    
    sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    sureBtn.frame=CGRectMake(DEVICE_WIDTH/2-F_I6_SIZE(50), caseAboutTV.frame.origin.y+F_I6_SIZE(320), F_I6_SIZE(100), F_I6_SIZE(35));
    sureBtn.backgroundColor=[UIColor wjColorFloat:KMedical_Blue];
    [sureBtn setTitle:@"保存" forState:0];
    [sureBtn addTarget:self action:@selector(clickSend) forControlEvents:UIControlEventTouchUpInside];
    
    [scrollView addSubview:nameLb];
    [scrollView addSubview:nameTF];
    [scrollView addSubview:caseNameTF];
    [scrollView addSubview:phoneLb];
    [scrollView addSubview:infoLb];
    [scrollView addSubview:caseAboutTV];
    [scrollView addSubview:sureBtn];
    [caseAboutTV addSubview:_palceHolderLb];
    
    for (NSInteger i=0; i<2; i++) {
        UILabel*lineLb =[[UILabel alloc]initWithFrame:CGRectMake(0, F_I6_SIZE(40)*(i+1), DEVICE_WIDTH, F_I6_SIZE(1))];
        lineLb.backgroundColor =Line_Color;
        [scrollView addSubview:lineLb];
    }
    
}
#pragma mark-
#pragma mark-是修改病例
- (void)setData
{
    nameTF.text=_name;
    caseNameTF.text=_caseName;
    caseAboutTV.text=_caseAbout;
    _palceHolderLb.text=@"";
}
#pragma mark-
#pragma mark-btn点击方法
- (void)clickSend
{
        if ([nameTF.text deleteSpace].length>0&&[caseNameTF.text deleteSpace].length>0&&[caseAboutTV.text deleteSpace].length>0)
        {
            NSString *uid=[NSString stringWithContentsOfFile:USER_ID encoding:NSUTF8StringEncoding error:nil];
            if (uid)
            {
                if (_isAdd)
                {
                    [self addCaseData:uid];
                }else
                {
                    [self editCaseData:uid];
                }
            }
        }else
        {
            [[LZAlertView getInstance]getAlertView:self title:@"温馨提示" messgae:@"请完善信息" alertStyle:1 cancleBtnTitle:@"我知道了"];
            [[LZAlertView getInstance]show];
        }
}
#pragma mark -
#pragma mark textView代理方法
-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0)
    {
        _palceHolderLb.text = @"请输入..";
    }else
    {
        _palceHolderLb.text = @"";
    }
    [textView flashScrollIndicators];
    
    CGFloat maxHeight =F_I6_SIZE(260);
    
    CGRect frame = textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    textView.scrollEnabled = NO;
    
    
    if (size.height > maxHeight) {
//        [UIView animateWithDuration:0.2 animations:^{
        textView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, size.height);
        sureBtn.frame=CGRectMake(DEVICE_WIDTH/2-F_I6_SIZE(50), textView.frame.origin.y+F_I6_SIZE(60)+size.height, F_I6_SIZE(100), F_I6_SIZE(35));
            scrollView.contentSize = CGSizeMake(DEVICE_WIDTH, size.height +F_I6_SIZE(215));
            scrollView.contentOffset = CGPointMake(0, size.height - maxHeight);
//        }];
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView;
{
    
}
#pragma mark-
#pragma mark-添加病例接口
- (void)addCaseData:(NSString*)uid
{
    _MB=[NSObject showHUDView:self.view MBText:@"请稍后"];
    [AFManager postReqURL:ADD_CASE_URL reqBody:@{@"uid":uid,@"user_name":nameTF.text,@"disease":caseNameTF.text,@"details":caseAboutTV.text} block:^(id infor) {
        if ([[infor objectForKey:@"code"]integerValue]==200) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [NSObject showWarning:@"操作失败" showHUDView:self.view];
        }
        [_MB hide:YES];
         _MB=nil;
    }];
   
}
- (void)editCaseData:(NSString*)uid
{
     _MB=[NSObject showHUDView:self.view MBText:@"请稍后"];
    [AFManager postReqURL:UPDATE_CASE_URL reqBody:@{@"uid":uid,@"user_name":nameTF.text,@"disease":caseNameTF.text,@"details":caseAboutTV.text,@"bid":_caseID} block:^(id infor) {
        if ([[infor objectForKey:@"code"]integerValue]==200) {
            
            [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
        }else{
             [NSObject showWarning:@"操作失败" showHUDView:self.view];
        }
         [_MB hide:YES];
        _MB=nil;
    }];
    
}
#pragma mark -
#pragma mark 键盘下落
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//获取键盘的高度并根据键盘的高度进行重新布局。
- (void)notificationCenterForKeyboard
{
    //增加监听，当键盘出现或消失时发出消息。
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyBoardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat height = keyboardRect.size.height;
    
    scrollView.frame = CGRectMake(0, 64, DEVICE_WIDTH,DEVICE_HEIGHT-height-64);
}
//当键盘退出时调用
- (void)keyBoardWillHide:(NSNotification *)aNotification
{
    scrollView.frame = CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
