//
//  MessageTableViewCell.m
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/27.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "NewEntity.h"

@interface MessageTableViewCell ()
@property(nonatomic,strong) UIImageView * ivThum;
@property(nonatomic,strong) UIImageView * ivRead;
@property(nonatomic,strong) UILabel * labTitle;
@property(nonatomic,strong) UILabel * labRead;
@end
@implementation MessageTableViewCell

+ (CGFloat)getTableViewCellHightModel:(id)model
{
    return 100;
}
- (void)initView
{
    [self.contentView addSubview:self.ivThum];
    [self.contentView addSubview:self.ivRead];
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labRead];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.ivThum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.mas_offset(15);
        make.size.mas_offset(CGSizeMake(100, 70));
    }];
    
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ivThum);
        make.left.equalTo(self.ivThum.mas_right).offset(5);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    
    [self.ivRead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.ivThum);
        make.left.equalTo(self.ivThum.mas_right).offset(5);
        make.size.mas_offset(CGSizeMake(20, 20));
    }];
    
    [self.labRead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ivRead.mas_right).offset(2);
        make.centerY.equalTo(self.ivRead);
    }];
    
}

- (void)setEntity:(NewEntity *)entity{
    NewEntity * newModel = (NewEntity *)entity;
    self.labTitle.text =  newModel.title;
    self.labRead.text = newModel.replyCount;
    NSString * url = newModel.imgsrc.firstObject;
    [self.ivThum sd_setImageWithURL:URL(url) placeholderImage:ImageNamed(@"tab_discover_normal")];
}

- (UIImageView *)ivThum{
    if (!_ivThum) {
        _ivThum = [UIImageView new];
        _ivThum.backgroundColor = [UIColor grayColor];
    }
    return _ivThum;
}
- (UIImageView *)ivRead{
    if (!_ivRead) {
        _ivRead = [UIImageView new];
        _ivRead.backgroundColor = [UIColor orangeColor];
    }
    return _ivRead;
}
- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [UILabel new];
        _labTitle.numberOfLines = 0;
        _labTitle.font = FontS(FONT_MIDDLE);
        _labTitle.textColor = ColorS(COLOR_BLACK_TWO);
    }
    return _labTitle;
}
- (UILabel *)labRead{
    if (!_labRead) {
        _labRead = [UILabel new];
    }
    return _labRead;
}


@end
