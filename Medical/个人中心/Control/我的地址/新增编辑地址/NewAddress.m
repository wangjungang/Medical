//
//  NewAddress.m
//  YeWenOwner
//
//  Created by HOSO MAC 1 on 16/8/23.
//  Copyright © 2016年 HOSO Mac2. All rights reserved.
//

#import "NewAddress.h"

#import "CityView.h"

#import "NSString+Extend.h"


@interface NewAddress ()<UITextViewDelegate,CityViewDelegate,UITextFieldDelegate>
{
    
}
@property (nonatomic,strong)CustomNavigation *customNavView;

@end

@implementation NewAddress
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    _customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    __weak NewAddress *weakSelf=self;
    weakSelf.customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    [self initTable];
    if (!_isAdd)
    {
        [self editInfo];
    }
    
    if ([self.type isEqualToString:@"添加"]) {
        NSLog(@"添加界面");
        [_customNavView customNavLeftBtnImageName:@"back.png" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:@"  保存" title:@"设置收货地址"];
        [self.view addSubview:_customNavView];
        __weak NewAddress *weaknewadd=self;
        weaknewadd.customNavView.CustomNavRightBtnClickBlock = ^
        {
            NSLog(@"保存");
            
            UITextField *add1 = [self.view viewWithTag:100];
            UITextField *add2 = [self.view viewWithTag:101];
            UITextField *savename = [self.view viewWithTag:102];
            UITextField *mobile = [self.view viewWithTag:103];
            
            NSString *address = [[NSString alloc] init];
            //address = [NSString stringWithFormat:@"%@%@",add1.text,add2.text];
            address = add1.text;
            NSString *area = [[NSString alloc] init];
            area = add2.text;
            
            NSString *uid=[NSString stringWithContentsOfFile:USER_ID encoding:NSUTF8StringEncoding error:nil];
            if ([NSString checkTelNumber:mobile.text])
            {
                [AFManager postReqURL:AddressAdd_URL reqBody:@{@"uid":uid,@"savename":savename.text,@"mobile":mobile.text,@"address":address,@"area":area} block:^(id infor) {
                    if ([[infor objectForKey:@"code"]integerValue]==200)
                    {
                        [NSObject wj_showHUDWithTip:@"添加成功"];
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    if ([[infor objectForKey:@"code"]integerValue]==201)
                    {
                        [NSObject wj_showHUDWithTip:@"请检查网络"];
                    }
                }];
            }else
            {
                [NSObject wj_showHUDWithTip:@"手机号错误"];
            }
        };
    }
    else if ([self.type isEqualToString:@"cell"])
    {
        [_customNavView customNavLeftBtnImageName:@"back.png" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:@"  保存" title:@"详细地址"];
        [self.view addSubview:_customNavView];
        
        UITextField *add1 = [self.view viewWithTag:100];
        UITextField *add2 = [self.view viewWithTag:101];
        UITextField *savename = [self.view viewWithTag:102];
        UITextField *mobile = [self.view viewWithTag:103];
        
        
        add1.text = self.cityaddress;
        add2.text = self.detailedaddress;
        savename.text = self.namestr;
        mobile.text = self.phonestr;
        
        __weak NewAddress *weaknewadd=self;
        weaknewadd.customNavView.CustomNavRightBtnClickBlock = ^
        {
            NSLog(@"修改地址");
            UITextField *add1 = [self.view viewWithTag:100];
            UITextField *add2 = [self.view viewWithTag:101];
            UITextField *savename = [self.view viewWithTag:102];
            UITextField *mobile = [self.view viewWithTag:103];
            NSString *address = [[NSString alloc] init];
            address = [NSString stringWithFormat:@"%@%@",add1.text,add2.text];
            
            NSString *uid=[NSString stringWithContentsOfFile:USER_ID encoding:NSUTF8StringEncoding error:nil];
            
            
            if ([NSString checkTelNumber:mobile.text]) {
                NSLog(@"手机号正确");
                
                [AFManager postReqURL:AddressUpdateURL reqBody:@{@"uid":uid,@"id":self.addressid,@"savename":savename.text,@"mobile":mobile.text,@"address":address}  block:^(id infor) {
                    if ([[infor objectForKey:@"code"]integerValue]==200)
                    {
                        [NSObject wj_showHUDWithTip:@"修改成功"];
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    if ([[infor objectForKey:@"code"]integerValue]==201)
                    {
                        [NSObject wj_showHUDWithTip:@"请检查网络"];
                    }
                }];
            }
            else
            {
                [NSObject wj_showHUDWithTip:@"手机号错误"];
            }
        };
    }
}

- (void)initTable
{
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64)];
    scrollView.contentSize=CGSizeMake(DEVICE_WIDTH, DEVICE_HEIGHT-64);
    scrollView.backgroundColor= [UIColor whiteColor];
    [self.view addSubview:scrollView];
    NSArray*titleAry=@[@"收货地址",@"详细地址",@"收货人",@"手机号"];
    for (NSInteger i=0;i<4 ; i++) {
        UILabel*titleLb =[[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(10), F_I6_SIZE(17.5)+F_I6_SIZE(49)*i, F_I6_SIZE(60), F_I6_SIZE(14))];
        titleLb.textColor =[UIColor wjColorFloat:@"7f7f7f"];
        titleLb.font =[UIFont systemFontOfSize:F_I6_SIZE(14)];
        titleLb.text=titleAry[i];
        [scrollView addSubview:titleLb];
        UITextField *tf=[[UITextField alloc]initWithFrame:CGRectMake(F_I6_SIZE(70), F_I6_SIZE(17.5)+F_I6_SIZE(49)*i, DEVICE_WIDTH-F_I6_SIZE(70), F_I6_SIZE(14))];
        tf.tag=100+i;
        tf.font=[UIFont systemFontOfSize:F_I6_SIZE(14)];
        tf.delegate = self;
        
        [scrollView addSubview:tf];
        
        UITapGestureRecognizer *TapGestureTecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
        TapGestureTecognizer.cancelsTouchesInView=NO;
        [scrollView addGestureRecognizer:TapGestureTecognizer];
        
        if (i==0)
        {
            CityView*view=[[CityView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, F_I6_SIZE(225))];
            view.delegate=self;
            view.backgroundColor =[UIColor whiteColor];
            [view.cancleBtn setTitle:@"取消" forState:0];
            [view.sureBtn setTitle:@"确定" forState:0];
            [view.cancleBtn setTitleColor:[UIColor wjColorFloat:@"7f7f7f"] forState:0];
            [view.sureBtn setTitleColor:[UIColor wjColorFloat:KMedical_Blue] forState:0];
            view.cancleBtn.frame=CGRectMake(0, 0, F_I6_SIZE(50), F_I6_SIZE(25));
            view.sureBtn.frame=CGRectMake( DEVICE_WIDTH-F_I6_SIZE(50),0, F_I6_SIZE(50), F_I6_SIZE(25));
            tf.inputView=view;
        }
        if (i==1) {
            
        }
        if (i==3) {
            tf.keyboardType = UIKeyboardTypePhonePad;
        }
        
        UILabel*lineLb =[[UILabel alloc]initWithFrame:CGRectMake(0, F_I6_SIZE(49)*(i+1), DEVICE_WIDTH, F_I6_SIZE(1))];
        lineLb.backgroundColor =[UIColor wjColorFloat:@"7f7f7f"];
        [scrollView addSubview:lineLb];
    }

    
    


}
#pragma mark -
#pragma mark 修改信息
- (void)editInfo
{

}

- (void)clickSend
{

}
#pragma mark-
#pragma mark-CityViewDelegate
- (void)getBtnIndex:(NSInteger)index content:(NSString *)text
{
    if (index==101) {
        UITextField*TF=(UITextField*)[self.view viewWithTag:100];
        TF.text=text;
    }
    [self.view endEditing:YES];
}
#pragma mark -
#pragma mark 键盘下落
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
   
}

-(void)keyboardHide
{
    UITextField *add1 = [self.view viewWithTag:100];
    UITextField *add2 = [self.view viewWithTag:101];
    UITextField *savename = [self.view viewWithTag:102];
    UITextField *mobile = [self.view viewWithTag:103];
    [add1 resignFirstResponder];
    [add2 resignFirstResponder];
    [savename resignFirstResponder];
    [mobile resignFirstResponder];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
