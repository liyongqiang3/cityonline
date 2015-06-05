//
//  ReadPdfViewController.h
//  CityEconomyOnline
//
//  Created by a on 13-12-14.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuickLook/QuickLook.h>
#import "ImagePdf.h"
@interface ReadPdfViewController : UIViewController
{
    ImagePdf  * imagePdf ;   //  pdf  类型 
    
}
//@property (retain,nonatomic) QLPreviewController * previewController ;

@property (retain,nonatomic) UIWebView * webView ;
-(void)setImagePdf:(ImagePdf *)_imagePdf ;

@end
