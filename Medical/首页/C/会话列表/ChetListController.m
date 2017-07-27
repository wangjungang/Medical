//
//  ChetListController.m
//  Medical
//
//  Created by 李壮 on 2016/11/30.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "ChetListController.h"

@interface ChetListController ()

@end

@implementation ChetListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE)]];
    [self.conversationListTableView reloadData];
}
-(void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath
{
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType = model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.title =model.conversationTitle;
    [self.navigationController pushViewController:conversationVC animated:YES];
//    RCIM*cim=[RCIM sharedRCIM];
//    cim.receiveMessageDelegate=self;
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
