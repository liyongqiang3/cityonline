//
//  CitytipsImage.m
//  CityEconomyOnline
//
//  Created by a on 13-12-3.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "CitytipsImage.h"

@implementation CitytipsImage

@synthesize cityID = _cityID ;
@synthesize  citytipsImage = _citytipsImage ;
@synthesize imageUrl = _imageUrl ;
@synthesize citytipsTitle = _citytipsTitle ;
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _cityID = [aDecoder decodeObjectForKey:@"_cityID"];
        _citytipsImage = [aDecoder decodeObjectForKey:@"_citytipsImage"];
        _imageUrl = [aDecoder decodeObjectForKey:@"_imageUrl"];
        _citytipsTitle = [aDecoder decodeObjectForKey:@"_citytipsTitle"];
        
    }
    return self ;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_cityID forKey:@"_cityID"];
    [aCoder encodeObject:_citytipsImage forKey:@"_citytipsImage"];
    [aCoder encodeObject:_imageUrl forKey:@"_imageUrl"];
    [aCoder encodeObject:_citytipsTitle forKey:@"_citytipsTitle"];
    
}
@end
