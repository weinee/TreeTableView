//
//  Node.m
//  TreeTableView
//
//  Created by yixiang on 15/7/3.
//  Copyright (c) 2015年 yixiang. All rights reserved.
//

#import "TreeNodeModel.h"

@implementation TreeNodeModel

- (instancetype)initWithParentId : (int)parentId nodeId : (int)nodeId name : (NSString *)name isLeaf : (BOOL)leaf expand : (BOOL)expand{
    self = [self init];
    if (self) {
        self.parentId = parentId;
        self.nodeId = nodeId;
        self.name = name;
				self.isLeaf = leaf;
        self.depth = 0;
        self.expand = expand;
    }
    return self;
}

@end
