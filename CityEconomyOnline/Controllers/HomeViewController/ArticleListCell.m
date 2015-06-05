 //
//  ArticleListCell.m
//  CityEconomyOnline
//
//  Created by a on 13-12-6.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "ArticleListCell.h"

@implementation ArticleListCell
@synthesize titleLabel = _titleLabel ;
@synthesize subTitleLabel = _subTitleLabel ;
@synthesize  despLable = _despLable ;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
         self.selectionStyle  = UITableViewCellSelectionStyleNone;
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 30, 400, 50)];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = [UIColor whiteColor];
        
        _despLable = [[UILabel alloc]initWithFrame:CGRectMake(50, 80, 700, 35)];
        _despLable.font = [UIFont systemFontOfSize:16];
        _despLable.textColor = [UIColor whiteColor];
        _subTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 90, 200, 44)];
        _subTitleLabel.font = [UIFont systemFontOfSize:14];
        _subTitleLabel.textColor = [UIColor whiteColor];
        _subTitleLabel.backgroundColor = [UIColor clearColor];
        _despLable.backgroundColor = [UIColor clearColor];
        _titleLabel.backgroundColor = [UIColor clearColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
        [self addSubview:_titleLabel];
        [self addSubview:_despLable];
//        [self addSubview:_subTit leLabel];
        self.backgroundColor = [UIColor clearColor];
        
        
    }
    return self;
}
-(void)setArticleListTitle:(ArticleListTitle *)_articleListTitle
{
    self->articleListTitle = _articleListTitle;
    _titleLabel.text =  _articleListTitle.articleTitle;
//    _subTitleLabel.text =
    _despLable.text = [_articleListTitle.desp stringByAppendingFormat:@"   %@",_articleListTitle.subArtcleTitle ];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
