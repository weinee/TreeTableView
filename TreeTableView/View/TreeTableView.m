//
//  TreeTableView.m
//  TreeTableView
//
//  Created by yixiang on 15/7/3.
//  Copyright (c) 2015年 yixiang. All rights reserved.
//	Modified by weineeL.
//

#import "TreeTableView.h"
#import "TreeNodeModel.h"
//#import "AddrOrgCell.h"

@interface TreeTableView ()<UITableViewDataSource,UITableViewDelegate>{
	Class _normalCell;
	Class _leafCell;
	NSString *_normalModelKeyPath;
	NSString *_leafModelKeyPath;
}

@property (nonatomic , weak) NSArray<TreeNodeModel *> *data;//传递过来已经组织好的数据（全量数据）

//可以优化为data 下标数组, 节省内存
@property (nonatomic , strong) NSMutableArray<NSNumber *> *tempData;//用于存储数据源（部分数据）当前显示的


@end

@implementation TreeTableView
static NSString *Normal_Node_Cell_ID = @"normal_node_cell_id";
static NSString *LeafCell_Node_Cell_ID = @"LeafCell_Node_Cell_ID";

-(instancetype)initWithFrame:(CGRect)frame withData : (NSArray *)data{
    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        _data = data;
        _tempData = [self createTempData:data];
			/** 注册单元格*/
			[self registerClass:[UITableViewCell class] forCellReuseIdentifier:Normal_Node_Cell_ID];
			[self registerClass:[UITableViewCell class] forCellReuseIdentifier:LeafCell_Node_Cell_ID];
    }
    return self;
}
/**
 * 初始化数据源
 */
-(NSMutableArray *)createTempData : (NSArray *)data{
	NSMutableArray *tempArray = [NSMutableArray array];
	for (int i=0; i<data.count; i++) {
		TreeNodeModel *node = [_data objectAtIndex:i];
		if (node.parentId == -1) {
			[tempArray addObject:@(i)];
			node.expand = NO;
		}
	}
	return tempArray;
}

#pragma mark - config
-(void)setNormalCell:(Class)normalCell leafCell:(Class)leafCell normalCellModelKeyPath:(NSString *)normalKeyPath leafCellModelKeyPath:(NSString *)leafKeyPath{
	_normalCell = normalCell;
	_leafCell = leafCell;
	_normalModelKeyPath = normalKeyPath;
	_leafModelKeyPath = leafKeyPath;
	//注册cell
	if (normalCell) {
		[self registerClass:normalCell forCellReuseIdentifier:Normal_Node_Cell_ID];
	}
	if (leafCell) {
		[self registerClass:leafCell forCellReuseIdentifier:LeafCell_Node_Cell_ID];
	}
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tempData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	TreeNodeModel *node = _data[[[_tempData objectAtIndex:indexPath.row] integerValue]];
	UITableViewCell *cell = nil;
	
	//判断是否为叶子节点
	if (node.isLeaf) {
		cell = [tableView dequeueReusableCellWithIdentifier:LeafCell_Node_Cell_ID forIndexPath:indexPath];
		//设置model
		if (_leafModelKeyPath && _leafModelKeyPath.length > 0) {
			[cell setValue:node forKey:_leafModelKeyPath];
		} else{
			cell.textLabel.text = node.name;
		}
	} else{
		cell = [tableView dequeueReusableCellWithIdentifier:Normal_Node_Cell_ID forIndexPath:indexPath];
		if (_normalModelKeyPath && _normalModelKeyPath.length > 0) {
			[cell setValue:node forKey:_normalModelKeyPath];
		} else{
			cell.textLabel.text = node.name;
		}
	}
	// cell有缩进的方法
	cell.indentationLevel = node.depth; // 缩进级别
	cell.indentationWidth = 20.f; // 每个缩进级别的距离
//	[cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
	self.sd_indexPath = indexPath;//缓存
	self.sd_tableView = tableView;
	[cell layoutIfNeeded];
	return cell;
}


#pragma mark - Optional
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	TreeNodeModel *currentNode = _data[[[_tempData objectAtIndex:indexPath.row] integerValue]];
	if (currentNode.isLeaf) {
		return [self cellHeightForIndexPath:indexPath model:currentNode keyPath:@"model" cellClass:_leafCell contentViewWidth:[self cellContentViewWith]];
	}
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

//
- (CGFloat)cellContentViewWith
{
	CGFloat width = [UIScreen mainScreen].bounds.size.width;
	
	// 适配ios7
	if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
		width = [UIScreen mainScreen].bounds.size.height;
	}
	return width;
}
#pragma mark - UITableViewDelegate

#pragma mark - Optional
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	TreeNodeModel *currentNode = _data[[[_tempData objectAtIndex:indexPath.row] integerValue]];
	
	/// 先判断是不是叶子节点
	if (currentNode.isLeaf) {
		
		// 调用代理
		if (_treeTableCellDelegate && [_treeTableCellDelegate respondsToSelector:@selector(clickLeafCell:index:)]) {
			[_treeTableCellDelegate clickLeafCell:currentNode index:indexPath.row];
		}
	} else{
		currentNode.expand = !currentNode.expand;
		
		//先修改数据源, 非叶子节点
		if (_treeTableCellDelegate && [_treeTableCellDelegate respondsToSelector:@selector(clickNormalCell:index:)]) {
			[_treeTableCellDelegate clickNormalCell:currentNode index:indexPath.row];
		}
		
		NSUInteger startPosition = indexPath.row+1;
		NSUInteger endPosition = startPosition;
		
		if (currentNode.expand) {
			for (int i=0; i<_data.count; i++) {
				TreeNodeModel *node = [_data objectAtIndex:i];
				if (node.parentId == currentNode.nodeId) {
						node.depth = currentNode.depth + 1;
						[_tempData insertObject:@(i) atIndex:endPosition];
						endPosition++;
				}
			}
		} else{
			endPosition = [self removeAllNodesAtIndex:indexPath.row];
		}

		//获得需要修正的indexPath
		NSMutableArray *indexPathArray = [NSMutableArray array];
		for (NSUInteger i=startPosition; i<endPosition; i++) {
			NSIndexPath *tempIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
			[indexPathArray addObject:tempIndexPath];
		}
		
		//插入或者删除相关节点
		if (currentNode.expand) {
			[self insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationFade];
		}else{
			[self deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationFade];
		}
	}
}

/**
 *  删除该父节点下的所有子节点（包括孙子节点）
 *
 *  @param parentNode 父节点
 *
 *  @return 该父节点下一个相邻的统一级别的节点的位置
 */
-(NSUInteger)removeAllNodesAtIndex : (NSInteger)index{
		TreeNodeModel *parentNode = _data[[[_tempData objectAtIndex:index] integerValue]];
    NSUInteger startPosition = index;
    NSUInteger endPosition = startPosition;
    for (NSUInteger i=startPosition+1; i<_tempData.count; i++) {
        TreeNodeModel *node = _data[[[_tempData objectAtIndex:i] integerValue]];
        endPosition++;
        if (node.depth <= parentNode.depth) {
            break;
        }
        if(endPosition == _tempData.count-1){
            endPosition++;
            node.expand = NO;
            break;
        }
        node.expand = NO;
    }
    if (endPosition>startPosition) {
        [_tempData removeObjectsInRange:NSMakeRange(startPosition+1, endPosition-startPosition-1)];
    }
    return endPosition;
}

@end
