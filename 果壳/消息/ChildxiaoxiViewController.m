//
//  ChildxiaoxiViewController.m
//  果壳
//
//  Created by 李旺 on 2016/12/27.
//  Copyright © 2016年 我赢. All rights reserved.
//

#import "ChildxiaoxiViewController.h"
#import "XiaoxiTableViewCell.h"

@interface ChildxiaoxiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableview;
@property(nonatomic,strong)NSString*url;
@property(nonatomic,strong)NSMutableArray*dataArray;
@property(nonatomic,strong)NSMutableArray*cellArray;
@property(nonatomic,assign)int page;
@property(nonatomic,strong)NSString*urlstr;
@end

@implementation ChildxiaoxiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"全部消息";
    self.navigationItem.leftBarButtonItem=self.navigationController.childViewControllers[0].navigationItem.leftBarButtonItem ;
    self.url=[NSString stringWithFormat:@"http://apis.guokr.com/community/notice.json?get_all=yes&access_token=%@&limit=20&descriptor=handpick_reply_at&descriptor=handpick_reply&descriptor=handpick_reply_liking",[[NSUserDefaults standardUserDefaults] valueForKey:@"access_token"]];
    self.urlstr=self.url;
    //tableview
    _dataArray=[NSMutableArray array];
    _cellArray=[NSMutableArray array];
    _tableview=[[UITableView alloc]initWithFrame:ScreenFrame ];
    _tableview.alwaysBounceHorizontal=NO;
    _tableview.backgroundColor=[UIColor grayColor];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _page=1;
    _tableview.mj_footer=[MJRefreshFooter footerWithRefreshingBlock:^{
        self.url=[NSString stringWithFormat:@"%@&offset=%d",self.urlstr,20*_page++];
        [self GETDATA];
        [_tableview.mj_footer endRefreshing];
    }];
    _tableview.mj_footer.hidden=YES;
    _tableview.mj_header=[MJRefreshHeader headerWithRefreshingBlock:^{
        _page=1;
        self.url=self.urlstr;
        [_cellArray removeAllObjects];
        [self GETDATA];
        [_tableview.mj_header endRefreshing];
    }];
    
    [self GETDATA];
    [self.view addSubview:_tableview];
    [_tableview.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}

-(void)GETDATA{
    AFHTTPSessionManager*manager=[AFHTTPSessionManager manager];
    [manager GET:_url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _dataArray=responseObject[@"result"];
        if(_dataArray.count>=20){
            _tableview.mj_footer.hidden=NO;
        }
        [_cellArray addObjectsFromArray:_dataArray];
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
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XiaoxiTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"xiaoxi"];
    XiaoxiTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"xiaoxi"];
    cell.xiaoxi.text=[NSString stringWithFormat:@"  %@",_dataArray[indexPath.row][@"content"]];
    [cell.xiaoxi sizeToFit];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-20, 10)];
    label.text = _dataArray[indexPath.row][@"content"];
    label.numberOfLines = 0;
    [label sizeToFit];
    
    return label.height+10;
   
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
