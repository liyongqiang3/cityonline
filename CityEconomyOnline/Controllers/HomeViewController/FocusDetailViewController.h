//
//  FocusDetailViewController.h
//  CityEconomyOnline
//
//  Created by a on 13-11-24.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
@interface FocusDetailViewController : UIViewController

{
    MBProgressHUD * hud ;
    NSString * detailID ; // 文章的id
    NSMutableArray * articleDetails ; // 文章详细的页面
}
@property(retain,nonatomic) UIWebView  * contentView ; //  显示 内容的 webView

//@property (strong,nonatomic) UIToolbar * toolbar ;//
@property  (assign,nonatomic)UIViewController * viewController ;

@property (retain,nonatomic) UILabel * articleTitle ; // 文章标题

@property (retain,nonatomic) UILabel * subTilte ;// 标题
// 重载初始化方法 添加id 
-(id)initWithDetailID:(NSString *)_detailID ;


@end
