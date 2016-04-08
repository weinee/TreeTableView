//
//  PersDetailModel.h
//  HongTu
//
//  Created by weinee on 16/3/28.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersDetailModel : NSObject
@property (nonatomic, strong) NSString* avatar;
@property (nonatomic, strong) NSString* displayname;
@property (nonatomic, strong, readonly) NSString* displayname_quanpinFirst;

@property (nonatomic, strong) NSString* detail;
@property (nonatomic, strong) NSString* jobnum;
@property (nonatomic, strong) NSString* department;
@property (nonatomic, strong) NSString* position;
@property (nonatomic, strong) NSString* superior;
@property (nonatomic, strong) NSString* cellphone;
@property (nonatomic, strong) NSString* phone;
@property (nonatomic, strong) NSString* email;

@end
