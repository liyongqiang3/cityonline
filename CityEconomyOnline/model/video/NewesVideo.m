//
//  NewesVideo.m
//  CityEconomyOnline
//
//  Created by a on 13-11-27.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "NewesVideo.h"

@implementation NewesVideo
@synthesize imagePath = _imagePath ;
@synthesize moveUrl = _moveUrl ;
@synthesize title = _title ;
@synthesize newesId = _newesId ;
@synthesize image = _image ;
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _imagePath = [aDecoder decodeObjectForKey:@"_imagePath"];
        _moveUrl = [aDecoder decodeObjectForKey:@"_moveUrl"];
        _title = [aDecoder decodeObjectForKey:@"_title"];
        _newesId = [aDecoder decodeObjectForKey:@"_newesId"];
        _image = [aDecoder decodeObjectForKey:@"_image"];
//        _newesId = [aDecoder decodeIntegerForKey:@"_newesId"];
    }
    return self ;
    
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_imagePath forKey:@"_imagePath"];
    [aCoder encodeObject:_moveUrl forKey:@"_moveUrl"];
    [aCoder encodeObject:_title forKey:@"_title"];
    [aCoder encodeObject:_newesId forKey:@"_newesId"];
    [aCoder encodeObject:_image forKey:@"_image"];
//    [aCoder encodeInteger: _newesId forKey:@"_newesId"];
    
}
@end
