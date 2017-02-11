//
//  SuperViewController.m
//  果壳
//
//  Created by 李旺 on 2016/12/18.
//  Copyright © 2016年 我赢. All rights reserved.
//

#import "SuperViewController.h"
#import "Model.h"
#import "ContentViewController.h"

@interface SuperViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSString*url;
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)NSMutableArray*dataArray;
@property(nonatomic,strong)NSMutableArray*cellArray;
@property(nonatomic,assign)int page;
@property(nonatomic,strong)NSString*urlstr;
@end

@implementation SuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _page=1;
    _dataArray=[NSMutableArray array];
    _cellArray=[NSMutableArray array];
    _tableView=[[UITableView alloc]initWithFrame:ScreenFrame];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    
    _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page=1;
        [self geturlstr];
        _url=[NSString stringWithFormat:@"%@&category=%@",_urlstr,_category];
        [_cellArray removeAllObjects];
        [self GETdata:_tableView];
        
        [_tableView.mj_header endRefreshing];
    }];
    _tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _url=[NSString stringWithFormat: @"%@&offset=%d&category=%@",Home,20*_page++,_category];
        [self GETdata:_tableView];
        [_tableView.mj_footer endRefreshing];
    }];
    [self.view addSubview:_tableView];
    [_tableView.mj_header beginRefreshing];
    
   
    //
    
    // Do any additional setup after loading the view.
}
-(void)geturlstr{
    NSString*access_token=[[NSUserDefaults standardUserDefaults]valueForKey:@"access_token"];
    if(access_token!=nil){
        _urlstr=[NSString stringWithFormat:@"http://apis.guokr.com/handpick/v2/article.json?retrieve_type=by_offset&limit=20&ad=1&access_token=%@",access_token];
    }else{
        _urlstr=@"http://apis.guokr.com/handpick/v2/article.json?retrieve_type=by_offset&limit=20&ad=1";
    }
}

-(void)GETdata:(UITableView*)sender{
    AFHTTPSessionManager*managerb=[AFHTTPSessionManager manager];
    [managerb GET:_url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _dataArray=responseObject[@"result"];
        NSLog(@"请求数据成功");
        [_cellArray addObjectsFromArray:_dataArray];
        [sender reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    CustomTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    Model*model=[[Model alloc]init];
    [model setValuesForKeysWithDictionary: _cellArray[indexPath.row] ];
    cell.model=model;
    cell.fenlei.hidden=YES;
    cell.backgroundColor=[UIColor redColor];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cellArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString*str=_cellArray[indexPath.row][@"style"];
    if([str isEqualToString:@"pic"]){
        return 300;
    }else if([str isEqualToString:@"article"]){
        return 200;
    }else{
        return 400;
    }
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ContentViewController*content=[[ContentViewController alloc]init];
    content.ID=_cellArray[indexPath.row][@"id"];
    UINavigationController*nav=[[UINavigationController alloc]initWithRootViewController:content];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
