//
//  UploadPhotoManager.m
//  Medical
//
//  Created by 李壮 on 2016/11/9.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "UploadPhotoManager.h"

@implementation UploadPhotoManager
#pragma mark -
#pragma mark 选取头像
//
-(instancetype)initGetObject:(id)object
{
    self=[super init];
    if (self)
    {
        _object=object;
        [self selectPhoto];
    }
    return self;
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
    UIAlertAction *cancle=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:Camera];
    [alert addAction:PhotoLib];
    [alert addAction:cancle];
    [_object presentViewController:alert animated:YES completion:^{
        
    }];
}
#pragma mark UIImagePickerController代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //    在info中取出图片key可以点进去找系统提供固定的
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [_object dismissViewControllerAnimated:YES completion:nil];
    _callBack(image);
}
-(void)UIImagePickerControllerSourceType:(UIImagePickerControllerSourceType)sourceType
{
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
    imagePicker.sourceType=sourceType;
    imagePicker.allowsEditing=YES;
    imagePicker.delegate=self;
    [_object presentViewController:imagePicker animated:YES completion:nil];
}

@end
