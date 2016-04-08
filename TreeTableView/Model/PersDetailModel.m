//
//  PersDetailModel.m
//  HongTu
//
//  Created by weinee on 16/3/28.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "PersDetailModel.h"
@implementation PersDetailModel
@synthesize displayname_quanpinFirst = _displayname_quanpinFirst;

-(NSString *)avatar{
	if (_avatar) {
		return _avatar;
	}
	return @"";
}
-(NSString *)displayname{
	if (_displayname) {
		return _displayname;
	}
	return @"无";
}
-(NSString *)jobnum{
	if (_jobnum) {
		return _jobnum;
	}
	return @"无";
}
-(NSString *)department{
	if (_department) {
		return _department;
	}
	return @"无";
}
-(NSString *)position{
	if (_position) {
		return _position;
	}
	return @"无";
}
-(NSString *)superior{
	if (_superior) {
		return _superior;
	}
	return @"无";
}
-(NSString *)cellphone{
	if (_cellphone) {
		return _cellphone;
	}
	return @"无";
}
-(NSString *)phone{
	if (_phone) {
		return _phone;
	}
	return @"无";
}
-(NSString *)email{
	if (_email) {
		return _email;
	}
	return @"无";
}
-(NSString *)detail{
	if (_detail) {
		return _detail;
	}
	return @"无";
}

@end
