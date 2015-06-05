//
//  ImageModel.m
//  CityEconomyOnline
//
//  Created by a on 13-11-29.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "ImageModel.h"

@implementation ImageModel

@synthesize imageUrl = _imageUrl ;

@synthesize  cityid = _cityid ;

@synthesize  landscape_id = _landscape_id ;

@synthesize  landscape_name = _landscape_name ;

@synthesize image = _image ;

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _image = [aDecoder decodeObjectForKey:@"image"];
        _imageUrl = [aDecoder decodeObjectForKey:@"imageUrl"];
        _landscape_id = [aDecoder decodeObjectForKey:@"landscape_id"];
        _landscape_name = [aDecoder decodeObjectForKey:@"landscape_name"];
        _cityid = [aDecoder decodeObjectForKey:@"cityid"];
        
    }
    return self  ;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_image forKey:@"image"];
    [aCoder encodeObject:_imageUrl forKey:@"imageUrl"];
    [aCoder encodeObject:_landscape_name forKey:@"landscape_name"];
    [aCoder encodeObject:_landscape_id forKey:@"landscape_id"];
    [aCoder encodeObject: _cityid forKey:@"cityid"];
    
}

@end
