//
//  NickNameController.m
//  Medical
//
//  Created by 李壮 on 2016/11/10.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "NickNameController.h"
#import "NSString+Extend.h"
#import "NSObject+HUD.h"
@interface NickNameController ()
{
    UITextField *nameTF;
    NSString*nickName;
}
@end

@implementation NickNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back.png" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"修改昵称"];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock=^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    self.view.backgroundColor =[UIColor whiteColor];
    [self createUI];
}
- (void)createUI
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64+F_I6_SIZE(5), DEVICE_WIDTH, F_I6_SIZE(40))];
    bgView.layer.borderColor = Line_Color.CGColor;
    bgView.layer.borderWidth = 1 *WIDTH_SCALE;
    [self.view addSubview:bgView];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60 *WIDTH_SCALE, 40 *HEIGHT_SCALE)];
    titleLabel.text = @"昵称";
    titleLabel.textColor = kCOLOR(175, 174, 175, 1) ;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:15 *WIDTH_SCALE];
    [bgView addSubview:titleLabel];
    nameTF=[[UITextField alloc]initWithFrame:CGRectMake(60 *WIDTH_SCALE, 0, DEVICE_WIDTH - 70*WIDTH_SCALE, F_I6_SIZE(40))];
    nameTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    [nameTF addTarget:self action:@selector(TFcontent:) forControlEvents:UIControlEventEditingChanged];
    nameTF.font = [UIFont systemFontOfSize:15 *WIDTH_SCALE];
    nameTF.textColor = kCOLOR(175, 174, 175, 1) ;
    nameTF.text=_data.nickName;
    [bgView addSubview:nameTF];
    
    UIButton *finishBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    finishBtn.frame=CGRectMake(DEVICE_WIDTH/2-F_I6_SIZE(40), F_I6_SIZE(230)+64, F_I6_SIZE(80), F_I6_SIZE(30));
    finishBtn.backgroundColor =[UIColor wjColorFloat:KMedical_Blue];
    [finishBtn setTitle:@"保存" forState:0];
    [finishBtn setTitleColor:[UIColor whiteColor] forState:0];
    finishBtn.clipsToBounds=YES;
    finishBtn.layer.cornerRadius=5;
    [finishBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finishBtn];

    
    UILabel*PromptLb= [[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(10), 64+F_I6_SIZE(50), DEVICE_WIDTH, F_I6_SIZE(12))];
    PromptLb.text=@"4~12个字符可以使用数字，字母，汉字";
    PromptLb.font =[UIFont systemFontOfSize:F_I6_SIZE(12)];
    PromptLb.textColor =[UIColor wjColorFloat:@"7f7f7f"];
    [self.view addSubview:PromptLb];
    nickName=_data.nickName;

}
- (void)TFcontent:(UITextField*)tf
{
    if (tf.text.length>8)
    {
        tf.text=[tf.text substringToIndex:8];
        [NSObject wj_showHUDWithTip:@"仅限输入8个字符"];
    }
}
#pragma mark-
#pragma mark-按钮点击方法
- (void)btnClick
{
    if ([nameTF.text deleteSpace].length!=0&&![nickName isEqualToString:nameTF.text] )
    {
         _data.nickName=nameTF.text;
        [self editNickName];
    }else if ([nameTF.text deleteSpace].length==0)
    {
        [NSObject wj_showHUDWithTip:@"昵称不能为空"];
    }else{
        [NSObject wj_showHUDWithTip:@"请输入要修改的昵称"];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma mark-
#pragma mark-获取数据源
- (void)editNickName
{
    NSString*uid=[NSString stringWithContentsOfFile:USER_ID encoding:NSUTF8StringEncoding error:nil];
    [AFManager postReqURL:Update_PersonalInfo_URL reqBody:@{@"uid":uid,@"header_pic":_data.headerPic,@"nick_name":_data.nickName,@"sex":_data.sex,@"real_name":_data.realName,@"birthday":_data.birthday} block:^(id infor)
     {
         if ([[infor objectForKey:@"code"]integerValue]==200)
         {
             [NSObject wj_showHUDWithTip:@"修改成功"];
             [self.navigationController popViewControllerAnimated:YES];
         }else{
             [NSObject wj_showHUDWithTip:@"修改失败"];
         }
     }];
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
