//
//  AccountManagerController.m
//  Medical
//
//  Created by 李壮 on 2016/11/9.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "AccountManagerController.h"
#import "AccountManagerCell.h"
#import "UploadPhotoManager.h"
//日期View
#import "DatePickView.h"
//昵称
#import "NickNameController.h"
//手机号
#import "EditPhoneNumController.h"
//修改密码
#import "EditPadWordController.h"
//姓名
#import "TureNameController.h"
//登录页
#import "LogInViewController.h"

#import "NSObject+HUD.h"
//mol
#import "UserInfoBase.h"
#import "UserInfoData.h"
@interface AccountManagerController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,DatePickViewDelegate>
{
    UITableView *litab;
    DatePickView *datePick;
    NSString *nickNameStr;
    NSString *nameStr;
}
@property (nonatomic,strong)UserInfoData*data;
@end

@implementation AccountManagerController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CustomTabbarViewController*tabbar =[CustomTabbarViewController instanceTabBar];
    [tabbar hideTabbar];
    [self getUserInfoData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back.png" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:@"保存" title:@"账户管理"];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock=^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    customNavView.CustomNavRightBtnClickBlock = ^{
        [self editUserInfo];
    };
    
    [self createTable];
    [self createLogoutButton];
}

-(void)postRequestPersonalInfoUpdate
{
    NSMutableDictionary *bodyDic = [[NSMutableDictionary alloc] init];
     NSString *uid=[NSString stringWithContentsOfFile:USER_ID encoding:NSUTF8StringEncoding error:nil];
    [bodyDic setObject:uid forKey:@"uid"];
//    [bodyDic setObject:<#(nonnull id)#> forKey:@"header_pic"];
    [bodyDic setObject:uid forKey:@"nickname"];
}
- (void)createTable
{
    if (!litab) {
        litab =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64) style:UITableViewStyleGrouped];
        litab.backgroundColor =[UIColor whiteColor];
        litab.dataSource=self;
        litab.delegate=self;
        [self.view addSubview:litab];
        litab.separatorStyle=UITableViewCellSeparatorStyleNone;
        [litab registerClass:[AccountManagerCell class] forCellReuseIdentifier:@"AccountManagerCell"];
    }else{
        [litab reloadData];
    }
}
-(void)createLogoutButton
{
    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutButton.frame = CGRectMake(0, DEVICE_HEIGHT -49, DEVICE_WIDTH ,49);
    [logoutButton setTitle:@"退出账号" forState:UIControlStateNormal];
    [logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    logoutButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    logoutButton.backgroundColor = [UIColor wjColorFloat:KMedical_Blue];
    [logoutButton addTarget:self action:@selector(goBackAccount) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutButton];
}
#pragma mark-
#pragma mark-tableDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section==0?4:3;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    AccountManagerCell*cell =[tableView dequeueReusableCellWithIdentifier:@"AccountManagerCell"];
    [cell setCellContent:indexPath data:_data];
    [cell.leftBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.rightBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return F_I6_SIZE(70);
        }
        return F_I6_SIZE(45);
    }
    return F_I6_SIZE(45);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  section==0?0.1f:5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return section==0?5:0.1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section==0)
    {
        switch (indexPath.row)
        {
            case 0:{
                [self selectPhoto];
            }
                break;
            case 1:{
                EditPhoneNumController*editphoneNum=[EditPhoneNumController new];
                editphoneNum.data=_data;
                [self.navigationController pushViewController:editphoneNum animated:YES];
            }
                break;

            case 2:
            {
                NickNameController *nickVC = [NickNameController new];
                nickVC.data=_data;
                [self.navigationController pushViewController:nickVC animated:YES];
            }
                break;

            case 3:
            {
                [self.navigationController pushViewController:[EditPadWordController new] animated:YES];
            }
                break;

            default:
                break;
        }
    }else
    {
        switch (indexPath.row) {
            case 0:
            {
                TureNameController *nameVC = [TureNameController new];
                nameVC.data=_data;
                [self.navigationController pushViewController:nameVC animated:YES];
            }
                break;
            case 1:
                
                break;
            case 2:
                [self createDatePicker];
                break;
            default:
                break;
        }
    }
}
- (void)btnClick:(UIButton*)btn
{
    if (btn.tag==100)
    {
        _data.sex=@"1";
    }else{
        _data.sex=@"0";
    }
    [litab reloadData];
}
- (void)createDatePicker
{
    if (!datePick) {
        datePick =[[DatePickView alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT, DEVICE_WIDTH,F_I6_SIZE(215) )];
        datePick.delegate=self;
        datePick.cancleBtn.frame=CGRectMake(0, 0, F_I6_SIZE(50), F_I6_SIZE(25));
        datePick.sureBtn.frame=CGRectMake( DEVICE_WIDTH-F_I6_SIZE(50),0, F_I6_SIZE(50), F_I6_SIZE(25));
        [datePick.cancleBtn setTitle:@"取消" forState:0];
        [datePick.sureBtn setTitle:@"完成" forState:0];
        [datePick.sureBtn setTitleColor:[UIColor wjColorFloat:KMedical_Blue] forState:0];
        [datePick.cancleBtn setTitleColor:[UIColor grayColor] forState:0];
        [self.view addSubview:datePick];
    }
    [UIView animateWithDuration:0.5 animations:^{
        datePick.frame=CGRectMake(0, DEVICE_HEIGHT-F_I6_SIZE(215), DEVICE_WIDTH, F_I6_SIZE(215));
    }];
}
#pragma mark-
#pragma mark-datePickViewDelegate
-(void)btnIndex:(NSInteger)index date:(NSString *)str
{
    
    if (index==100) {

    }else{
        
        _data.birthday=str ;
        [litab reloadData];
    }
    [UIView animateWithDuration:0.5 animations:^{
     datePick.frame=CGRectMake(0, DEVICE_HEIGHT, DEVICE_WIDTH, F_I6_SIZE(215));
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)selectPhoto
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:0];
    UIAlertAction *Camera=[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self UIImagePickerControllerSourceType:UIImagePickerControllerSourceTypeCamera];
    }];
    UIAlertAction *PhotoLib=[UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self UIImagePickerControllerSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    }];
    UIAlertAction *cancle=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:Camera];
    [alert addAction:PhotoLib];
    [alert addAction:cancle];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}
#pragma mark UIImagePickerController代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //    在info中取出图片key可以点进去找系统提供固定的
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self uploadHeadImage:image];
}

-(void)UIImagePickerControllerSourceType:(UIImagePickerControllerSourceType)sourceType
{
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
    imagePicker.sourceType=sourceType;
    imagePicker.allowsEditing=YES;
    imagePicker.delegate=self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
#pragma mark-
#pragma mark-获取数据源
- (void)uploadHeadImage:(UIImage*)headimage
{
    NSData*data=UIImageJPEGRepresentation(headimage,1);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    // 设置时间格式
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *imageName=[str stringByAppendingFormat:@".JPEG"];
    [AFManager upLoadpath:Post_Image_URL reqBody:@{} file:data fileName:imageName fileType:@"image/jpeg" block:^(id infor)
    {
        NSLog(@"%@",infor);
        NSString *inforStr = [infor stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        NSString *inforStr2 = [inforStr stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        _data.headerPic=inforStr2;
        [litab reloadData];
    } errorBlock:^(NSError *error) {
        
    }];
    
}
//获取用户信息
- (void)getUserInfoData
{
    NSString*uid=[NSString stringWithContentsOfFile:USER_ID encoding:NSUTF8StringEncoding error:nil];
    [AFManager getReqURL:[NSString stringWithFormat:USER_INFO_RUL,uid] block:^(id infor)
     {
         if ([[infor objectForKey:@"code"]integerValue]==200) {
             UserInfoBase*base=[UserInfoBase modelObjectWithDictionary:infor];
             _data=base.data;
             [litab reloadData];
         }
     } errorblock:^(NSError *error) {
         
     }];
}
//修改用户信息
- (void)editUserInfo
{
    NSString*uid=[NSString stringWithContentsOfFile:USER_ID encoding:NSUTF8StringEncoding error:nil];
    [AFManager postReqURL:Update_PersonalInfo_URL reqBody:@{@"uid":uid,@"header_pic":_data.headerPic,@"nick_name":_data.nickName,@"sex":_data.sex,@"real_name":_data.realName,@"birthday":_data.birthday} block:^(id infor)
    {
        if ([[infor objectForKey:@"code"]integerValue]==200)
        {
            [self getUserInfoData];
            [NSObject wj_showHUDWithTip:@"保存成功"];
        }else{
            [NSObject wj_showHUDWithTip:@"保存失败"];
        }
    }];
}
#pragma mark-
#pragma mark-退出账号
- (void)goBackAccount
{
    [NSObject wj_selVcWithTitle:@"温馨提示" TitleExplain:@"确定要注销当前账号吗？" FirstSel:@"确定" SecondSel:nil SelfVc:self PresentStyle:1 FirstOrSureBlock:^(NSString *userSelStr)
    {
        if ([[NSFileManager defaultManager]removeItemAtPath:USER_ID error:nil]&&[[NSFileManager defaultManager]removeItemAtPath:RONG_USER_INFO error:nil]&&[[NSFileManager defaultManager]removeItemAtPath:RONG_TOKEN error:nil])
        {
            self.view.window.rootViewController=[[UINavigationController alloc]initWithRootViewController:[LogInViewController new]];;
        }
    } SecondSelOrCancelBlock:nil];
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
