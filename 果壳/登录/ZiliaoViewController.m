//
//  ZiliaoViewController.m
//  果壳
//
//  Created by 李旺 on 2016/12/21.
//  Copyright © 2016年 我赢. All rights reserved.
//

#import "ZiliaoViewController.h"

@interface ZiliaoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIButton*tuichu;

@end

@implementation ZiliaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem*Left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"抽屉"] style:UIBarButtonItemStyleDone target:self action:@selector(left)];
    self.title=@"资料";
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.leftBarButtonItem=Left;
    
    _tuichu=[UIButton buttonWithType:UIButtonTypeCustom];
    _tuichu.frame=CGRectMake(20, 100, ScreenWidth-40, 45);
    
    [_tuichu setTitle:@"退出登录" forState:UIControlStateNormal];
    _tuichu.backgroundColor=[UIColor grayColor];
    
    [_tuichu addTarget:self action:@selector(tuichu:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_tuichu];
    
    
    
    
    //
    UIButton*text=[UIButton buttonWithType:UIButtonTypeCustom];
    text.frame=CGRectMake(20, 200, ScreenWidth-40, 45);
    
    [text setTitle:@"text" forState:UIControlStateNormal];
    text.backgroundColor=[UIColor grayColor];
    
    [text addTarget:self action:@selector(text) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view.
}
-(void)left{
    [self.sideMenuViewController presentLeftMenuViewController];
}
-(void)tuichu:(UIButton*)sender{
   [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"access_token"];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"tuichu" object:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor=[UIColor whiteColor];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
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
