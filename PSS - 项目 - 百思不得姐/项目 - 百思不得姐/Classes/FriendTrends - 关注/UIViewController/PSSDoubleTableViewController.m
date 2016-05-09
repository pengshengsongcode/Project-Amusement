//
//  PSSLeftViewController.m
//  项目 - 百思不得姐
//
//  Created by ma c on 16/3/26.
//  Copyright © 2016年 彭盛凇. All rights reserved.
//

#import "PSSDoubleTableViewController.h"
#import "AFNetworking.h"
#import "PSSLeftTabelViewModel.h"
#import "MJExtension.h"
#import "PSSCustomLeftCell.h"
#import "SVProgressHUD.h"
#import "PSSRecommendUserCell.h"
#import "PSSRightTabelViewModel.h"
#import "MJRefresh.h"

#define PSSSelectedCategory self.leftDataList[self.leftTableView.indexPathForSelectedRow.row]

static NSString *identifier1 = @"customLeftCell";
static NSString *identifier2 = @"customRightCell";

@interface PSSDoubleTableViewController ()<UITableViewDataSource, UITableViewDelegate>
/** 左边的类别数据 */

@property (nonatomic, strong) NSArray *leftDataList;

/** 右边的用户数据 */

//@property (nonatomic, strong) NSArray *rightDataList;

/** 左边的类别表格 */

@property (weak, nonatomic) IBOutlet UITableView *leftTableView;

/** 右边的用户表格 */

@property (weak, nonatomic) IBOutlet UITableView *rightTableView;

/** 请求参数 */
@property (nonatomic, strong) NSMutableDictionary *params;

/** AFN请求管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation PSSDoubleTableViewController

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 控件的初始化
    [self setupTableView];
    
    // 添加刷新控件
    [self setupRefresh];
    
    // 加载左侧的类别数据
    [self loadCategories];
}

/**
 * 加载左侧的类别数据
 */
- (void)loadCategories
{
    // 显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    // 发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 隐藏指示器
        [SVProgressHUD dismiss];
        
        // 服务器返回的JSON数据
        self.leftDataList = [PSSLeftTabelViewModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [self.leftTableView reloadData];
        
        // 默认选中首行
        [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        
        // 让用户表格进入下拉刷新状态
        [self.rightTableView.mj_header beginRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
}

/**
 * 控件的初始化
 */
- (void)setupTableView
{
    // 注册
    [self.leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([PSSCustomLeftCell class]) bundle:nil] forCellReuseIdentifier:identifier1];
    [self.rightTableView registerNib:[UINib nibWithNibName:NSStringFromClass([PSSRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:identifier2];
    
    // 设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.leftTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.rightTableView.contentInset = self.leftTableView.contentInset;
    self.rightTableView.rowHeight = 70;
    
    // 设置标题
    self.title = @"推荐关注";
    
    // 设置背景色
    self.view.backgroundColor = PSSGlobalBg;
}

/**
 * 添加刷新控件
 */
- (void)setupRefresh
{
    self.rightTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.rightTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.rightTableView.mj_footer.hidden = YES;
}

#pragma mark - 加载用户数据
- (void)loadNewUsers
{
    PSSLeftTabelViewModel *leftModel = PSSSelectedCategory;
    
    // 设置当前页码为1
    leftModel.currentPage = 1;
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(leftModel.id);
    params[@"page"] = @(leftModel.currentPage);
    self.params = params;
    
    // 发送请求给服务器, 加载右侧的数据
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 字典数组 -> 模型数组
        NSArray *users = [PSSRightTabelViewModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 清除所有旧数据
        [leftModel.users removeAllObjects];
        
        // 添加到当前类别对应的用户数组中
        [leftModel.users addObjectsFromArray:users];
        
        // 保存总数
        leftModel.total = [responseObject[@"total"] integerValue];
        
        // 不是最后一次请求
        if (self.params != params) return;
        
        // 刷新右边的表格
        [self.rightTableView reloadData];
        
        // 结束刷新
        [self.rightTableView.mj_header endRefreshing];
        
        // 让底部控件结束刷新
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.params != params) return;
        
        // 提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        // 结束刷新
        [self.rightTableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreUsers
{
    PSSLeftTabelViewModel *lefeModel = PSSSelectedCategory;
    
    // 发送请求给服务器, 加载右侧的数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(lefeModel.id);
    params[@"page"] = @(++lefeModel.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 字典数组 -> 模型数组
        NSArray *users = [PSSRightTabelViewModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 添加到当前类别对应的用户数组中
        [lefeModel.users addObjectsFromArray:users];
        
        // 不是最后一次请求
        if (self.params != params) return;
        
        // 刷新右边的表格
        [self.rightTableView reloadData];
        
        // 让底部控件结束刷新
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.params != params) return;
        
        // 提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        // 让底部控件结束刷新
        [self.rightTableView.mj_footer endRefreshing];
    }];
}

/**
 * 时刻监测footer的状态
 */
- (void)checkFooterState
{
    PSSLeftTabelViewModel *leftModel = PSSSelectedCategory;
    
    // 每次刷新右边数据时, 都控制footer显示或者隐藏
    self.rightTableView.mj_footer.hidden = (leftModel.users.count == 0);
    
    // 让底部控件结束刷新
    if (leftModel.users.count == leftModel.total) { // 全部数据已经加载完毕
        [self.rightTableView.mj_footer endRefreshingWithNoMoreData];
    } else { // 还没有加载完毕
        [self.rightTableView.mj_footer endRefreshing];
    }
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 左边的类别表格
    if (tableView == self.leftTableView) return self.leftDataList.count;
    
    // 监测footer的状态
    [self checkFooterState];
    
    // 右边的用户表格
    return [PSSSelectedCategory users].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) { // 左边的类别表格
        PSSCustomLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        cell.dataList = self.leftDataList[indexPath.row];
        return cell;
    } else { // 右边的用户表格
        PSSRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
        cell.user = [PSSSelectedCategory users][indexPath.row];
        return cell;
    }
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 结束刷新
    [self.rightTableView.mj_header endRefreshing];
    [self.rightTableView.mj_footer endRefreshing];
    
    PSSLeftTabelViewModel *leftModel = self.leftDataList[indexPath.row];
    if (leftModel.users.count) {
        // 显示曾经的数据
        [self.rightTableView reloadData];
    } else {
        // 赶紧刷新表格,目的是: 马上显示当前category的用户数据, 不让用户看见上一个category的残留数据
        [self.rightTableView reloadData];
        
        // 进入下拉刷新状态
        [self.rightTableView.mj_header beginRefreshing];
    }
}

#pragma mark - 控制器的销毁
- (void)dealloc
{
    // 停止所有操作
    [self.manager.operationQueue cancelAllOperations];
}
@end
