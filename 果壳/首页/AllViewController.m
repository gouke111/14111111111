//
//  AllViewController.m
//  果壳
//
//  Created by 李旺 on 2016/12/18.
//  Copyright © 2016年 我赢. All rights reserved.
//

#import "AllViewController.h"
#import "Model.h"
#import "ContentViewController.h"
#import "WebViewController.h"

@interface AllViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)NSString*url;
@property(nonatomic,strong)NSMutableArray*dataArray;
@property(nonatomic,strong)NSMutableArray*cellArray;
@property(nonatomic,strong)NSMutableArray*imagearticleArray;
@property(nonatomic,strong)NSMutableArray* imageurlstr;

@property(nonatomic,strong)NSMutableArray*imagetitlestr;

@property(nonatomic,assign)int page;
@property(nonatomic,strong)SDCycleScrollView*cycleView;
@property(nonatomic,strong)NSString*urlstr;
@end

@implementation AllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray=[NSMutableArray array];
    _cellArray=[NSMutableArray array];
    //----tableView
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,ScreenHeight-90)];
    _tableView.dataSource=self;
    _tableView.delegate=self;
     _page=1;
    
    _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self geturlstr];
        _url=_urlstr;
        [_cellArray removeAllObjects];
        [self GETdata:_tableView];
        _page=1;
        [self.tableView.mj_header endRefreshing];
    }];
    _tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self geturlstr];
        _url=[NSString stringWithFormat: @"%@&offset=%d",_urlstr,20*_page++];
        [self GETdata:_tableView];
        [self.tableView.mj_footer endRefreshing];
    }];
    
    //---轮播图
    _cycleView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 180) delegate:self placeholderImage:nil];
    _cycleView.imageURLStringsGroup=_imageurlstr;
    _cycleView.pageControlAliment=SDCycleScrollViewPageContolAlimentRight;
    _tableView.tag=110;
    _tableView.tableHeaderView=_cycleView;
    [self.view addSubview:_tableView];
    [_tableView.mj_header beginRefreshing];
    [self GETCycle];
    
   
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
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    CustomTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    Model*model=[[Model alloc]init];
    
    [model setValuesForKeysWithDictionary: _cellArray[indexPath.row] ];
    
    cell.model=model;

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

-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    ContentViewController*content=[[ContentViewController alloc]init];
    content.ID=_imagearticleArray[index];
    UINavigationController*nav=[[UINavigationController alloc]initWithRootViewController:content];
    [self.navigationController showDetailViewController:nav sender:nil];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ContentViewController*content=[[ContentViewController alloc]init];
    content.ID=_cellArray[indexPath.row][@"id"];
     NSString*str=_cellArray[indexPath.row][@"style"];
    
    if([str isEqualToString:@"calendar"]){
        UIView*cell=[tableView cellForRowAtIndexPath:indexPath];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)GETdata:(UITableView*)sender{
    AFHTTPSessionManager*manager=[AFHTTPSessionManager manager];
    [manager GET:_url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _dataArray=responseObject[@"result"];
        [_cellArray addObjectsFromArray:_dataArray];
        [_tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void)GETCycle{
    AFHTTPSessionManager*manager=[AFHTTPSessionManager manager];
    [manager GET:@"http://apis.guokr.com/flowingboard/item/handpick_carousel.json" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray*mutable=responseObject[@"result"];
        _imageurlstr=[NSMutableArray array];
        _imagetitlestr=[NSMutableArray array];
        _imagearticleArray=[NSMutableArray array];
        for (NSDictionary*dic in mutable) {
            [_imageurlstr addObject:dic[@"picture"]];
            [_imagetitlestr addObject:dic[@"custom_title"]];
            [_imagearticleArray addObject:dic[@"article_id"]];
        }
        _cycleView.imageURLStringsGroup=_imageurlstr;
        _cycleView.titlesGroup=_imagetitlestr;
        

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
