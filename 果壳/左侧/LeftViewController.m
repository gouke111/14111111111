//
//  LeftViewController.m
//  果壳
//
//  Created by 李旺 on 2016/12/16.
//  Copyright © 2016年 我赢. All rights reserved.
//
#import "ZiliaoViewController.h"
#import "LeftViewController.h"
#import "LeftTableViewCell.h"
#import "HomeViewController.h"

#import "SetViewController.h"
#import "ShouCangViewController.h"
#import "XiaoxiViewController.h"
@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)UILabel*nicheng;
@property(nonatomic,strong)UIButton*button;
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _tableView.backgroundColor=[UIColor  colorWithRed:218/256.0 green:223/256.0 blue:226/256.0 alpha:01];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    UIView*headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    _button=[UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame=CGRectMake((ScreenWidth/2.0+50)/2.0-50, 60, 100, 100);
    [_button addTarget:self action:@selector(signup) forControlEvents:UIControlEventTouchUpInside];
    headerView.backgroundColor=_tableView.backgroundColor;
    _button.layer.cornerRadius=50;
    _button.layer.masksToBounds=YES;
    [_button setImage:[UIImage imageNamed:@"头像"]forState:UIControlStateNormal];
    _button.layer.borderWidth=1.;
    _button.layer.borderColor=[UIColor grayColor].CGColor;
    [headerView addSubview:_button];
    _nicheng=[[UILabel alloc]initWithFrame:CGRectMake(0, _button.y+_button.height, ScreenWidth/2.0, 30)];
    _nicheng.centerX=_button.centerX;
    _nicheng.text=@"点击头像登录";
    _nicheng.textAlignment=NSTextAlignmentCenter;
    [headerView addSubview:_nicheng];
    _tableView.tableHeaderView=headerView;
    UIView*footView=[[UIView alloc ]initWithFrame:CGRectMake(0, 0, ScreenWidth,300)];
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 200, ScreenWidth/2.0+50, 100)];
    
    imageView.image=[UIImage imageNamed:@"Placeholder"];
    [footView addSubview:imageView];
    _tableView.tableFooterView=footView;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(signup) name:@"denglu" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(signup) name:@"tuichu" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pingluncell:) name:@"pinglun++" object:nil];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LeftTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    LeftTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor=_tableView.backgroundColor;
    
    switch (indexPath.row) {
        case 0:
            cell.picView.image=[UIImage imageNamed:@"首页"];
            cell.title.text=@"首页";
            break;
        case 1:
            cell.picView.image=[UIImage imageNamed:@"消息2"];
            cell.title.text=@"消息";
            break;
        case 2:
            cell.picView.image=[UIImage imageNamed:@"收藏"];
            cell.title.text=@"收藏";
            break;
        case 3:
            cell.picView.image=[UIImage imageNamed:@"设置"];
            cell.title.text=@"设置";
            break;
            
        default:
            break;
    }
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        HomeViewController*home= [[HomeViewController alloc]init];
        [self SetCellVC:home title:@"果壳精选"];
    }else if (indexPath.row==1){
        XiaoxiViewController*xiaoxi= [[XiaoxiViewController alloc]init];
        
        if([[NSUserDefaults standardUserDefaults] valueForKey:@"access_token"]==nil){
            [self signup];
            [self annimation:self.sideMenuViewController.contentViewController];
        }else{
            [self SetCellVC:xiaoxi title:@"消息"];
            xiaoxi.access_token=[[NSUserDefaults standardUserDefaults] valueForKey:@"access_token"];
        }
    }else if(indexPath.row==2){
        ShouCangViewController*shoucang=[[ShouCangViewController alloc]init];
        if([[NSUserDefaults standardUserDefaults] valueForKey:@"access_token"]==nil){
            [self signup];
            [self annimation:self.sideMenuViewController.contentViewController];
        }else{
            shoucang.access_token=[[NSUserDefaults standardUserDefaults] valueForKey:@"access_token"];
            [self SetCellVC:shoucang title:@"收藏夹"];
        }
        
        
    }else{
        [self SetCellVC:[[SetViewController alloc]init] title:@"设置"];
    }
    [self.sideMenuViewController hideMenuViewController];
}
-(void)annimation:(UIViewController*)sender{
    UILabel  * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    label.backgroundColor=[UIColor lightGrayColor];
    label.layer.cornerRadius=10;
    label.layer.masksToBounds=YES;
    label.text = @"请先登录";
    label.textColor=[UIColor lightTextColor];
    [label sizeToFit];
    label.width+=20;
    label.height+=10;
    label.textAlignment=NSTextAlignmentCenter;
    label.center=sender.view.center;
    [sender.view addSubview:label];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:3.0];
    
    label.alpha =0.0;
    [UIView commitAnimations];
}
-(void)SetCellVC:(UIViewController*)vc title:(NSString*)title{
    UINavigationController*nav=[[UINavigationController alloc]initWithRootViewController:vc];
    nav.navigationBar.tintColor=[UIColor whiteColor];
    nav.navigationBar.backgroundColor=[UIColor greenColor];
    UIBarButtonItem*Left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"抽屉"] style:UIBarButtonItemStyleDone target:self action:@selector(left)];
    
    nav.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};
    vc.title=title;
    vc.view.backgroundColor=[UIColor whiteColor];
    vc.navigationItem.leftBarButtonItem=Left;
    
    self.sideMenuViewController.contentViewController=nav;
    
}
-(void)pingluncell:(NSNotification*)sender{
    HomeViewController*home= [[HomeViewController alloc]init];
    [self SetCellVC:home title:@"果壳精选"];
    ContentViewController*content=[[ContentViewController alloc]init];
    content.ID=[NSString stringWithFormat:@"%@",sender.object];
    //NSLog(@"%@1111111",content.ID);
    UINavigationController*nav=[[UINavigationController alloc]initWithRootViewController:content];
    [self.sideMenuViewController.contentViewController presentViewController:nav animated:YES completion:nil];
}
-(void)left{
    [self.sideMenuViewController presentLeftMenuViewController];
}
//登录
-(void)signup{
    SignupViewController*signvc=[[SignupViewController alloc]init];
    if([[NSUserDefaults standardUserDefaults] valueForKey:@"access_token"]==nil){
        [self SetCellVC:signvc title:@"登录"];
        _nicheng.text=@"请先登录";
        [_button setImage:[UIImage imageNamed:@"头像"]forState:UIControlStateNormal];
    }else{
        [self SetCellVC:[[ZiliaoViewController alloc]init] title:@"账户信息"];
        AFHTTPSessionManager*manager=[AFHTTPSessionManager manager];
        NSString*Str=[[NSUserDefaults standardUserDefaults]valueForKey:@"ukey"];
        [manager GET:[NSString stringWithFormat:@"http://apis.guokr.com/community/user/%@.json",Str] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSURL*url=[NSURL URLWithString:responseObject[@"result"][@"avatar"][@"large"]];
        _nicheng.text=responseObject[@"result"][@"nickname"];
                [_button sd_setImageWithURL:url forState:UIControlStateNormal];
            } failure:nil];

    }
    [self.sideMenuViewController hideMenuViewController];
}
-(void)selseted:(NSNotification*)sender{
    if([sender.object isEqualToString:@"登录"])
    {
        [self signup];
    }else if([sender.object isEqualToString:@"收藏夹"])
    {
        [self tableView:_tableView didSelectRowAtIndexPath:[NSIndexPath indexPathWithIndex:2]];
    }else if([sender.object isEqualToString:@"消息"])
    {
        [self tableView:_tableView didSelectRowAtIndexPath:[NSIndexPath indexPathWithIndex:1]];
    }

    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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
