//
//  CityButton.m
//  CityEconomyOnline
//
//  Created by a on 13-11-28.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "CityButton.h"
#import "ImageRequest.h"
#define kCityHeight     207.0f
#define kCityWidth      243.0f
#define kCityTopSpace   18.0f
#define kCityBottomSpace 7
#define PDF_DOCMENT @"docment"
#import "ASIHTTPRequest.h"
#import "ReadPdfViewController.h"
@implementation CityButton
@synthesize  httpImageButton = _httpImageButton ;
@synthesize loadView = _loadView ;
@synthesize  progressBar = _progressBar ;
@synthesize titleLabel = _titleLabel ;
@synthesize viewController = _viewController ;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = RGBCOLOR(59, 58, 58);

        _httpImageButton = [[HttpImageButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _httpImageButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 54, 0);
        
        CGFloat y = frame.size.height - 54;
        _titleLabel = [CommonUtils getCustomLabelWithFrame:CGRectMake(0, y, frame.size.width, 54) text:@"" fontSize:15 textColor:nil];
//        [self addSubview:_titleLabel];
        [_httpImageButton addSubview:_titleLabel];
        [_httpImageButton addTarget:self action:@selector(loadCityData:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_httpImageButton];
        _loadView = [[UIImageView alloc]initWithFrame:CGRectMake(180, 160, 30, 30)];
        [_loadView setImage:[UIImage imageNamed:@"loaded.png"]];
        _loadView.hidden = YES ;
        [self addSubview:_loadView];
//        _loadView.hidden = YES ;
        _progressBar = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        [_progressBar setFrame:CGRectMake(100, 200, 120, 20)];
        _progressBar.hidden = YES ;
        
        [self addSubview:_progressBar];
        
        self->imagepdfArray = [[NSMutableArray alloc]init];
     
        isLoading = NO ;
        
//        _imageButtton.backgroundColor = [UIColor darkGrayColor];
    }
    return self;
}
// 设置下载阅读标识
-(void)loadImageView
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    BOOL flag =  [fileManager fileExistsAtPath:[self getPath]];
    if (flag == YES) {
        _loadView.hidden = NO ;
//        _progressBar.hidden = YES ;
    }else {
        _loadView.hidden = YES ;
//        _progressBar.hidden = NO  ;
        
    }
}
// 点击下载 关于城市的文档
-(void)loadCityData:(UIButton *)sender
{
    if (self->myImagePdf == nil) {
        return ;
    }
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
   BOOL flag = [fileManager fileExistsAtPath:[self getPath]];
    if (flag == NO) {
        
        if (isLoading == YES) {
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"正在下载" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];
            return ;
        }
        
        
        [self httpGetPdf];
        
    }
    flag = [fileManager fileExistsAtPath:[self getPath]];
    if (flag == YES) {
        
        ReadPdfViewController * myReadPdfView = [[ReadPdfViewController alloc]init];
        [myReadPdfView setImagePdf:myImagePdf];
        [_viewController presentViewController:myReadPdfView animated:YES completion:nil];
    }
    
//
//        

}

// 获得pdf的
-(void)httpGetPdf
{
    _progressBar.hidden  = NO ;
    NSURL * pdfURl = [NSURL URLWithString: self->myImagePdf.pdfUrl];
//    NSLog(@"%@",self->myImagePdf.pdfUrl);
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:pdfURl];
//    NSLog(@"%@",[self getPath]);
    
    isLoading = YES ;
    
    [request  setDownloadDestinationPath:[self getPath]];
    [request setDownloadProgressDelegate:_progressBar];
    [request setCompletionBlock:^{
        ReadPdfViewController * myReadPdfView = [[ReadPdfViewController alloc]init];
        [myReadPdfView setImagePdf:myImagePdf];
        [_viewController presentViewController:myReadPdfView animated:YES completion:nil];

        _progressBar.hidden  = YES ;
        
//        [_loadView setImage:[UIImage imageNamed:@"read.png"]];
        isLoading = NO ;
        
        _loadView.hidden = NO ;
        NSLog(@"下载成功 !");
    }]; 
    [request startAsynchronous];
    
    [request setFailedBlock:^{
        NSLog(@"下载失败！");
        isLoading = NO ;
    }];
//    request
//    request
}
//得到沙河路径
-(NSString * )getPath
{
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
   path =  [path stringByAppendingFormat:@"/%@%@.pdf",PDF_DOCMENT,myImagePdf.pdfId];
    return path ;
}
-(void)setSecretCityTip:(ImagePdf *)imagePdf
{
    self->myImagePdf = imagePdf ;
//    [_imageButtton setImage:imagePdf.image forState:UIControlStateNormal];
    [_httpImageButton setHttpImage:imagePdf.iamgeUrl andSucceed:^{
        
    } andFailed:^{
        
        
    }]  ;
     
    _titleLabel.text =  imagePdf.pdfName ;
    [self loadImageView];
    
    
    
}




@end
