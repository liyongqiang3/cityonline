//
//  ArticleDetail.m
//  CityEconomyOnline
//
//  Created by a on 13-11-27.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "ArticleDetail.h"

@implementation ArticleDetail
@synthesize title = _title ;
@synthesize  articleid = _articleid ;
@synthesize city = _city ;
@synthesize usagetype = _usagetype ;
@synthesize content = _content ;
@synthesize createdDate = _createdDate ;
@synthesize updatedDate = _updatedDate ;
@synthesize subtitle = _subtitle ;
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self  = [super init];
    if (self) {
        _title = [aDecoder decodeObjectForKey:@"_title"];
        _articleid = [aDecoder decodeObjectForKey:@"_articleid"];
        _city = [aDecoder decodeObjectForKey:@"_city"];
        _usagetype = [aDecoder decodeObjectForKey:@"_usagetype"];
        _content = [aDecoder decodeObjectForKey:@"_content"];
        _createdDate = [aDecoder decodeObjectForKey:@"_createdDate"];
        _content = [aDecoder decodeObjectForKey:@"_updatedDate"];
        _subtitle =[aDecoder decodeObjectForKey:@"_subtitle"];
    }
    return self ;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder  encodeObject:_title forKey:@"_title"];
    [aCoder encodeObject:_articleid forKey:@"_articleid"];
    [aCoder encodeObject:_city forKey:@"_city"];
    [aCoder encodeObject:_usagetype forKey:@"_usagetype"];
    [aCoder encodeObject:_content forKey:@"_content"];
    [aCoder encodeObject:_createdDate forKey:@"_createdDate"];
    [aCoder encodeObject:_updatedDate forKey:@"_updatedDate"];
    [aCoder encodeObject:_subtitle forKey:@"_subtitle"];
}
@end
