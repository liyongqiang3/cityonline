//
//  SecretCityTip.h
//  CityEconomyOnline
//
//  Created by a on 13-12-4.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecretCityTip : NSObject<NSCoding>

@property (copy,nonatomic) NSString * cityName ;
@property (copy,nonatomic) NSString * cityId ;
@property (copy,nonatomic) NSString * fileUrl ;
@property (assign) BOOL isloadDid ; //  是否下载过 ；
@property (retain,nonatomic) UIImage * cityImage ;

@end
