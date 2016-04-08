//
//  ViewController.m
//  TreeTableView
//
//  Created by yixiang on 15/7/3.
//  Copyright (c) 2015年 yixiang. All rights reserved.
//

#import "ViewController.h"
#import "AddrOrgNormalCell.h"
#import "AddrOrgCell.h"
#import "AddrOrgModel.h"
#import "PersDetailModel.h"
#import "TreeTableView.h"

@interface ViewController ()<TreeTableCellDelegate>

@property (nonatomic, strong) NSArray<AddrOrgModel*> *data;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    
}

-(void)initData{

	AddrOrgModel *country1 = [[AddrOrgModel alloc] initWithParentId:-1 nodeId:0 name:@"中国" isLeaf:NO expand:YES];
	AddrOrgModel *province1 = [[AddrOrgModel alloc] initWithParentId:0 nodeId:1 name:@"江苏" isLeaf:NO expand:NO];
	AddrOrgModel *city1 = [[AddrOrgModel alloc] initWithParentId:1 nodeId:2 name:@"南通" isLeaf:YES expand:NO];
	PersDetailModel *model1 = [[PersDetailModel alloc] init];
	model1.displayname = @"weinee1";
	model1.detail = @"detail weinee1";
	city1.userDetail = model1;
	AddrOrgModel *city2 = [[AddrOrgModel alloc] initWithParentId:1 nodeId:3 name:@"南京" isLeaf:YES expand:NO];
	PersDetailModel *model2 = [[PersDetailModel alloc] init];
	model2.displayname = @"weinee2";
	model2.detail = @"detail weinee2";
	city2.userDetail = model2;
	AddrOrgModel *city3 = [[AddrOrgModel alloc] initWithParentId:1 nodeId:4 name:@"苏州" isLeaf:YES expand:NO];
	PersDetailModel *model3 = [[PersDetailModel alloc] init];
	model3.displayname = @"weinee3";
	model3.detail = @"detail weinee3";
	city3.userDetail = model3;
	AddrOrgModel *province2 = [[AddrOrgModel alloc] initWithParentId:0 nodeId:5 name:@"广东" isLeaf:NO expand:NO];
	AddrOrgModel *city4 = [[AddrOrgModel alloc] initWithParentId:5 nodeId:6 name:@"深圳" isLeaf:YES expand:NO];
	PersDetailModel *model4 = [[PersDetailModel alloc] init];
	model4.displayname = @"weinee4";
	model4.detail = @"detail weinee4";
	city4.userDetail = model4;
	AddrOrgModel *city5 = [[AddrOrgModel alloc] initWithParentId:5 nodeId:7 name:@"广州" isLeaf:YES expand:NO];
	PersDetailModel *model5 = [[PersDetailModel alloc] init];
	model5.displayname = @"weinee5";
	model5.detail = @"detail weinee5";
	city5.userDetail = model5;
	AddrOrgModel *province3 = [[AddrOrgModel alloc] initWithParentId:0 nodeId:8 name:@"浙江" isLeaf:NO expand:NO];
	AddrOrgModel *city6 = [[AddrOrgModel alloc] initWithParentId:8 nodeId:9 name:@"杭州" isLeaf:YES expand:NO];
	PersDetailModel *model6 = [[PersDetailModel alloc] init];
	model6.displayname = @"weinee5";
	model6.detail = @"detail weinee5";
	city6.userDetail = model6;
	//----------------------------------美国的省地市关系图0,1,2--------------------------------------------
	AddrOrgModel *country2 = [[AddrOrgModel alloc] initWithParentId:-1 nodeId:10 name:@"美国" isLeaf:NO expand:YES];
	AddrOrgModel *province4 = [[AddrOrgModel alloc] initWithParentId:10 nodeId:11 name:@"纽约州" isLeaf:YES expand:NO];
	PersDetailModel *model7 = [[PersDetailModel alloc] init];
	model7.displayname = @"weinee6";
	model7.detail = @"detail weinee6";
	province4.userDetail = model7;
	AddrOrgModel *province5 = [[AddrOrgModel alloc] initWithParentId:10 nodeId:12 name:@"德州" isLeaf:NO expand:NO];
	AddrOrgModel *city7 = [[AddrOrgModel alloc] initWithParentId:12 nodeId:13 name:@"休斯顿" isLeaf:YES expand:NO];
	PersDetailModel *model8 = [[PersDetailModel alloc] init];
	model8.displayname = @"weinee7";
	model8.detail = @"detail weinee7";
	city7.userDetail = model8;
	AddrOrgModel *province6 = [[AddrOrgModel alloc] initWithParentId:10 nodeId:14 name:@"加州" isLeaf:NO expand:NO];
	AddrOrgModel *city8 = [[AddrOrgModel alloc] initWithParentId:14 nodeId:15 name:@"洛杉矶" isLeaf:YES expand:NO];
	AddrOrgModel *city9 = [[AddrOrgModel alloc] initWithParentId:14 nodeId:16 name:@"旧金山" isLeaf:YES expand:NO];
	
	//----------------------------------日本的省地市关系图0,1,2--------------------------------------------
	AddrOrgModel *country3 = [[AddrOrgModel alloc] initWithParentId:-1 nodeId:17 name:@"日本" isLeaf:NO expand:YES];
	AddrOrgModel *province7 = [[AddrOrgModel alloc] initWithParentId:17 nodeId:18 name:@"东京" isLeaf:YES expand:NO];
	AddrOrgModel *province8 = [[AddrOrgModel alloc] initWithParentId:17 nodeId:19 name:@"东京1" isLeaf:YES expand:NO];
	AddrOrgModel *province9 = [[AddrOrgModel alloc] initWithParentId:17 nodeId:20 name:@"东京2" isLeaf:YES expand:NO];
	
	
	//NSArray *data = [NSArray arrayWithObjects:country1,country2,country3, nil];
	
	//NSArray *data = [NSArray arrayWithObjects:country1,province1,province2,province3,country2,province4,province5,province6,country3, nil];
	
	_data = [NSArray arrayWithObjects:country1,province1,city1,city2,city3,province2,city4,city5,province3,city6,country2,province4,province5,city7,province6,city8,city9,country3,province7,province8,province9, nil];
    
    
    TreeTableView *tableview = [[TreeTableView alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-20) withData:_data];
	
	[tableview setNormalCell:[AddrOrgNormalCell class] leafCell:[AddrOrgCell class] normalCellModelKeyPath:@"model" leafCellModelKeyPath:@"model"];
	
    tableview.treeTableCellDelegate = self;
	
    [self.view addSubview:tableview];
}

#pragma mark - TreeTableCellDelegate
-(void)clickLeafCell:(TreeNodeModel *)node index:(NSInteger)index{
	NSLog(@"%@", node.name);
}

-(void)clickNormalCell:(TreeNodeModel *)node index:(NSInteger)index{
	NSLog(@"%@", node.name);
}

@end
