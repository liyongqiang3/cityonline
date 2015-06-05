//
//  ImagePdf.h
//  CityEconomyOnline
//
//  Created by a on 13-12-11.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImagePdf : NSObject
@property (copy,nonatomic) NSString * pdfId ;

//@property (copy,nonatomic) NSString * pathUrl ;

@property (copy,nonatomic) NSString * pdfName ;

@property (copy,nonatomic) NSString * desp ;

@property (copy,nonatomic) NSString * iamgeUrl ;

@property (copy,nonatomic) NSString * pdfUrl ;

@property (retain,nonatomic) UIImage * image  ;


@end
