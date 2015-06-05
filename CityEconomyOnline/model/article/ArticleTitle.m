//
//  ArticleTitle.m
//  CityEconomyOnline
//
//  Created by a on 13-11-27.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "ArticleTitle.h"

@implementation ArticleTitle

@synthesize title = _title ; // 文章标题

@synthesize updatedtime = _updatedtime ; // 发布时间

@synthesize articleId = _articleId ; //  文章id ；
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _title = [aDecoder decodeObjectForKey:@"_title"];
        _updatedtime = [aDecoder decodeObjectForKey:@"_updatedtime"];
        _articleId = [aDecoder decodeObjectForKey:@"_articleId"];
        
    }
    return self ;
    
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_title forKey:@"_title"];
    [aCoder encodeObject:_updatedtime forKey:@"_updatedtime"];
    [aCoder encodeObject:_articleId forKey:@"_articleId"];
    
}
@end
