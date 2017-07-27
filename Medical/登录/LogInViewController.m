//
//  LogInViewController.m
//  Medical
//
//  Created by 李壮 on 2016/11/7.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "LogInViewController.h"
#import "RegisterViewController.h"
#import "NSString+Extend.h"
#import "LZAlertView.h"
#import "NSObject+MBProgressHUD.h"
//
#import "EditPadWordController.h"
@interface LogInViewController ()
{
    UITextField *userName;
    UITextField *pasword;
    MBProgressHUD*_MB;
}
@end

@implementation LogInViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden =YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (![[NSFileManager defaultManager]fileExistsAtPath:FIRST_LOADING_PATH])
    {
        NSString *text=@"已经启动";
        [text writeToFile:FIRST_LOADING_PATH atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }

    self.view.backgroundColor=[UIColor wjColorFloat:@"13cace"];
    [self createUI];
}
- (void)createUI
{
    UIButton *logInBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [logInBtn setTitle:@"登录" forState:UIControlStateNormal];
    logInBtn.frame=CGRectMake(DEVICE_WIDTH/2-F_I6_SIZE(111/2), F_I6_SIZE(784/2), F_I6_SIZE(111), F_I6_SIZE(34));
    logInBtn.clipsToBounds=YES;
    logInBtn.layer.cornerRadius=5;
    logInBtn.backgroundColor =[UIColor wjColorFloat:@"007679"];
    [logInBtn setTitleColor:[UIColor wjColorFloat:@"ffffff"] forState:0];
    logInBtn.titleLabel.font=[UIFont systemFontOfSize:F_I6_SIZE(20)];
    [logInBtn addTarget:self action:@selector(logIn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logInBtn];
    
    
    
    UILabel *line =[[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(136/2), F_I6_SIZE(491/2), DEVICE_WIDTH-F_I6_SIZE(136), 1)];
    UILabel *line2= [[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(136/2), line.frame.origin.y+F_I6_SIZE(50), DEVICE_WIDTH-F_I6_SIZE(136), 1)];
    line.backgroundColor = [UIColor whiteColor];
    line2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:line];
    [self.view addSubview:line2];
    
    UIImageView *phoneIm=[[UIImageView alloc]initWithFrame:CGRectMake(F_I6_SIZE(136/2), F_I6_SIZE(427/2), F_I6_SIZE(25/2), F_I6_SIZE(42/2))];
    UIImageView *pswword=[[UIImageView alloc]initWithFrame:CGRectMake(F_I6_SIZE(136/2), line2.frame.origin.y-F_I6_SIZE(62/2), F_I6_SIZE(33/2), F_I6_SIZE(42/2))];
    phoneIm.image =[UIImage imageNamed:@"Shape-32.png"];
    pswword.image =[UIImage imageNamed:@"Shape-348.png"];
    [self.view addSubview:phoneIm];
    [self.view addSubview:pswword];
    
    userName = [[UITextField alloc]initWithFrame:CGRectMake(F_I6_SIZE(136/2+30),line.frame.origin.y-31, DEVICE_WIDTH-F_I6_SIZE(136+30), 30)];
    userName.placeholder =@"手机号";
    [userName setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:userName];
    pasword =[[UITextField alloc]initWithFrame:CGRectMake(F_I6_SIZE(136/2+30), line2.frame.origin.y-31, DEVICE_WIDTH-F_I6_SIZE(136+30), 30)];
    pasword.placeholder=@"密码";
    pasword.secureTextEntry=YES;
     [pasword setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:pasword];

    UIButton *registeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [registeBtn setTitle:@"注册" forState:0];
    registeBtn.frame=CGRectMake(DEVICE_WIDTH-F_I6_SIZE(78/2)-50,line2.frame.origin.y+F_I6_SIZE(22) , 50, 50);
    [registeBtn setTitleColor:[UIColor wjColorFloat:@"ffffff"] forState:0];
    registeBtn.titleLabel.font=[UIFont systemFontOfSize:F_I6_SIZE(15)];
    [registeBtn addTarget:self action:@selector(pushRegist) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registeBtn];
    
    UIButton *forgetPwBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [forgetPwBtn setTitle:@"忘记密码" forState:0];
    forgetPwBtn.frame=CGRectMake(F_I6_SIZE(136/2),line2.frame.origin.y+F_I6_SIZE(22) , 60, 50);
    [forgetPwBtn setTitleColor:[UIColor wjColorFloat:@"ffffff"] forState:0];
    forgetPwBtn.titleLabel.font=[UIFont systemFontOfSize:F_I6_SIZE(15)];
    [forgetPwBtn addTarget:self action:@selector(forgetPw) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPwBtn];

}
//找回密码
- (void)forgetPw
{
    EditPadWordController*editC=[EditPadWordController new];
    editC.isReturn=YES;
    [self.navigationController pushViewController:editC animated:YES];
}
//注册
- (void)pushRegist
{
    [self.navigationController pushViewController:[RegisterViewController new] animated:YES];
}
#pragma mark-
#pragma mark-获取数据源
- (void)getData
{
    _MB=[NSObject showHUDView:self.view MBText:nil];
    [AFManager postReqURL:LOG_IN_URL reqBody:@{@"mobile":userName.text,@"password":pasword.text} block:^(id infor) {
        if ([[infor objectForKey:@"code"]integerValue]==200) {
            if ([[infor objectForKey:@"uid"] writeToFile:USER_ID atomically:YES encoding:NSUTF8StringEncoding error:nil])
            {
               self.view.window.rootViewController=[CustomTabbarViewController instanceTabBar];
            }
            
        }else{
            [NSObject showWarning:@"登录失败" showHUDView:self.view];
        }
        [_MB hide:YES];
        _MB=nil;
    }];
    
}
- (void)logIn
{
    if ([userName.text deleteSpace].length>0&&[pasword.text deleteSpace].length>0)
    {
        [self getData];
    }else
    {
        if ([userName.text deleteSpace].length==0) {
            [[LZAlertView getInstance]getAlertView:self title:@"温馨提示" messgae:@"用户名不能为空" alertStyle:1 cancleBtnTitle:@"我知道了"];
            [[LZAlertView getInstance]show];
        }else{
            [[LZAlertView getInstance]getAlertView:self title:@"温馨提示" messgae:@"密码不能为空" alertStyle:1 cancleBtnTitle:@"我知道了"];
            [[LZAlertView getInstance]show];
        }
    }
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
