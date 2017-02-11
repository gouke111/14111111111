//
//  XiaoxiViewController.m
//  果壳
//
//  Created by 李旺 on 2016/12/16.
//  Copyright © 2016年 我赢. All rights reserved.
//

#import "XiaoxiViewController.h"
#import "ChildxiaoxiViewController.h"

@interface XiaoxiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIButton*lishi;
@property(nonatomic,strong)UIImageView*picview;
@property(nonatomic,strong)UITableView*tableview;
@property(nonatomic,strong)NSMutableArray*dataArray;
@property(nonatomic,strong)NSString*url;
@end

@implementation XiaoxiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //tableview
    _dataArray=[NSMutableArray array];
    _tableview=[[UITableView alloc]initWithFrame:ScreenFrame];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _picview=[[UIImageView alloc]initWithFrame:ScreenFrame];
    _picview.height=ScreenHeight-100;
    _picview.image=[UIImage imageNamed:@"无消息"];
    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    label.text=@"暂无新消息";
    [label sizeToFit];
    label.centerX=_picview.centerX;
    label.centerY=_picview.height-100;
    [_picview addSubview:label];
    [self.view addSubview:_tableview];
    _lishi=[UIButton buttonWithType:UIButtonTypeCustom];
    _lishi.frame=CGRectMake(0, 0, 100, 100);
    [_lishi setTitle:@"查看历史消息" forState:UIControlStateNormal];
    [_lishi sizeToFit];
    _lishi.backgroundColor=[UIColor redColor];
    [_lishi addTarget:self action:@selector(lishi:) forControlEvents:UIControlEventTouchUpInside];
    _tableview.tableFooterView=_lishi;

    _url=[NSString stringWithFormat:@"http://apis.guokr.com/community/notice.json?access_token=%@&offset=0&limit=20&descriptor=handpick_reply_at&descriptor=handpick_reply&descriptor=handpick_reply_liking",[[NSUserDefaults standardUserDefaults] valueForKey:@"access_token"]];
    [self GETDATA];
    // Do any additional setup after loading the view.
}
-(void)lishi:(UIButton*)sender{
    ChildxiaoxiViewController*child=[[ChildxiaoxiViewController alloc]init];
    [self showViewController:child sender:nil];
}
-(void)GETDATA{
    AFHTTPSessionManager*manager=[AFHTTPSessionManager manager];
    [manager GET:_url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _dataArray=responseObject[@"result"];
        if(_dataArray.count==0){
            _tableview.tableHeaderView=_picview;
        }else{
             _tableview.tableHeaderView=nil;
        }
        [_tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*Cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    Cell.textLabel.text=_dataArray[indexPath.row][@"content"];
    Cell.textLabel.numberOfLines=0;
    [Cell.textLabel sizeToFit];
    return Cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSString*str=_dataArray[indexPath.row][@"content"];
    return 100;
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
