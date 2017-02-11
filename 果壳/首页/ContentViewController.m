//
//  ContentViewController.m
//  果壳
//
//  Created by 李旺 on 2016/12/15.
//  Copyright © 2016年 我赢. All rights reserved.
//

#import "ContentViewController.h"
#import "PinlunTableViewCell.h"
#import "PinlunModel.h"
#import "PinglunViewController.h"


@interface ContentViewController ()<UIWebViewDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray*dataArray;
@property(nonatomic,strong)NSString*urlstr;
@property(nonatomic,strong)UIButton*shoucang;
@end

@implementation ContentViewController
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(instancetype)init{
    if(self=[super init]){
        _tableview=[[UITableView alloc]initWithFrame:ScreenFrame];
        
    }
    return self;
}

-(void)setID:(NSString *)ID{
    _ID=ID;
    AFHTTPSessionManager*manager=[AFHTTPSessionManager manager];
    NSString*str=[[NSUserDefaults standardUserDefaults]valueForKey:@"access_token"];
    if (str ==nil) {
        _collect=NO;
    }else{
        NSString*url=[NSString stringWithFormat:@"http://apis.guokr.com/handpick/v2/article.json?access_token=%@&pick_id=%@",str,ID];
        
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            _shoucang=[UIButton buttonWithType:UIButtonTypeCustom];
            _shoucang.frame=CGRectMake(0, 0, 50, 50);
            [_shoucang setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal ];
            [_shoucang setImage:[UIImage imageNamed:@"collected"] forState:UIControlStateSelected ];
            [_shoucang addTarget:self action:@selector(shoucang:) forControlEvents:UIControlEventTouchUpInside];
            
            self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:_shoucang];
            NSDictionary*dic=responseObject[@"result"][0];
        _collect=[dic[@"current_user_has_collected"] intValue];
            NSLog(@"@@@@@@%@@@@@@@@@",responseObject);
            switch (_collect) {
                case 0:
                    _shoucang.selected=NO;
                    break;
                case 1:
                    _shoucang.selected=YES;
                    break;
                default:
                    break;
            }
            _shoucang.selected=_collect;
        } failure:nil];

    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"";
    _dataArray=[NSMutableArray array];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    
    [self.view addSubview:_tableview];
    _url=[NSString stringWithFormat:@"http://jingxuan.guokr.com/pick/v2/%@/",_ID];
    [self geturlstr];
    
    [self GETdata:_tableview];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(fanhui)];
    
    self.navigationController.navigationBar.backgroundColor=[UIColor whiteColor];
    
    _web=[[UIWebView alloc]initWithFrame:ScreenFrame];
        NSURL*URL=[NSURL URLWithString:_url];
    _web.scrollView.bounces=NO;
    _web.delegate=self;
    _web.scrollView.delegate=self;
    NSURLRequest*request=[NSURLRequest requestWithURL:URL];
    [_web loadRequest:request];

    if(_tableview.tableHeaderView==nil){
        _tableview.tableHeaderView=_web;
    }
    
   // [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pinglunzan:) name:@"pinglunzan" object:nil];
   
    // Do any additional setup after loading the view.
}
-(void)geturlstr{
    NSString*access_token=[[NSUserDefaults standardUserDefaults]valueForKey:@"access_token"];
    if(access_token!=nil){
        _urlstr=[NSString stringWithFormat:@"http://apis.guokr.com/handpick/reply.json?limit=5&article_id=%@&access_token=%@",_ID,access_token];
    }else{
        _urlstr=[NSString stringWithFormat:@"http://apis.guokr.com/handpick/reply.json?limit=5&article_id=%@",_ID];
        
    }
    _cellurl=_urlstr;
}
-(void)pinluncell:(NSNotification*)sender{
    if([[NSUserDefaults standardUserDefaults]valueForKey:@"access_token"]==nil){
        [[NSNotificationCenter defaultCenter]postNotificationName:@"zancell" object:nil];
    }
}

-(void)alert:(NSString*)message{
    UIAlertController*alert=[UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*Action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:Action];
    [self showDetailViewController:alert sender:nil];
}
-(void)shoucang:(UIButton*)sender{
    if([[NSUserDefaults standardUserDefaults]valueForKey:@"access_token"]==nil){
        [self alert:@"请先登录"];
    }else{
        sender.selected=!sender.selected;
        AFHTTPSessionManager*manager=[AFHTTPSessionManager manager];
        NSString*str=[[NSUserDefaults standardUserDefaults] valueForKey:@"access_token"];
        str=[NSString stringWithFormat:@"http://apis.guokr.com/handpick/collect.json?access_token=%@&pick_id=%@",str,_ID];
        //收藏
        if(sender.selected){
            [manager POST:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self alert:@"收藏成功"];
            } failure:nil];
        }else{
            //取消收藏
            [manager DELETE:str parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self alert:@"取消收藏成功"];
            } failure:nil];
            
        }
        
    }
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    _web.height=scrollView.height;
}

-(void)fanhui{
    
[self dismissViewControllerAnimated:YES completion:nil];
}
-(void)GETdata:(UITableView*)sender{
    AFHTTPSessionManager*manager=[AFHTTPSessionManager manager];
    [manager GET:_cellurl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _dataArray=responseObject[@"result"];
        NSLog(@"%@",_dataArray);
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(0, 0, ScreenWidth, 40);
        [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        if(_dataArray.count==0){
            [button setTitle:@"暂无评论" forState:UIControlStateNormal];
        }else{
            [button setTitle:@"查看全部评论" forState:UIControlStateNormal];
        }
        [button addTarget:self action:@selector(showall) forControlEvents:UIControlEventTouchUpInside];
        _tableview.tableFooterView=button;
        
        [sender reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
-(void)showall{
    if([[NSUserDefaults standardUserDefaults]valueForKey:@"access_token"]==nil){
        UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"请先登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*Action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:Action];
        [self showDetailViewController:alert sender:nil];
        
    }else{
        PinglunViewController*pinglun=[PinglunViewController new];
        pinglun.ID=_ID;
        [self showViewController:pinglun sender:nil];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PinlunTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    PinlunTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    PinlunModel*model=[[PinlunModel alloc]init];
    [model setValuesForKeysWithDictionary: _dataArray[indexPath.row]];
    cell.model=model;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //
    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth-60, 0)];
    label.text=_dataArray[indexPath.row][@"content"];
    label.numberOfLines=0;
    label.font=[UIFont systemFontOfSize:17];
    [label sizeToFit];
    
    return label.height+80;
}
-(void)viewWillAppear:(BOOL)animated{
    [self geturlstr];
    
    [self GETdata:_tableview];
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
