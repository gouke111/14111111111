//
//  ShouViewController.m
//  果壳
//
//  Created by 李旺 on 2016/12/24.
//  Copyright © 2016年 我赢. All rights reserved.
//

#import "ShouViewController.h"

@interface ShouViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ShouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor=[UIColor colorWithWhite:0.7 alpha:1.0];
    self.urlstr=self.url;
    NSLog(@"%@",self.url);
    self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.url=[NSString stringWithFormat:@"%@&offset=%d", self.urlstr,self.page++*20];
        [self.cellArray removeAllObjects];
        [self.tableView reloadData];
        [self GETdata:self.tableView];
        
        [self.tableView.mj_footer endRefreshing];
    }];
    
    self.tableView.mj_footer.hidden=YES;
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.url=self.urlstr;
        [self.cellArray removeAllObjects];
        [self.tableView reloadData];
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
    [model setValuesForKeysWithDictionary:self.cellArray[indexPath.row][@"pick"]];
    cell.model=model;
    cell.backgroundColor=[UIColor redColor];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString*str=self.cellArray[indexPath.row][@"pick"][@"style"];
    
    if([str isEqualToString:@"pic"]){
        return 280;
    }else if([str isEqualToString:@"article"]){
        return 180;
    }else{
        return 400;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ContentViewController*content=[[ContentViewController alloc]init];
    content.ID=[NSString stringWithFormat:@"%@",self.cellArray[indexPath.row][@"pick_id"]];
    
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
