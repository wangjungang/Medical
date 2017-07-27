//
//  RegisterViewController.m
//  Medical
//
//  Created by 李壮 on 2016/11/7.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "RegisterViewController.h"
#import "NSString+Extend.h"
#import "LZAlertView.h"
#import "NSObject+MBProgressHUD.h"
@interface RegisterViewController ()
{
    UITextField *phoneTF;
    UITextField *paswordTF;
    UITextField *codeTF;
    UITextField *againPaswordTF;
    MBProgressHUD*_MB;
}
@end

@implementation RegisterViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back.png" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"注册"];
    [customNavView setRightBtnFrame:CGRectMake(DEVICE_WIDTH - 20 *WIDTH_SCALE - 15 *WIDTH_SCALE, 32, 25, 20)];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    self.view.backgroundColor=[UIColor wjColorFloat:KMedical_Blue];
    [self createUI];
}
- (void)createUI
{
    UIImageView*backImage= [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64)];
    backImage.image=[UIImage imageNamed:@"注册.png"];
    [self.view addSubview:backImage];
    
    phoneTF = [[UITextField alloc]init];
    phoneTF.frame=CGRectMake(F_I6_SIZE(109/2), F_I6_SIZE(234/2), DEVICE_WIDTH-F_I6_SIZE(109), F_I6_SIZE(74/2));
    phoneTF.backgroundColor=[UIColor whiteColor];
    phoneTF.placeholder=@"请输入手机号";
    phoneTF.keyboardType=UIKeyboardTypeNumberPad;
    codeTF =[[UITextField alloc]init];
    codeTF.frame=CGRectMake(F_I6_SIZE(109/2), F_I6_SIZE((234+74+43)/2), DEVICE_WIDTH-F_I6_SIZE(109+105), F_I6_SIZE(74/2));
    codeTF.backgroundColor=[UIColor whiteColor];
    codeTF.placeholder=@"请填写验证码";
    paswordTF=[[UITextField alloc]init];
    paswordTF.frame=CGRectMake(F_I6_SIZE(109/2), F_I6_SIZE((234+74+43+74+43)/2), DEVICE_WIDTH-F_I6_SIZE(109), F_I6_SIZE(74/2));
    paswordTF.backgroundColor =[UIColor whiteColor];
    paswordTF.placeholder=@"请输入密码";
    paswordTF.secureTextEntry=YES;
    againPaswordTF=[[UITextField alloc]init];
     againPaswordTF.frame=CGRectMake(F_I6_SIZE(109/2), F_I6_SIZE((234+74+43+74+43+74+43)/2), DEVICE_WIDTH-F_I6_SIZE(109), F_I6_SIZE(74/2));
    againPaswordTF.backgroundColor=[UIColor whiteColor];
    againPaswordTF.placeholder=@"确认密码";
    againPaswordTF.secureTextEntry=YES;
    [self.view addSubview:phoneTF];
    [self.view addSubview:codeTF];
    [self.view addSubview:paswordTF];
    [self.view addSubview:againPaswordTF];
    
    UIButton *finishBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [finishBtn setTitle:@"完成" forState:0];
    finishBtn.clipsToBounds=YES;
    finishBtn.layer.cornerRadius=5;
    finishBtn.frame=CGRectMake(DEVICE_WIDTH/2-F_I6_SIZE(111/2), F_I6_SIZE(784/2), F_I6_SIZE(111), F_I6_SIZE(34));
    [finishBtn setTintColor:[UIColor whiteColor]];
    finishBtn.titleLabel.font=[UIFont systemFontOfSize:F_I6_SIZE(20)];
    finishBtn.backgroundColor =[UIColor wjColorFloat:@"007679"];
    [finishBtn addTarget:self action:@selector(registeBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finishBtn];
    
    UIButton *getCodeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [getCodeBtn setTitle:@"获取验证码" forState:0];
    getCodeBtn.tag=100;
    [getCodeBtn addTarget:self action:@selector(changeBtn:) forControlEvents:UIControlEventTouchUpInside];
    getCodeBtn.backgroundColor =[UIColor whiteColor];
    getCodeBtn.frame=CGRectMake(codeTF.frame.origin.x+codeTF.frame.size.width+F_I6_SIZE(7), F_I6_SIZE((234+74+43)/2),F_I6_SIZE(196/2), F_I6_SIZE(74/2));
    getCodeBtn.titleLabel.font=[UIFont systemFontOfSize:F_I6_SIZE(15)];
    [getCodeBtn setTitleColor:[UIColor wjColorFloat:KMedical_Blue] forState:0];
    [self.view addSubview:getCodeBtn];
    
}
#pragma mark-
#pragma -注册按钮--
- (void)registeBtn
{
    if ([againPaswordTF.text isEqualToString:paswordTF.text])
    {
        if ([paswordTF.text deleteSpace].length>3&&[phoneTF.text deleteSpace].length>0)
        {
            [self RegisterAF];
        }else
        {
            if ([phoneTF.text deleteSpace].length==0)
            {
                [self alertView:@"请输入手机号"];
            }else
            {
                [self alertView:@"密码要大于3位"];

            }
        }
    }else
    {
        [self alertView:@"两次密码要一致"];
    }
}
- (void)alertView:(NSString*)str
{
    UIAlertController*alert =[UIAlertController alertControllerWithTitle:@"温馨提示" message:str preferredStyle:1];
    UIAlertAction*sure =[UIAlertAction actionWithTitle:@"我知道了" style:0 handler:nil];
    [alert addAction:sure];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark-
#pragma mark-获取验证码
static NSInteger showtime =120;
- (void)changeBtn:(UIButton*)btn
{
    if ([NSString checkTelNumber:phoneTF.text] )
    {
        [self getCode];
    }
}
#pragma mark-
#pragma mark-获取验证码数据
- (void)getCode
{
    
    AFHTTPSessionManager*manager =[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript", nil];
    
    [manager GET:[NSString stringWithFormat:CODE_URL,phoneTF.text] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSHTTPURLResponse*respone =(NSHTTPURLResponse*)task.response;
        NSLog(@"cooki===%@===",respone.allHeaderFields[@"Set-Cookie"]);
        NSString *coki=[respone.allHeaderFields[@"Set-Cookie"] componentsSeparatedByString:@";"][0];
        [[NSUserDefaults standardUserDefaults]setObject:coki forKey:@"cookie"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self changeBtnStatus];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"=====/n%@",error);
    }];
    
}
- (void)RegisterAF
{
    _MB=[NSObject showHUDView:self.view MBText:@"请稍后"];
    AFHTTPSessionManager*manager =[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript", nil];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString*cookie=[[NSUserDefaults standardUserDefaults]objectForKey:@"cookie"];
    [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    
    [manager POST:REGISTER_URL parameters:@{@"mobile":phoneTF.text,@"password":paswordTF.text,@"code":codeTF.text} progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         id dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
         if ([[dic objectForKey:@"code"]integerValue]==200) {
             [AFManager postReqURL:LOG_IN_URL reqBody:@{@"mobile":phoneTF.text,@"password":paswordTF.text} block:^(id infor)
             {
                 if ([[infor objectForKey:@"code"]integerValue]==200)
                 {
                     [[infor objectForKey:@"uid"] writeToFile:USER_ID atomically:YES encoding:NSUTF8StringEncoding error:nil];
                     self.view.window.rootViewController=[CustomTabbarViewController instanceTabBar];
                 }
             }];
         }else{
             [NSObject showWarning:@"注册失败" showHUDView:self.view];
         }
         [_MB hide:YES];
         _MB=nil;
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          [_MB hide:YES];
          _MB=nil;
     }];
}
- (void)changeBtnStatus
{
    UIButton*btn=(UIButton*)[self.view viewWithTag:100];
    [btn setEnabled:NO];
    
    btn.titleLabel.font=[UIFont systemFontOfSize:F_I6_SIZE(12)];
    __block NSInteger timeout = showtime + 1; //倒计时时间 + 1
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                btn.titleLabel.font=[UIFont systemFontOfSize:F_I6_SIZE(15)];
                btn.titleLabel.text=[NSString stringWithFormat:@"获取验证码"];
                [btn setTitle:@"获取验证码" forState:0];
                [btn setEnabled:YES];
                showtime=120;
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [btn.titleLabel setAdjustsFontSizeToFitWidth:YES];
                btn.titleLabel.text=[NSString stringWithFormat:@"%lds后重新获取",(long)timeout];
                [btn setTitle:[NSString stringWithFormat:@"%lds后重新获取",(long)timeout] forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
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
