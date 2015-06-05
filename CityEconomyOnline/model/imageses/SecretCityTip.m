//
//  SecretCityTip.m
//  CityEconomyOnline
//
//  Created by a on 13-12-4.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "SecretCityTip.h"

@implementation SecretCityTip
@synthesize cityId = _cityId ; 
@synthesize cityName = _cityName ;
@synthesize fileUrl = _fileUrl ;
@synthesize cityImage = _cityImage ;
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _cityId = [aDecoder decodeObjectForKey:@"_cityId"];
        _cityName =[aDecoder decodeObjectForKey:@"_cityName"];
        _fileUrl = [aDecoder decodeObjectForKey:@"_fileUrl"];
        _cityImage = [aDecoder decodeObjectForKey:@"_cityImage"];
        
    }
    return self ;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_cityId forKey:@"_cityId"];
    [aCoder encodeObject:_cityName forKey:@"_cityName"];
    [aCoder encodeObject:_fileUrl forKey:@"_fileUrl"];
    [aCoder encodeObject:_cityImage forKey:@"_cityImage"];
    
}
@end
