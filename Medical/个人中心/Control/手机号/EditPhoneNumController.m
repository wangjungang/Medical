//
//  EditPhoneNumController.m
//  Medical
//
//  Created by 李壮 on 2016/11/10.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "EditPhoneNumController.h"
#import "NSString+Extend.h"
#import "NSObject+HUD.h"
@interface EditPhoneNumController ()
{
    UIButton *codeBtn;
}
@end

@implementation EditPhoneNumController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back.png" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"修改手机号"];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock=^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    self.view.backgroundColor =[UIColor whiteColor];
    [self createUI];
}
- (void)createUI
{
    NSArray*titleContent=@[@"登录密码:",@"手机号:",@"验证码:"];
    for (NSInteger i=0; i<3; i++) {
        UILabel *titleLb =[[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(16), 64+F_I6_SIZE(45)*i, F_I6_SIZE(70), F_I6_SIZE(45))];
        titleLb.font =[UIFont systemFontOfSize:F_I6_SIZE(16)];
//        titleLb.backgroundColor = [UIColor redColor];
        titleLb.textColor=[UIColor wjColorFloat:@"7f7f7f"];
        titleLb.text=titleContent[i];
        
        UITextField*TF=[[UITextField alloc]initWithFrame:CGRectMake(F_I6_SIZE(90), 64+F_I6_SIZE(45)*i, DEVICE_WIDTH-F_I6_SIZE(90), F_I6_SIZE(45))];
        TF.tag=100+i;
        TF.font=[UIFont systemFontOfSize:F_I6_SIZE(16)];
        if (i==1) {
            TF.frame=CGRectMake(F_I6_SIZE(90), 64+F_I6_SIZE(45), DEVICE_WIDTH-F_I6_SIZE(170), F_I6_SIZE(45));
        }
        if (i==0) {
            TF.secureTextEntry=YES;
        }
        [self.view addSubview:titleLb];
        [self.view addSubview:TF];
    }
    
    for (NSInteger i=0; i<4; i++) {
        UILabel*lineLb=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+F_I6_SIZE(45)*i, DEVICE_WIDTH, F_I6_SIZE(1))];
        lineLb.backgroundColor =Line_Color;
        [self.view addSubview:lineLb];
    }
    
    
    
    codeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    codeBtn.frame=CGRectMake(DEVICE_WIDTH-F_I6_SIZE(80),64+F_I6_SIZE(45), F_I6_SIZE(70), F_I6_SIZE(45));
    [codeBtn setTitleColor:[UIColor wjColorFloat:KMedical_Blue]forState:0];
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
    if (btn.tag==100)
    {
        [self getCode];
    }else
    {
        UITextField*pasword=(UITextField*)[self.view viewWithTag:100];
        UITextField*phone=(UITextField*)[self.view viewWithTag:101];
        UITextField*code =(UITextField*)[self.view viewWithTag:102];
        if ([pasword.text deleteSpace].length>0&&[phone.text deleteSpace].length>0&&[code.text deleteSpace].length>0&&![_data.mobile isEqualToString:phone.text])
        {
            [self editPhoneNum:phone.text code:code.text password:pasword.text];
        }else if ([_data.mobile isEqualToString:phone.text]){
            [NSObject wj_showHUDWithTip:@"该手机号已经绑定"];
        }else{
            [NSObject wj_showHUDWithTip:@"请完善信息"];
        }
    }
}
static NSInteger showtime =120;
- (void)changeBtnStatus
{
    [codeBtn setEnabled:NO];
    codeBtn.frame=CGRectMake(DEVICE_WIDTH-F_I6_SIZE(100),64+F_I6_SIZE(45), F_I6_SIZE(90), F_I6_SIZE(45));
    codeBtn.titleLabel.font =[UIFont systemFontOfSize:F_I6_SIZE(12)];
    __block NSInteger timeout = showtime + 1; //倒计时时间 + 1
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                codeBtn.frame=CGRectMake(DEVICE_WIDTH-F_I6_SIZE(80),64+F_I6_SIZE(45), F_I6_SIZE(70), F_I6_SIZE(45));
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
- (void)getCode
{
    UITextField*phoneTF=(UITextField*)[self.view viewWithTag:101];
    
    AFHTTPSessionManager*manager =[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript", nil];
    
    [manager GET:[NSString stringWithFormat:CODE_URL,phoneTF.text] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse*respone =(NSHTTPURLResponse*)task.response;
        NSString *coki=[respone.allHeaderFields[@"Set-Cookie"] componentsSeparatedByString:@";"][0];
        [[NSUserDefaults standardUserDefaults]setObject:coki forKey:@"cookie"];
        [self changeBtnStatus];
        [[NSUserDefaults standardUserDefaults]synchronize];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [NSObject wj_showHUDWithTip:@"获取失败"];
    }];
}
- (void)editPhoneNum:(NSString*)phoneNum code:(NSString*)codeStr password:(NSString*)password
{
   NSString*uid=[NSString stringWithContentsOfFile:USER_ID encoding:NSUTF8StringEncoding error:nil];
    AFHTTPSessionManager*manager =[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript", nil];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString*cookie=[[NSUserDefaults standardUserDefaults]objectForKey:@"cookie"];
    [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    
    [manager POST:EDIT_PHONE_URL parameters:@{@"uid":uid,@"newPhone":phoneNum,@"code":codeStr,@"password":password} progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         id dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
         if ([[dic objectForKey:@"code"]integerValue]==200) {
             [self.navigationController popViewControllerAnimated:YES];
         }else if([[dic objectForKey:@"code"]integerValue]==202){
             [NSObject wj_showHUDWithTip:@"登录密码输入有误"];
         }else{
             [NSObject wj_showHUDWithTip:@"验证码输入有误"];

         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [NSObject wj_showHUDWithTip:@"请求失败"];
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
