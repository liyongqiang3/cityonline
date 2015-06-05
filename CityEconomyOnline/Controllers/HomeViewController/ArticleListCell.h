//
//  ArticleListCell.h
//  CityEconomyOnline
//
//  Created by a on 13-12-6.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleListTitle.h"
@interface ArticleListCell : UITableViewCell
{
    ArticleListTitle * articleListTitle ;
    
}
@property (retain,nonatomic) UILabel * titleLabel ;// 标题

@property (retain,nonatomic) UILabel * subTitleLabel ;//子标题

@property (retain,nonatomic) UILabel * despLable; //描述

-(void)setArticleListTitle:(ArticleListTitle *)_articleListTitle ;
@end
