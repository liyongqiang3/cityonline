//
//  HttpImageButton.m
//  CityEconomyOnline
//
//  Created by a on 14-2-13.
//  Copyright (c) 2014年 TSoftime. All rights reserved.
//

#import "HttpImageButton.h"
#import "ASIHTTPRequest.h"
@implementation HttpImageButton

@synthesize  myImage = _myImage ;

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self ;
    
}
-(void)setHttpImage:(NSString *)imageUrl  andSucceed:(void(^)())succeed  andFailed:(void(^)())failed 
{
    
    self.backgroundColor = [UIColor clearColor];
    
    
    NSURL * url = [NSURL URLWithString:imageUrl];
    __unsafe_unretained  ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        
        
        UIImage  * myImage  = [UIImage imageWithData:request.responseData];
        
        [self setImage:myImage forState:UIControlStateNormal];
        _myImage = myImage ;
        
        succeed();
//        NSLog(@"网络加载成功！");
        
        
    }];
//    NSLog(@"加载默认图片");
    
    [request startAsynchronous];
    [request setFailedBlock:^{
        
        failed ();
        
//        NSLog(@"网络加载失败！");
    }];
    
    
}
@end
