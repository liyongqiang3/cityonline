//
//  HttpImageView.h
//  ReaddPTF
//
//  Created by a on 13-12-17.
//  Copyright (c) 2013年 liyongqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface HttpImageView : UIImageView
{
    MBProgressHUD * hud ;
    
    
}
// 加载Image 异步请求的方法
-(void)setImage:(UIImage *)image  andImageUrl:(NSString * )imageUrl;

@end
