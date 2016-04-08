//
//  AddrOrgNormalCell.m
//  HongTu
//
//  Created by weinee on 16/4/8.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "AddrOrgNormalCell.h"
@interface AddrOrgNormalCell (){
	UIImageView *_arrow;
}

@end

@implementation AddrOrgNormalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		_arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_rigth"]];
		[self.contentView addSubview:_arrow];
		
		[self doLayoutSubViews];
	}
	return self;
}

-(void)layoutSubviews{
	[super layoutSubviews];
	if (self.model.expand) {
		[UIView animateWithDuration:0.3 animations:^{
			_arrow.transform = CGAffineTransformMakeRotation(PI * 0.5);
		}];
	} else{
		[UIView animateWithDuration:0.3 animations:^{
			_arrow.transform = CGAffineTransformIdentity;
		}];
	}
	[self.contentView bringSubviewToFront:_arrow];
}

-(void) doLayoutSubViews{
	CGFloat screenWidth = kScreenWidth;
	_arrow.sd_layout
	.centerYEqualToView(self.contentView)
	.leftSpaceToView(self.contentView, screenWidth * 690/750)
	.widthIs(10)
	.heightIs(17);
}

#pragma mark setter
-(void)setModel:(AddrOrgModel *)model{
	_model = model;
	self.textLabel.text = _model.name;
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
