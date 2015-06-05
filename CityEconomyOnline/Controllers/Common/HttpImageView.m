//
//  HttpImageView.m
//  ReaddPTF
//
//  Created by a on 13-12-17.
//  Copyright (c) 2013年 liyongqiang. All rights reserved.
//

#import "HttpImageView.h"
#import "ASIHTTPRequest.h"
@implementation HttpImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
// 加载Image 异步请求的方法
-(void)setImage:(UIImage *)image  andImageUrl:(NSString * )imageUrl
{
//    [self setImage:image];
    self.backgroundColor = [UIColor blackColor];
    hud = [[MBProgressHUD alloc]init];
    [self addSubview:hud];
    [hud show:YES];
    NSURL * url = [NSURL URLWithString:imageUrl];
     __unsafe_unretained  ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        [hud hide:YES];
        [hud removeFromSuperview];
        
        
        UIImage  * myImage  = [UIImage imageWithData:request.responseData];
      
        [self setImage:myImage];
        NSLog(@"网络加载成功！");

        
    }];
    NSLog(@"加载默认图片");
    
    [request startAsynchronous];
    [request setFailedBlock:^{
        
        NSLog(@"网络加载失败！");
    }];
    
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
