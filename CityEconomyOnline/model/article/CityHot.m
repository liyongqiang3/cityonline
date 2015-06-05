//
//  CityHot.m
//  CityEconomyOnline
//
//  Created by a on 13-12-2.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "CityHot.h"

@implementation CityHot

@synthesize cityHotID = _cityHotID ;

@synthesize  cityHotTitle = _cityHotTitle ;

@synthesize  imagePath = _imagePath ;

@synthesize  image = _image ;
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self  = [super init];
    if (self) {
        _cityHotID = [aDecoder decodeObjectForKey:@"_cityHotID"];
        _cityHotTitle = [aDecoder decodeObjectForKey:@"_cityHotTitle"];
        _imagePath = [aDecoder decodeObjectForKey:@"_imagePath"];
        _image = [aDecoder decodeObjectForKey:@"_image"];
        
    }
    return self ;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_cityHotID forKey:@"_cityHotID"];
    [aCoder encodeObject:_cityHotTitle forKey:@"_cityHotTitle"];
    [aCoder encodeObject:_imagePath forKey:@"_imagePath"];
    [aCoder encodeObject:_image forKey:@"_image"];
    
}
@end
