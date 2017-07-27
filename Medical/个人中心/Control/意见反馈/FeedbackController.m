//
//  FeedbackController.m
//  Medical
//
//  Created by 李壮 on 2016/11/10.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "FeedbackController.h"
#import "FeedBackClassModel.h"
#import "FeedBackClassDataModel.h"
#import "NSObject+MBProgressHUD.h"
#define BTN_WIDTH 60
#define WIDTH     (DEVICE_WIDTH-BTN_WIDTH*4)/5
@interface FeedbackController ()<UIScrollViewDelegate>
{
    UIScrollView*scroll;
    NSInteger    btnIndex;
    UIButton *finishBtn;
    UITextView *TFView;
    NSMutableArray *btnData;
    NSString      *btnID;
    MBProgressHUD *_MB;
}
@end

@implementation FeedbackController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[CustomTabbarViewController instanceTabBar]hideTabbar];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notiFication:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back.png" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"意见反馈"];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock=^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    btnData=[NSMutableArray array];
    self.view.backgroundColor=[UIColor whiteColor];
    [self createUI];
   
}
#pragma mark-
#pragma mark-监听键盘
- (void)notiFication:(NSNotification*)notification
{
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat height = keyboardFrame.origin.y;
    
    if (TFView.frame.origin.y+F_I6_SIZE(150)>height) {
        scroll.frame=CGRectMake(0, 64, DEVICE_WIDTH, height-64);
        scroll.contentOffset=CGPointMake(0, DEVICE_HEIGHT-height);
    }else{
        scroll.frame=CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64);
    }
}
- (void)createUI
{
    scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64)];
    scroll.delegate=self;
    scroll.showsVerticalScrollIndicator=NO;
    [self.view addSubview:scroll];
    
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(10), F_I6_SIZE(10), DEVICE_WIDTH-F_I6_SIZE(10), F_I6_SIZE(20))];
    lable.text=@"您留下的每个字都将用来改善我们的服务";
    lable.font=[UIFont systemFontOfSize:F_I6_SIZE(12)];
    [scroll addSubview:lable];
//    [self getButton];
    [self getData];
}
- (void)getButton:(NSArray*)btnDatas
{
    UIButton *btn;
    [btnData addObjectsFromArray:btnDatas];
    for (NSInteger i=0; i<btnDatas.count; i++) {
        UIButton *Btn =[UIButton buttonWithType:UIButtonTypeCustom];
        Btn.frame=CGRectMake(WIDTH+(WIDTH+BTN_WIDTH)*(i%4),F_I6_SIZE(45)+(F_I6_SIZE(15)+F_I6_SIZE(20))*(i/4) , BTN_WIDTH, F_I6_SIZE(20));
        FeedBackClassDataModel*data=btnDatas[i];
        Btn.backgroundColor =[UIColor wjColorFloat:@"7f7f7f"];
        [Btn setTitle:data.typeName forState:0];
        Btn.titleLabel.font=[UIFont systemFontOfSize:F_I6_SIZE(12)];
        [Btn setTitleColor:[UIColor whiteColor] forState:0];
        Btn.clipsToBounds=YES;
        Btn.layer.cornerRadius=5;
        Btn.tag=100+i;
        [Btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [scroll addSubview:Btn];
        btn=Btn;
    }
    TFView=[[UITextView alloc]initWithFrame:CGRectMake(F_I6_SIZE(10), btn.frame.origin.y+F_I6_SIZE(30), DEVICE_WIDTH-F_I6_SIZE(20), F_I6_SIZE(150))];
    TFView.layer.borderColor=[[UIColor wjColorFloat:@"d6d6d6"]CGColor];
    TFView.layer.borderWidth=F_I6_SIZE(1);
    [scroll addSubview:TFView];
    
    finishBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    finishBtn.frame=CGRectMake(DEVICE_WIDTH/2-F_I6_SIZE(40), TFView.frame.origin.y+F_I6_SIZE(195), F_I6_SIZE(80), F_I6_SIZE(30));
    finishBtn.backgroundColor =[UIColor wjColorFloat:KMedical_Blue];
    [finishBtn setTitle:@"提交建议" forState:0];
    [finishBtn setTitleColor:[UIColor whiteColor] forState:0];
    finishBtn.titleLabel.font=[UIFont systemFontOfSize:F_I6_SIZE(16)];
    finishBtn.clipsToBounds=YES;
    finishBtn.layer.cornerRadius=5;
    [finishBtn addTarget:self action:@selector(sendFeedBack) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:finishBtn];
    CGFloat height =finishBtn.frame.origin.y+F_I6_SIZE(30)>DEVICE_HEIGHT-64?finishBtn.frame.origin.y+F_I6_SIZE(30):DEVICE_HEIGHT-63;
    scroll.contentSize=CGSizeMake(DEVICE_WIDTH, height);
}
#pragma mark-
#pragma mark-选项按钮点击方法
- (void)btnClick:(UIButton*)btn
{
    if (btnIndex==btn.tag)
    {
        return;
    }
    if (btnIndex)
    {
        UIButton*lastBtn=(UIButton*)[scroll viewWithTag:btnIndex];
        lastBtn.backgroundColor =[UIColor wjColorFloat:@"7f7f7f"];
    }
    btnIndex=btn.tag;
    FeedBackClassDataModel*data=btnData[btn.tag-100];
    btnID=data.dataIdentifier;
    btn.backgroundColor =[UIColor wjColorFloat:KMedical_Blue];
}
#pragma mark-
#pragma mark-发送建议点击方法
- (void)sendFeedBack
{
    if (btnID||TFView.text.length>0)
    {
        [self sendFeedBackInfo];
    }
   
    [self.view endEditing:YES];
}
#pragma mark-
#pragma mark-scrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
#pragma mark-
#pragma mark-获取数据
//获取分类
- (void)getData
{
    _MB=[NSObject showHUDView:self.view MBText:@"正在加载"];
    [AFManager getReqURL:FEED_BACK_CLASS_URL block:^(id infor)
    {
        if ([[infor objectForKey:@"code"]integerValue]==200) {
        FeedBackClassModel*dataBase=[FeedBackClassModel modelObjectWithDictionary:infor];
            [self getButton:dataBase.data];
        }
        [_MB hide:YES];
        _MB=nil;
    } errorblock:^(NSError *error) {
        [_MB hide:YES];
        _MB=nil;
    }];
}
- (void)sendFeedBackInfo
{
    NSString *uid=[NSString stringWithContentsOfFile:USER_ID encoding:NSUTF8StringEncoding error:nil];
    _MB=[NSObject showHUDView:self.view MBText:@"请稍后"];
    [AFManager postReqURL:FEED_BACK_ADD_URL reqBody:@{@"typeid":btnID,@"uid":uid,@"content":TFView.text} block:^(id infor) {
        if ([[infor objectForKey:@"code"]integerValue]==200) {
            TFView.text=nil;
            [NSObject showWarning:@"发送成功" showHUDView:self.view];
        }
        [_MB hide:YES];
        _MB=nil;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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
