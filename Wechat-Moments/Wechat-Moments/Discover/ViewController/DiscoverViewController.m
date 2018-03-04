//
//  DiscoverViewController.m
//  Wechat-Moments
//
//  Created by 钱程 on 2018/3/1.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "DiscoverViewController.h"
#import "MomentViewController.h"
@interface DiscoverViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView *discoverTableview;
@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self craeteTableView];
    // Do any additional setup after loading the view.
}

#pragma mark - 创建tableview
- (void)craeteTableView{
    _discoverTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    _discoverTableview.delegate = self;
    _discoverTableview.dataSource = self;
    [_discoverTableview       setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    /** 注册cell. */
    [_discoverTableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:_discoverTableview];
}

#pragma mark - tableview Delegate&dataSource
//tableView的分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
//每组返回多少个cell
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 2;
    }else if (section == 2){
        return 2;
    }else if (section == 3){
        return 2;
    }else if (section == 4){
        return 2;
    }else if (section == 5){
        return 1;
    }
    return 0;
}
//设置cell的高度,默认高度64
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    // 根据标识去缓存池找cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 不写这句直接崩掉，找不到循环引用的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"朋友圈";
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"扫一扫";
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"摇一摇";
        }
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"看一看";
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"搜一搜";
        }
    }else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"附近的人";
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"漂流瓶";
        }
    }else if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"购物";
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"游戏";
        }
    }else if (indexPath.section == 5) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"小程序";
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MomentViewController *momentVC = [[MomentViewController alloc]init];
    self.navigationController.navigationBarHidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController pushViewController:momentVC animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
