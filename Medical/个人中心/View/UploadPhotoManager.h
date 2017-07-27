//
//  UploadPhotoManager.h
//  Medical
//
//  Created by 李壮 on 2016/11/9.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploadPhotoManager : NSObject<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong)UIViewController *object;
@property (nonatomic,copy)void(^callBack)(UIImage*image);
-(instancetype)initGetObject:(id)object;
@end
