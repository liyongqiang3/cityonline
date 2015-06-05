//
//  MoreVideo.m
//  CityEconomyOnline
//
//  Created by a on 13-12-4.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "MoreVideo.h"

@implementation MoreVideo

@synthesize cityId = _cityId ;
@synthesize  createDate = _createDate;
@synthesize  filepath = _filepath ;
@synthesize  picturepath = _picturepath ;
@synthesize  usagetype = _usagetype ;
@synthesize  videoId = _videoId ;
@synthesize  videoTitle = _videoTitle ;
@synthesize  image = _image ;
@synthesize subtitle = _subtitle ;
@synthesize desp = _desp ;
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _desp = [aDecoder decodeObjectForKey:@"desp"];
        _subtitle = [aDecoder decodeObjectForKey: @"subtitle"];
        _cityId = [aDecoder decodeObjectForKey:@"_cityId"];
        _image = [aDecoder decodeObjectForKey:@"_image"];
        _createDate = [aDecoder decodeObjectForKey:@"_createDate"];
        _filepath = [aDecoder  decodeObjectForKey:@"_filepath"];
        _usagetype = [aDecoder decodeObjectForKey:@"_usagetype"];
        _videoId = [aDecoder decodeObjectForKey:@"_videoId"];
        _videoTitle = [aDecoder decodeObjectForKey:@"_videoTitle"];
        _picturepath = [aDecoder decodeObjectForKey:@"_picturepath"];
    }
    return  self ;
    
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_subtitle forKey:@"subtitle"];
    [aCoder encodeObject:_desp forKey:@"desp"];
    [aCoder encodeObject:_cityId forKey:@"_cityId"];
    [aCoder encodeObject:_image forKey:@"_image"];
    [aCoder encodeObject:_createDate forKey:@"_createDate"];
    [aCoder encodeObject:_filepath forKey:@"_filepath"];
    [aCoder encodeObject:_usagetype forKey:@"_usagetype"];
    [aCoder encodeObject:_videoId forKey:@"_videoId"];
    [aCoder encodeObject:_videoTitle forKey:@"_videoTitle"];
    [aCoder encodeObject:_picturepath forKey:@"_picturepath"];
    
}
@end
