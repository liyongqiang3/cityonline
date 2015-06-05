//
//  VideoDetail.h
//  CityEconomyOnline
//
//  Created by a on 13-12-6.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoDetail : NSObject
@property (copy,nonatomic) NSString * videoId ;

@property (copy,nonatomic) NSString * title ;

@property (copy,nonatomic) NSString * filePath ;

@property (copy,nonatomic) NSString * picturepath ;

@property (copy,nonatomic) NSString * createDate ;

@property (copy,nonatomic) NSString * update ;

//@property (copy,nonatomic) NSString * landscapetype

@property (copy,nonatomic) NSString * cityId ;

@property (copy,nonatomic) NSString * usagetype ;

@property (copy,nonatomic) NSString * desp ;

@property (copy,nonatomic) NSString * subtiltle ;

@end
