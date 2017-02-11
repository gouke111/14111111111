//
//  ZanViewController.m
//  果壳
//
//  Created by 李旺 on 2016/12/25.
//  Copyright © 2016年 我赢. All rights reserved.
//

#import "ZanViewController.h"

@interface ZanViewController ()

@end

@implementation ZanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.url=[NSString stringWithFormat:@"%@&offset=%d", self.urlstr,self.page++*20];
        [self GETdata:self.tableView];
        
        [self.tableView.mj_footer endRefreshing];
    }];
    self.tableView.mj_footer.hidden=YES;
    
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page=1;
        [self GETdata:self.tableView];
        if(self.dataArray.count>=20){
            self.tableView.mj_footer.hidden=NO;
        }
        [self.tableView.mj_header endRefreshing];
    }];
    [self.tableView.mj_header beginRefreshing];

    // Do any additional setup after loading the view.
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    CustomTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    Model*model=[[Model alloc]init];
    [model setValuesForKeysWithDictionary:self.cellArray[indexPath.row]];
    cell.model=model;
    
    cell.backgroundColor=[UIColor redColor];
    return cell;
}
-(void)GETdata:(UITableView*)sender{
    WeakSelf;
    AFHTTPSessionManager*managerb=[AFHTTPSessionManager manager];
    [managerb GET:self
     .url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    weakSelf.dataArray=responseObject[@"result"];
        NSLog(@"请求数据成功");
        NSString*str=[NSString stringWithFormat:@"http://apis.guokr.com/handpick/v2/article.json?access_token=%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"access_token"]];
        for (NSDictionary*dic in self.dataArray) {
            str=[str stringByAppendingString: [NSString stringWithFormat:@"&pick_id=%@",dic[@"pick_id"]]];
        }
        [self GETcell:str];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

-(void)GETcell:(NSString*)url{
    AFHTTPSessionManager*managetr=[AFHTTPSessionManager manager];
    [managetr GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    self.cellArray=responseObject[@"result"];
        [self.tableView reloadData];
    } failure:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString*str=self.cellArray[indexPath.row][@"style"];
    if([str isEqualToString:@"pic"]){
        return 280;
    }else if([str isEqualToString:@"article"]){
        return 180;
    }else{
        return 400;
    }
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
