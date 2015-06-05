//
//  ListCell.m
//  CityEconomyOnline
//
//  Created by 季程跃 on 13-10-5.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "ListCell.h"

@implementation ListCell
@synthesize image;
@synthesize newsImageVIew = _newsImageVIew ;
@synthesize  titleLabel = _titleLabel ;
@synthesize  detailLabel = _detailLabel ;
@synthesize  despLabel = _despLabel ;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        image = [UIImage imageNamed:@"talkCity.png"];
        
        [[self textLabel] setLineBreakMode:NSLineBreakByTruncatingTail];
        [[self textLabel] setNumberOfLines:2];
//
        self.selectionStyle = UITableViewCellSelectionStyleNone;//选中单元格时的形式
//        self.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow.png"]];
        
        _newsImageVIew = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 242, 150)];
//        _newsImageVIew setImage:
        [self addSubview:_newsImageVIew];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(306, 40, 200, 42)];
        _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(306, 82, 500, 36)];
//        _despLabel = [[UILabel alloc]initWithFrame:CGRectMake(506, 72, 300, 30)];
        
        _detailLabel.textColor = [UIColor whiteColor] ;
        _titleLabel.textColor = [UIColor whiteColor] ;
        _titleLabel.font = [UIFont  systemFontOfSize:18];
        _detailLabel.font = [UIFont systemFontOfSize:14];
        _despLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_titleLabel];
//        [self addSubview:_despLabel];
        [self addSubview: _detailLabel];
          _titleLabel.textColor = [UIColor whiteColor];
        _detailLabel.textColor = [UIColor whiteColor];
        _despLabel.textColor = [UIColor whiteColor] ;
        self.backgroundColor = [UIColor clearColor];
        _despLabel.backgroundColor = [UIColor clearColor]
        ;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _detailLabel.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}
-(void)setMoreVideo:(MoreVideo *)_moreVideo
{
    self->moreVideo = _moreVideo ;
    _titleLabel.text = _moreVideo.videoTitle ;
    
    _detailLabel.text = [_moreVideo.subtitle  stringByAppendingString:_moreVideo.desp];;
    
//    _despLabel.text = _moreVideo.desp ;
    _newsImageVIew.image  = _moreVideo.image ;
    
}

-(void)setTitle:(NSString *)title andDetail:(NSString *)detail andImage:(UIImage *)image
{
    _detailLabel.text = detail ;
    _titleLabel.text = title ;
   
    _detailLabel.textColor = [UIColor whiteColor] ;
    _titleLabel.textColor = [UIColor whiteColor] ;
                             
    _newsImageVIew.image = [UIImage imageNamed:@"talkCity.png"];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
