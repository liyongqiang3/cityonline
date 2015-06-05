//
//  SecondaryPageController.h
//  CityEconomyOnline
//
//  Created by 季程跃 on 13-10-4.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface SecondaryPageController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_viewList;
    UIView *_leftMenuView;//左边的按钮的容器
    UIView *_seperatorView; // 分割线
    NSString *leftString; //
    NSString *navString;
    
    NSMutableArray *content;
    Videotype  _videoType;
    MBProgressHUD * hud ;
}
@property(nonatomic,strong) NSString *leftString;
@property(nonatomic,strong) NSString *navString;
@property(nonatomic,retain) NSMutableArray *content;
// 视频推荐得的类型

-(id)initWithVideoType:(Videotype)type;

@end
