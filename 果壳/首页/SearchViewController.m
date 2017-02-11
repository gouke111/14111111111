//
//  SearchViewController.m
//  果壳
//
//  Created by 李旺 on 2016/12/15.
//  Copyright © 2016年 我赢. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchTableViewCell.h"
#import "WebViewController.h"
@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong)NSMutableArray*buttonArray;
@property(nonatomic,strong)UITextField*textfield;
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)NSMutableArray*dataArray;
@property(nonatomic,strong)NSMutableArray*cellArray;
@property(nonatomic,strong)NSString*urlstr;
@property(nonatomic,strong)NSString*url;
@property(nonatomic,assign)int page;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _buttonArray=[NSMutableArray array];
    _cellArray=[NSMutableArray array];
    _page=1;
    self.view.backgroundColor=[UIColor whiteColor];
    _textfield=[[UITextField alloc]initWithFrame:CGRectMake(0, 0,260,30)];
    _textfield.keyboardType=UIKeyboardTypeTwitter;
    self.navigationItem.titleView=_textfield;
    UIBarButtonItem*search=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(search)];
    self.navigationItem.rightBarButtonItem=search;
    UIBarButtonItem*left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"左箭头"] style: UIBarButtonItemStyleDone target:self action:@selector(button)];
    self.navigationItem.leftBarButtonItem=left;
    _textfield.delegate=self;
    _textfield.placeholder=@"请输入关键字";
    _textfield.clearButtonMode=UITextFieldViewModeWhileEditing;
    [_textfield becomeFirstResponder];
    [self SetButton];
    //tableview
    _tableView=[[UITableView alloc]initWithFrame:ScreenFrame];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    _tableView.hidden=YES;
    
    // Do any additional setup after loading the view.
}
-(void)SetButton{
    AFHTTPSessionManager*manger=[AFHTTPSessionManager manager];
    [manger GET:@"http://apis.guokr.com/flowingboard/flowingboard.json?name=handpick_search_keywords" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray*array=responseObject[@"result"];
        NSArray*itmes=[array firstObject][@"items"];
        for(int a=0;a<itmes.count;a++){
            UIButton*button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            button.frame=CGRectMake(30, 100, 100, 100);
            [button setTitle:itmes[a][@"text"] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            button.titleLabel.font=[UIFont systemFontOfSize:25];
            [button sizeToFit];
            button.height=45;
            button.width+=2*5;
            button.layer.cornerRadius=10;
            [button setBackgroundImage:[UIImage imageNamed:@"方块"] forState:UIControlStateHighlighted];
            [button.imageView sizeToFit];
            button.layer.borderWidth=1;
            button.layer.borderColor=[UIColor greenColor].CGColor;
            
            [button addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
            if(_tableView.hidden){
            [self.view insertSubview:button atIndex:0];
            }
            [_buttonArray addObject:button];
        }
        //
        for(int a=0;a<itmes.count;a++){
            UIButton*button=_buttonArray[a];
            
            NSLog(@"%@",_buttonArray);
            if(a==0){
                button.x=20;
                button.y=100;
            }else{
                UIButton*qian=self.buttonArray[a-1];
                CGFloat leftWidth=CGRectGetMaxX(qian.frame)+10;
                CGFloat rightWidth = ScreenWidth - leftWidth;
                if(rightWidth>=button.width+10){
                    button.x=leftWidth;
                    button.y=qian.y;
                }else{
                    button.x=20;
                    button.y=CGRectGetMaxY(qian.frame)+10;
                }
            }
        }
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
-(void)button:(UIButton*)sender{
    [_cellArray removeAllObjects];
    _textfield.text=sender.titleLabel.text;
    [self search];
}
-(void)search{
    
    [_textfield resignFirstResponder];
    _urlstr=[NSString stringWithFormat:@"http://apis.guokr.com/handpick/search.json?limit=20&wd=%@",[_textfield.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    _url=_urlstr;
    [_cellArray removeAllObjects];
    _page=1;
    [self GETdata];
}
-(void)GETdata{
    AFHTTPSessionManager*manger=[AFHTTPSessionManager manager];
    [manger GET:_url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _dataArray=responseObject[@"result"];
        [_cellArray addObjectsFromArray:_dataArray];
        _tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            _url=[NSString stringWithFormat:@"%@&offset=%d",_urlstr,(_page++)*20];
            [self GETdata];
            [_tableView.mj_footer endRefreshing];
        }];
        _tableView.hidden=NO;
        [_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UINib*nib=[UINib nibWithNibName:NSStringFromClass([SearchTableViewCell class]) bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    SearchTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    SearchModel*model=[[SearchModel alloc]init];
    [model setValuesForKeysWithDictionary:_cellArray[indexPath.row]];
    cell.model=model;
    return cell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cellArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(void)button{
    [self.navigationController popViewControllerAnimated:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ContentViewController*content=[[ContentViewController alloc]init];
    content.ID=_cellArray[indexPath.row][@"id"];
        UINavigationController*nav=[[UINavigationController alloc]initWithRootViewController:content];
    [self.navigationController showDetailViewController:nav sender:nil];
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
