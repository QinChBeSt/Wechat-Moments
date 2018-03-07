//
//  MomentViewController.m
//  Wechat-Moments
//
//  Created by 钱程 on 2018/3/2.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "MomentViewController.h"
#import "QCNetworkTask.h"
#import "UIImageView+WebCache.h"
#import "CellForMoment.h"
#import "MomentModel.h"

@interface MomentViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic , strong) UIView *naviView;
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) UIView *headView;
@property (nonatomic , strong) UIImageView *haedviewBackImg;
@property (nonatomic , strong) UILabel *haedviewNickname;
@property (nonatomic , strong) UIImageView *headviewIcon;

@property (nonatomic , strong) NSMutableArray *MomentListArr;
@property (nonatomic , strong) MomentModel *models;

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
- (NSMutableArray *)MomentListArr
{
    if (!_MomentListArr)
    {
        _MomentListArr = [NSMutableArray array];
    }
    return _MomentListArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self createTableView];
    [self creaeteNaviView];
    [self getNetwork];
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
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -100, self.view.frame.size.width, self.view.frame.size.height + 100) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
    self.headView.backgroundColor = [UIColor blackColor];
    self.tableView.tableHeaderView = self.headView;
    
     __weak typeof (self)ws = self;
    self.haedviewBackImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
    [self.headView addSubview:self.haedviewBackImg];

    
    self.haedviewNickname = [[UILabel alloc]init];
    self.haedviewNickname.textColor = [UIColor whiteColor];
    [self.haedviewBackImg addSubview:self.haedviewNickname];
    [self.haedviewNickname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.headView.mas_bottom).offset(-10);
        make.left.equalTo(ws.headView.mas_centerX);
    }];
    
    self.headviewIcon = [[UIImageView alloc]init];
    self.headviewIcon.backgroundColor = [UIColor whiteColor];
    self.headviewIcon.layer.borderColor = [[UIColor whiteColor]CGColor];
    self.headviewIcon.layer.borderWidth = 1.0;
    [self.headView addSubview:self.headviewIcon];
    [self.headviewIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.headView.mas_bottom).offset(-10);
        make.right.equalTo(ws.headView.mas_right).offset(-20);
        make.width.and.height.equalTo(@(60));
    }];
    
    /** 注册cell. */
    [self.tableView registerClass:[CellForMoment class] forCellReuseIdentifier:@"pool1"];
    
    [self.view addSubview:self.tableView];
    
    
}
#pragma mark - Network
-(void)getNetwork{
    [QCNetworkTask getWithURL:@"http://thoughtworks-ios.herokuapp.com/user/jsmith" withParameter:nil withHttpHeader:nil withResponseType:ResponseTypeJSON withSuccess:^(id result) {
        
        NSString *imgUrl = result[@"profile-image"];
        [self.haedviewBackImg sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
       
        NSString *nick =result[@"nick"];
        self.haedviewNickname.text = nick;
        
        NSString *iconUrl = result[@"avatar"];
        [self.headviewIcon sd_setImageWithURL:[NSURL URLWithString:iconUrl]];
    } withFail:nil];
    
    [QCNetworkTask getWithURL:@"http://thoughtworks-ios.herokuapp.com/user/jsmith/tweets" withParameter:nil withHttpHeader:nil withResponseType:ResponseTypeJSON withSuccess:^(id result) {
        
        NSMutableArray *arr = result;
        for (NSMutableDictionary *dic in arr) {
            MomentModel *model = [[MomentModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.MomentListArr addObject:model];
        }
        NSLog(@"%@",self.MomentListArr);
        [self.tableView reloadData];
    } withFail:nil];
}

#pragma mark - tableView DataSouce
/**** 行数 ****/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.MomentListArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellForMoment *cell = [tableView dequeueReusableCellWithIdentifier:@"pool1"];
    MomentModel *mod = [self.MomentListArr objectAtIndex:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.model = mod;
    
    return cell;
}
/* 行高 **/
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Class currentClass = [CellForMoment class];
    
    MomentModel *model = self.MomentListArr[indexPath.row];
    
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:currentClass contentViewWidth:kScreenWidth];
   }

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //限制下拉的距离为70
    
    if(scrollView.contentOffset.y<-150 && scrollView.isDragging){
        
        [scrollView setContentOffset:CGPointMake(0, -150)];
        
    }
    
    //[super scrollViewDidScroll:scrollView];
    
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
