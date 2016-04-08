//
//  AddrOrgCell.m
//  HongTu
//
//  Created by weinee on 16/4/7.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "AddrOrgCell.h"
#import "UIView+SDAutoLayout.h"

@interface AddrOrgCell ()
//头像
@property (nonatomic, strong) UIImageView *avatar;
//姓名
@property (nonatomic, strong) UILabel *name;
//简介
@property (nonatomic, strong) UILabel *detail;

@end

@implementation AddrOrgCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self doLayoutSubviews];
	}
	return self;
}

#pragma mark 初始化并布局视图
-(void)doLayoutSubviews{
	CGFloat screenWidth = kScreenWidth;
	//头像
	self.avatar.sd_layout
	.widthIs(screenWidth * 0.1333)
	.heightEqualToWidth()
	.leftSpaceToView(self.contentView, screenWidth * 0.036)
	.topSpaceToView(self.contentView, screenWidth * 0.0267);
	self.avatar.layer.masksToBounds = YES;
	//姓名
	self.name.sd_layout
	.topSpaceToView(self.contentView, screenWidth * 0.0373)
	.leftSpaceToView(self.avatar, screenWidth * 0.0333)
	.heightIs(screenWidth * 0.045)
	.widthIs(screenWidth * 0.6);
	//简介
	self.detail.sd_layout
	.topSpaceToView(self.name, screenWidth * 0.0293)
	.leftSpaceToView(self.avatar, screenWidth * 0.0333)
	.heightIs(screenWidth * 0.04)
	.widthIs(screenWidth * 0.72);
	
}

-(void)layoutSubviews{
	[super layoutSubviews];
	self.avatar.layer.cornerRadius = self.avatar.frame.size.width * 0.5;
	
	//实现自定义cell的缩进
	CGRect rect = self.contentView.frame;
	rect.origin.x = self.indentationLevel * self.indentationWidth;
	self.contentView.frame = rect;
}

/** 设置cell内容*/
-(void)setModel:(AddrOrgModel*) model{
	//可能需要网络加载
	self.avatar.image = [UIImage imageNamed:@"header"];
	
	self.name.text = model.userDetail.displayname;
	
	self.detail.text = model.userDetail.detail;
	
	//contentView 高度自适应
	[self setupAutoHeightWithBottomView:self.avatar bottomMargin: kScreenWidth * 0.0267];
}

#pragma mark 视图懒加载
-(UIImageView *)avatar{
	if (!_avatar) {
		_avatar = [[UIImageView alloc] init];
		[self.contentView addSubview:_avatar];
	}
	return _avatar;
}
-(UILabel *)name{
	if (!_name) {
		_name = [[UILabel alloc] init];
		_name.numberOfLines = 1;
		_name.lineBreakMode = NSLineBreakByTruncatingTail;
		_name.font = kFontOfSize(15);
		_name.textColor = [UIColor blackColor];
		[self.contentView addSubview:_name];
	}
	return _name;
}
-(UILabel *)detail{
	if (!_detail) {
		_detail = [[UILabel alloc] init];
		_detail.numberOfLines = 1;
		_detail.lineBreakMode = NSLineBreakByTruncatingTail;
		_detail.font = kFontOfSize(12);
		_detail.textColor = [UIColor greenColor];
		[self.contentView addSubview:_detail];
	}
	return _detail;
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
