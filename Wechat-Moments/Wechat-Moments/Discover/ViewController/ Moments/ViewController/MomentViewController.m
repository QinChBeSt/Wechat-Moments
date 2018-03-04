//
//  MomentViewController.m
//  Wechat-Moments
//
//  Created by 钱程 on 2018/3/2.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "MomentViewController.h"



@interface MomentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UIView *naviView;
@property (nonatomic , strong) UITableView *tableView;
@end

@implementation MomentViewController

-(void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creaeteNaviView];
    [self createTableView];
   
}

#pragma mark - 导航栏
- (void)creaeteNaviView{
    self.naviView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,SafeAreaTopHeight)];
    self.naviView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.naviView];
    //标题
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"朋友圈";
    titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabel];
    __weak typeof (self)ws = self;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.naviView);
        make.bottom.equalTo(ws.naviView.mas_bottom).offset(-10);
    }];
    
    //返回
    UIImageView *backimg = [[UIImageView alloc]init];
    [backimg setImage:[UIImage imageNamed:@"返回"]];
    [self.naviView addSubview:backimg];
    [backimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.naviView.mas_left).offset(15);
        make.centerY.equalTo(titleLabel.mas_centerY);
        make.width.equalTo(@(20));
        make.height.equalTo(@(24));
    }];
    UILabel *backLable = [[UILabel alloc]init];
    backLable.text = @"返回";
    backLable.textColor = [UIColor whiteColor];
    [self.view addSubview:backLable];
    [backLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backimg.mas_right).offset(5);
        make.bottom.equalTo(ws.naviView.mas_bottom).offset(-10);
    }];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.naviView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.naviView);
        make.top.equalTo(self.naviView.mas_top).offset(20);
        make.bottom.equalTo(self.naviView.mas_bottom);
        make.right.equalTo(backimg.mas_right).offset(10);
    }];
    
}

#pragma mark - tableview
-(void)createTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, self.view.frame.size.width, self.view.frame.size.height - SafeAreaTopHeight) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    /** 注册cell. */
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"pool1"];
    
    [self.view addSubview:self.tableView];
    
    
}

#pragma mark - tableView DataSouce
/**** 行数 ****/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pool1"];
    
    return cell;
}
/* 行高 **/
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

-(void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
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
