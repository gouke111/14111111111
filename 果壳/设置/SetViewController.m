//
//  SetViewController.m
//  果壳
//
//  Created by 李旺 on 2016/12/16.
//  Copyright © 2016年 我赢. All rights reserved.
//
#import "GuanyuViewController.h"
#import "SetViewController.h"
#import "SetTableViewCell.h"
#import "FankuiViewController.h"
#import  "WebViewController.h"

@interface SetViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableView;
@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView=[[UITableView alloc]initWithFrame:ScreenFrame style:UITableViewStyleGrouped];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.scrollEnabled=NO;
    [self.view addSubview:_tableView];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==1){
        if(indexPath.row==0){
            FankuiViewController*fankui=[[FankuiViewController alloc]init];
            [self.navigationController showViewController:fankui sender:nil];
        }else{
            GuanyuViewController*guanyu=[[GuanyuViewController alloc]init];
            [self.navigationController showViewController:guanyu sender:nil];
        }
    }else{
        if(indexPath.row==2){
            [self clearcaches];
            [tableView reloadData];
        }
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UINib*nib=[UINib nibWithNibName:NSStringFromClass([SetTableViewCell class]) bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:@"cell1"];
    SetTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if(indexPath.section==0){
    switch (indexPath.row) {
//        case 0:
//            cell.title.text=@"夜间模式";
//            cell.subtitle.hidden=YES;
//            break;
        case 0:
            cell.title.text=@"自动离线下载";
            cell.subtitle.text=@"WIFI环境自动下载最新20篇文章供离线阅读";
            break;
//        case 2:
//            cell.title.text=@"大字体";
//            cell.subtitle.hidden=YES;
//            break;
        case 1:
            cell.title.text=@"评论消息提醒";
            cell.subtitle.hidden=YES;
            break;
        case 2:
            cell.title.text=@"清理缓存";
            cell.subtitle.hidden=YES;
            cell.swith.hidden=YES;
            cell.daxiao.hidden=NO;
        cell.daxiao.text=[self Getdaxiao];
            break;
        default:
            break;
    }
    }else{
        switch (indexPath.row) {
            case 0:
                cell.title.text=@"意见反馈";
                cell.subtitle.hidden=YES;
                cell.swith.hidden=YES;
                break;
            case 1:
                cell.title.text=@"关于我们";
                
                cell.subtitle.hidden=YES;
                cell.swith.hidden=YES;
                break;
            default:
                break;
        }
    }
    
    return cell;
    
}
-(NSString*)path{
    // 获取Caches目录路径
    NSString *filePath= [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask,YES) firstObject];
    
    return filePath;
}

-(NSString*)Getdaxiao{
    NSString *filePath=[self path];
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if (![manager fileExistsAtPath :filePath]) return @"0 B" ;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :filePath] objectEnumerator ];
    
    NSString * fileName;
    
    long long folderSize = 0 ;
    
    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){
        
        NSString * fileAbsolutePath = [filePath stringByAppendingPathComponent :fileName];
        
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
        
    }
    
    if(folderSize<1024){
    return [NSString stringWithFormat:@"%lld B",folderSize];
    }else if(folderSize>=1024&&folderSize<1024*1024){
      return [NSString stringWithFormat:@"%.2f KB",folderSize/1024.0];
    }else if(folderSize>=1024*1024&&folderSize<1024*1024*1024){
        return [NSString stringWithFormat:@"%.2f MB",folderSize/1024.0/1024.0];
    }else{
       return [NSString stringWithFormat:@"%.2f GB",folderSize/1024.0/1024.0/1024.0];
    }
    
    
    
}

- ( long long ) fileSizeAtPath:( NSString *) filePath{
    
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if ([manager fileExistsAtPath :filePath]){
        
        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize ];
    }
    
    return 0 ;
    
}
-(void)clearcaches{
    NSString *filePath=[self path];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    [fileManager removeItemAtPath:filePath error:nil];
    [self Getdaxiao];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return 3;
    }else{
        return 2;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==1){
        return 20;
        
    }else{
        return 0.1;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
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
