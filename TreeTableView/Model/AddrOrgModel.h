//
//  AddrOrgModel.h
//  HongTu
//
//  Created by weinee on 16/4/7.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "TreeNodeModel.h"
#import "PersDetailModel.h"

@interface AddrOrgModel : TreeNodeModel

@property (nonatomic, strong) PersDetailModel *userDetail;

@end
