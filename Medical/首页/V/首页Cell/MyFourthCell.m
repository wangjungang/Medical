//
//  MyFourthCell.m
//  YeWenOwner
//
//  Created by HOSO Mac2 on 16/8/3.
//  Copyright © 2016年 HOSO Mac2. All rights reserved.
//

#import "MyFourthCell.h"
#import "HotListData.h"
#import <SDWebImage/UIButton+WebCache.h>
//
//#import "UIImageView+WebCache.h"
@implementation MyFourthCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        // 高度必须提前赋一个值 >0
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(10 *WIDTH_SCALE, 5 *HEIGHT_SCALE, [[UIScreen mainScreen] bounds].size.width - 20 *WIDTH_SCALE, 1)];
        self.webView.backgroundColor = [UIColor clearColor];
        self.webView.opaque = NO;
        self.webView.userInteractionEnabled = NO;
        self.webView.scrollView.bounces = NO;
        self.webView.delegate = self;
        self.webView.paginationBreakingMode = UIWebPaginationBreakingModePage;
        self.webView.scalesPageToFit = YES;
        [self.contentView addSubview:self.webView];
        
        self.lineLabel = [[UILabel alloc] init];
        self.lineLabel.backgroundColor = Line_Color;
        [self.contentView addSubview:self.lineLabel];
    }
    return self;
}

-(void)createWebViewDatasource:(NSMutableArray *)dataArray indexPathRow:(NSInteger)index
{
   HealthTipsData *data = dataArray[index];
    NSString *contentStr = [self flatenHTML:data.intro];
    [_webView loadHTMLString:contentStr baseURL:nil];

}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGSize fittingSize = [self.webView sizeThatFits:CGSizeZero];
    self.height = fittingSize.height;
    _webView.frame = CGRectMake(10 *WIDTH_SCALE, 5 *HEIGHT_SCALE, fittingSize.width, fittingSize.height);
    _lineLabel.frame = CGRectMake(10 *WIDTH_SCALE, fittingSize.height - 1*HEIGHT_SCALE, DEVICE_WIDTH -2 *WIDTH_SCALE, 1 *HEIGHT_SCALE);
    // 用通知发送加载完成后的高度
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WEBVIEW_HEIGHT" object:self userInfo:nil];
}
    
- (NSString *)flatenHTML:(NSString *)html
{
    NSScanner *theScanner;
    NSString *text=@"&lt;";
    NSString *text2=@"&gt;";
    NSString *text3=@"&amp;";
    NSString *text4=@"nbsp;";
    NSString *text5=@"&quot;";
    theScanner=[NSScanner scannerWithString:html];
    while ([theScanner isAtEnd]==NO) {
        [theScanner scanUpToString:@"&lt;" intoString:NULL];
        [theScanner scanUpToString:@"&gt;" intoString:nil];
        html =[html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@",text] withString:@"<"];
        html =[html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@",text2] withString:@">"];
        html =[html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@",text3] withString:@""];
        html =[html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@",text4] withString:@""];
        html =[html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@",text5] withString:@""];
    }
    return html;
}
    
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
