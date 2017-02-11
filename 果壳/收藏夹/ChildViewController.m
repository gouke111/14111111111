//
//  ChildViewController.m
//  果壳
//
//  Created by 李旺 on 2016/12/24.
//  Copyright © 2016年 我赢. All rights reserved.
//

#import "ChildViewController.h"

@interface ChildViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _urlstr=self.url;
    self.dataArray=[NSMutableArray array];
    self.cellArray=[NSMutableArray array];
    _tableView=[[UITableView alloc]initWithFrame:ScreenFrame];
    
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    

    //_access_token=[[NSUserDefaults standardUserDefaults] valueForKey:@"access_token"];
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page=1;
        self.url=self.urlstr;
        [self.cellArray removeAllObjects];
        [_tableView reloadData];
        [self GETdata:_tableView];
        
        [_tableView.mj_header endRefreshing];
    }];
    self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.url=[NSString stringWithFormat: @"%@&offset=%d",self.url,(self.page-1)*20];
        [self.cellArray removeAllObjects];
        [_tableView reloadData];
        [self GETdata:_tableView];
        
        [self.tableView.mj_footer endRefreshing];
    }];
    [self.view addSubview:_tableView];
    [_tableView.mj_header beginRefreshing];
    

    // Do any additional setup after loading the view.
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    CustomTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    Model*model=[[Model alloc]init];
    [model setValuesForKeysWithDictionary:self.cellArray[indexPath.row] ];
    cell.model=model;
    
    cell.backgroundColor=[UIColor redColor];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cellArray.count;
}
-(void)GETdata:(UITableView*)sender{
    WeakSelf;
    AFHTTPSessionManager*managerb=[AFHTTPSessionManager manager];
    [managerb GET:_url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        weakSelf.dataArray=responseObject[@"result"];
        NSLog(@"请求数据成功");
        [weakSelf.cellArray addObjectsFromArray:weakSelf.dataArray];
        [sender reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString*str=_cellArray[indexPath.row][@"style"];
    if([str isEqualToString:@"pic"]){
        return 280;
    }else if([str isEqualToString:@"article"]){
        return 180;
    }else{
        return 400;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"%@",_dataArray);
    ContentViewController*content=[[ContentViewController alloc]init];
    content.ID=[NSString stringWithFormat:@"%@",_cellArray[indexPath.row][@"id"]];
    
    UIView*cell=[tableView cellForRowAtIndexPath:indexPath];
    if(cell.height==400){
        NSData * archiveData = [NSKeyedArchiver archivedDataWithRootObject:cell];
        UIView* view = [NSKeyedUnarchiver unarchiveObjectWithData:archiveData];
        view.frame=CGRectMake(0, 0, ScreenWidth, 400);
        UIView*baiview=[[UIView alloc]initWithFrame:CGRectMake(0,360, ScreenWidth, 40)];
        baiview.backgroundColor=[UIColor whiteColor];
        [view addSubview:baiview];
        content.tableview.tableHeaderView=view;
    }
    
    UINavigationController*nav=[[UINavigationController alloc]initWithRootViewController:content];
    [self presentViewController:nav animated:YES completion:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [_tableView.mj_header beginRefreshing];
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
