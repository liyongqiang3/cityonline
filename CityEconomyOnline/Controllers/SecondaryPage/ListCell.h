//
//  ListCell.h
//  CityEconomyOnline
//
//  Created by 季程跃 on 13-10-5.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreVideo.h"


@interface ListCell : UITableViewCell
{
    MoreVideo * moreVideo ;
}

@property(nonatomic,retain) UIImage *image;

@property(nonatomic,retain)   UIImageView * newsImageVIew ;

@property (nonatomic,retain)  UILabel * titleLabel ;

@property (nonatomic,retain)  UILabel * detailLabel ;

@property (nonatomic,retain) UILabel * despLabel ;


@property (nonatomic,retain)  UIButton * detailButton ;
// 单元信息 
-(void)setMoreVideo:(MoreVideo *)_moreVideo ;


//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andTitle:(NSString *) title andDetail:(NSString *)detail ;
-(void)setTitle:(NSString *) title andDetail:(NSString *)detail andImage:(UIImage *)image;

@end
