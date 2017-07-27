//
//  EditPadWordController.m
//  Medical
//
//  Created by 李壮 on 2016/11/10.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "EditPadWordController.h"
#import "YString+Ext.h"
#import "NSString+Extend.h"
@interface EditPadWordController ()
{
    UIButton *codeBtn;
}
@end

@implementation EditPadWordController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back.png" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"修改密码"];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock=^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    self.view.backgroundColor =[UIColor whiteColor];
    [self createUI];
    // Do any additional setup after loading the view.
//    [NSObject ]
}
- (void)createUI
{
    NSArray*titleContent;
    if (_isReturn)
    {
        titleContent=@[@"手机号:",@"验证码:",@"新密码:",@"确认密码:"];
    }else
    {
        titleContent=@[@"手机号:",@"验证码:",@"旧密码:",@"新密码:"];
    }
    for (NSInteger i=0; i<4; i++) {
        UILabel *titleLb =[[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(10), 64+F_I6_SIZE(45)*i, F_I6_SIZE(70), F_I6_SIZE(45))];
        titleLb.font =[UIFont systemFontOfSize:F_I6_SIZE(16)];
        titleLb.textColor=[UIColor wjColorFloat:@"7f7f7f"];
        titleLb.text=titleContent[i];
        titleLb.tag = 10 +i;
        UITextField*TF=[[UITextField alloc]initWithFrame:CGRectMake(F_I6_SIZE(80), 64+F_I6_SIZE(45)*i, DEVICE_WIDTH-F_I6_SIZE(80), F_I6_SIZE(45))];
        TF.font=[UIFont systemFontOfSize:F_I6_SIZE(16)];
        TF.tag = 20 +i;
        if (i==0) {
            TF.frame=CGRectMake(F_I6_SIZE(80), 64, DEVICE_WIDTH-F_I6_SIZE(160), F_I6_SIZE(45));
        }
        if (i==2||i==3)
        {
            TF.secureTextEntry=YES;
        }
        [self.view addSubview:titleLb];
        [self.view addSubview:TF];
    }
    
    for (NSInteger i=0; i<5; i++)
    {
        UILabel*lineLb=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+F_I6_SIZE(45)*i, DEVICE_WIDTH, F_I6_SIZE(1))];
        lineLb.backgroundColor =Line_Color;
        [self.view addSubview:lineLb];
 
    }
    
    codeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    codeBtn.frame=CGRectMake(DEVICE_WIDTH-F_I6_SIZE(80),64, F_I6_SIZE(70), F_I6_SIZE(45));
    [codeBtn setTitleColor: [UIColor wjColorFloat:KMedical_Blue]forState:0];
    codeBtn.tag=100;
    [codeBtn setTitle:@"获取验证码" forState:0];
    codeBtn.titleLabel.font =[UIFont systemFontOfSize:F_I6_SIZE(14)];
    [codeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:codeBtn];
    
    UIButton *finishBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    finishBtn.frame=CGRectMake(DEVICE_WIDTH/2-F_I6_SIZE(40), F_I6_SIZE(230)+64, F_I6_SIZE(80), F_I6_SIZE(30));
    finishBtn.backgroundColor =[UIColor wjColorFloat:KMedical_Blue];
    [finishBtn setTitle:@"保存" forState:0];
    [finishBtn setTitleColor:[UIColor whiteColor] forState:0];
    finishBtn.clipsToBounds=YES;
    finishBtn.layer.cornerRadius=5;
    finishBtn.tag=101;
    [finishBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finishBtn];
}
#pragma mark-
#pragma mark-btn点击方法
- (void)btnClick:(UIButton*)btn
{
    UITextField *phoneTF = (UITextField *)[self.view viewWithTag:20];
    UITextField *pswTF = (UITextField *)[self.view viewWithTag:22];
    UITextField *againPswTF = (UITextField *)[self.view viewWithTag:23];

    NSString *strphoneNumber = phoneTF.text;
        if (btn.tag==100)
        {
            if ([strphoneNumber isValidPhoneNumber])
            {
                [self getCode];
            }else
            {
                [NSObject wj_alterSingleVCWithOneTitle:@"提示" andTwoTitle:@"请输入正确的手机号" andSelfVC:self];
            }
        }
        else if(btn.tag == 101)
        {
            if (_isReturn)
            {
                if ([[pswTF.text deleteSpace]isEqualToString:[againPswTF.text deleteSpace]]&&[pswTF.text deleteSpace].length>=6)
                {
                    [self forgetPsw];
                }
                else
                {
                    if (![[pswTF.text deleteSpace]isEqualToString:[againPswTF.text deleteSpace]])
                    {
                        [NSObject wj_showHUDWithTip:@"两次密码要一致"];
                    }else
                    {
                        [NSObject wj_showHUDWithTip:@"密码请大于等于6位"];
                    }
                }
            }else
            {
                [self postRequestUpdatePassword];
            }

        }

}
#pragma mark-
#pragma mark-获取验证码改变btn标题
static NSInteger showtime =120;
- (void)changeBtnStatus
{
    [codeBtn setEnabled:NO];
    codeBtn.frame=CGRectMake(DEVICE_WIDTH-F_I6_SIZE(100),64, F_I6_SIZE(90), F_I6_SIZE(45));
    codeBtn.titleLabel.font =[UIFont systemFontOfSize:F_I6_SIZE(12)];
    __block NSInteger timeout = showtime + 1; //倒计时时间 + 1
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                codeBtn.frame=CGRectMake(DEVICE_WIDTH-F_I6_SIZE(80),64, F_I6_SIZE(70), F_I6_SIZE(45));
                codeBtn.titleLabel.font =[UIFont systemFontOfSize:F_I6_SIZE(14)];
                codeBtn.titleLabel.text=[NSString stringWithFormat:@"获取验证码"];
                [codeBtn setTitle:@"获取验证码" forState:0];
                [codeBtn setEnabled:YES];
                showtime=120;
            });
            
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [codeBtn.titleLabel setAdjustsFontSizeToFitWidth:YES];
                codeBtn.titleLabel.text=[NSString stringWithFormat:@"%lds后重新获取",(long)timeout];
                [codeBtn setTitle:[NSString stringWithFormat:@"%lds后重新获取",(long)timeout] forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);

}
#pragma mark-
#pragma mark-获取数据源
//保存按钮//修改密码
-(void)postRequestUpdatePassword
{
    NSMutableDictionary *bodyDic = [[NSMutableDictionary alloc] init];
    NSString *uid=[NSString stringWithContentsOfFile:USER_ID encoding:NSUTF8StringEncoding error:nil];
    [bodyDic setObject:uid forKey:@"uid"];
    UITextField *codeTF = (UITextField *)[self.view viewWithTag:21];
    UITextField *oldPassTF = (UITextField *)[self.view viewWithTag:22];
    UITextField *newPassTF = (UITextField *)[self.view viewWithTag:23];
    if ([codeTF.text deleteSpace].length==0) {
        [NSObject wj_showHUDWithTip:@"验证码不能为空"];
        return;
    }else if ([oldPassTF.text deleteSpace].length==0){
        [NSObject wj_showHUDWithTip:@"密码不能为空"];
        return;
    }else if([newPassTF.text deleteSpace].length<=6){
        [NSObject wj_showHUDWithTip:@"密码不能低于六位"];
        return;
    }
    [bodyDic setObject:oldPassTF.text forKey:@"oldPass"];
    [bodyDic setObject:newPassTF.text forKey:@"newPass"];
    [bodyDic setObject:codeTF.text forKey:@"code"];
    [AFManager postReqURL:Update_Password_URL reqBody:bodyDic block:^(id infor) {
        if ([[infor objectForKey:@"code"] integerValue] == 200)
        {
            [NSObject wj_showHUDWithTip:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];

        }
        else if ([[infor objectForKey:@"code"] integerValue] == 201)
        {
            [NSObject wj_alterSingleVCWithOneTitle:nil andTwoTitle:@"旧密码不正确" andSelfVC:self];
        }
        else if ([[infor objectForKey:@"code"] integerValue] == 202)
        {
            [NSObject wj_alterSingleVCWithOneTitle:nil andTwoTitle:@"验证码错误" andSelfVC:self];
        }
    }];
}
//忘记密码
- (void)forgetPsw
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //获取本地cookie
    NSArray *arcCookies = [NSKeyedUnarchiver unarchiveObjectWithData: [userDefaults objectForKey: @"cookie"]];
    
    for (NSHTTPCookie *cookie in arcCookies){
        NSLog(@"cookie1-－－: %@", cookie);
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    }
    NSMutableDictionary *bodyDic = [[NSMutableDictionary alloc] init];
    UITextField *codeTF = (UITextField *)[self.view viewWithTag:21];
    UITextField *newPassTF = (UITextField *)[self.view viewWithTag:22];
    UITextField *mobilePassTF = (UITextField *)[self.view viewWithTag:20];
    if ([codeTF.text deleteSpace].length==0) {
        [NSObject wj_showHUDWithTip:@"验证码不能为空"];
        return;
    }else if ([newPassTF.text deleteSpace].length==0){
        [NSObject wj_showHUDWithTip:@"密码不能为空"];
        return;
    }else if(![NSString checkTelNumber:mobilePassTF.text]){
        [NSObject wj_showHUDWithTip:@"请填写正确格式的手机号"];
        return;
    }
    [bodyDic setObject:mobilePassTF.text forKey:@"mobile"];
    [bodyDic setObject:newPassTF.text forKey:@"newPass"];
    [bodyDic setObject:codeTF.text forKey:@"code"];
    [AFManager postReqURL:FORGET_PSW_URL reqBody:bodyDic block:^(id infor) {
        if ([[infor objectForKey:@"code"] integerValue] == 200)
        {
            [NSObject wj_showHUDWithTip:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        else if ([[infor objectForKey:@"code"] integerValue] == 201)
        {
            [NSObject wj_alterSingleVCWithOneTitle:nil andTwoTitle:@"验证码不正确" andSelfVC:self];
        }
        else if ([[infor objectForKey:@"code"] integerValue] == 202)
        {
            [NSObject wj_alterSingleVCWithOneTitle:nil andTwoTitle:@"修改失败" andSelfVC:self];
        }else{
            [NSObject wj_alterSingleVCWithOneTitle:nil andTwoTitle:@"用户不存在" andSelfVC:self];
        }
    }];
}
#pragma mark-获取验证码数据
- (void)getCode
{
    UITextField *phoneTF = (UITextField *)[self.view viewWithTag:20];

    AFHTTPSessionManager*manager =[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript", nil];
    
    [manager GET:[NSString stringWithFormat:CODE_URL,phoneTF.text] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSHTTPURLResponse*respone =(NSHTTPURLResponse*)task.response;
        NSString *coki=[respone.allHeaderFields[@"Set-Cookie"] componentsSeparatedByString:@";"][0];
//        [[NSUserDefaults standardUserDefaults]setObject:coki forKey:@"cookie"];
//        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject: cookiesData forKey: @"cookie"];//把获取到的cookie存储到本地
        
        if ([[responseObject objectForKey:@"code"]integerValue]==200)
        {
            [self changeBtnStatus];
        }
        else if ([[responseObject objectForKey:@"code"]integerValue]==201)
        {
            [NSObject wj_alterSingleVCWithOneTitle:nil andTwoTitle:@"验证码获取失败" andSelfVC:self];
        }
            
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [NSObject wj_alterSingleVCWithOneTitle:nil andTwoTitle:@"验证码获取失败" andSelfVC:self];
    }];
    
}
#pragma mark -
#pragma mark 键盘下落
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
