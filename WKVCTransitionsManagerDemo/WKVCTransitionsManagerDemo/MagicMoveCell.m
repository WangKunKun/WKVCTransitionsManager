//
//  MagicMoveCell.m
//  WKVCTransitionsManagerDemo
//
//  Created by wangkun on 2018/12/17.
//  Copyright © 2018年 wangkun. All rights reserved.
//

#import "MagicMoveCell.h"
#import "UIViewExt.h"
@interface MagicMoveCell ()

@property (nonatomic, strong) UIImageView * IV;

@end

@implementation MagicMoveCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI
{
    [self.contentView addSubview:self.IV];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.IV.frame = CGRectMake(0, 0, self.width, self.height - 10);
}

- (UIImageView *)IV
{
    if (!_IV) {
        _IV = [UIImageView new];
        [_IV setImage:[UIImage imageNamed:@"magicmove"]];
    }
    return _IV;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
