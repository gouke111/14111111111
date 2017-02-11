//
//  PinglunViewController.m
//  果壳
//
//  Created by 李旺 on 2017/1/9.
//  Copyright © 2017年 我赢. All rights reserved.
//

#import "PinglunViewController.h"
#import "PinlunTableViewCell.h"
#import "PinlunModel.h"

@interface PinglunViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong)NSMutableArray*dataArray;
@property(nonatomic,strong)NSMutableArray*cellarray;
@property(nonatomic,strong)UITableView*tableview;
@property(nonatomic,strong)UITextField*textfield;
@property(nonatomic,strong)NSString*url;
@property(nonatomic,strong)NSString*urlstr;
@property(nonatomic,assign)int page;

@end

@implementation PinglunViewController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _page=1;
    self.title=@"评论";
     _tableview=[[UITableView alloc]initWithFrame:ScreenFrame style:UITableViewStyleGrouped];
    _dataArray=[NSMutableArray array];
    _cellarray=[NSMutableArray array];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _url=[NSString stringWithFormat:@"http://apis.guokr.com/handpick/reply.json?access_token=%@&limit=20&article_id=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"access_token"],_ID];
    NSLog(@"%@",_url);
    _urlstr=_url;
//    _tableview.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
////        _url=_urlstr;
//        [_cellarray removeAllObjects];
//        [self GETdata:_tableview];
//        _page=1;
//        [self.tableview.mj_header endRefreshing];
//    }];
//    _tableview.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        _url=[NSString stringWithFormat: @"%@&offset=%d",_urlstr,20*_page++];
//        [self GETdata:_tableview];
//        [self.tableview.mj_footer endRefreshing];
//    }];
    _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableview];
    [self GETdata:_tableview];
    _textfield=[[UITextField alloc]initWithFrame:CGRectMake(0,ScreenHeight-45, ScreenWidth, 45)];
    _textfield.delegate=self;
    _textfield.backgroundColor=[UIColor lightTextColor];
    _textfield.layer.borderColor=[UIColor blackColor].CGColor;
    _textfield.layer.borderWidth=1.0;
    _textfield.layer.cornerRadius=10;
    _textfield.layer.masksToBounds=YES;
    _textfield.clearsOnBeginEditing=YES;
    UIButton*fasong=[UIButton buttonWithType:UIButtonTypeCustom];
    fasong.frame=CGRectMake(0, 0, 60, 45);
    fasong.backgroundColor=[UIColor redColor];
    [fasong setTitle:@"发送" forState:UIControlStateNormal];
    [fasong addTarget:self action:@selector(fasong) forControlEvents:UIControlEventTouchUpInside];
    _textfield.rightView=fasong;
    _textfield.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 1)];
    _textfield.rightViewMode=UITextFieldViewModeAlways;
    _textfield.leftViewMode=UITextFieldViewModeAlways;
    [self.view addSubview:_textfield];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tanchu:) name: UIKeyboardDidChangeFrameNotification object:nil];
    // Do any additional setup after loading the view.
}
-(void)fasong{
    [_textfield resignFirstResponder];
    AFHTTPSessionManager*manager=[AFHTTPSessionManager manager];
    NSString*url=[NSString stringWithFormat:@"http://apis.guokr.com/handpick/reply.json?access_token=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"access_token"]];
   
    NSDictionary *params = @{
    @"content" : [_textfield.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]],
    @"article_id" : _ID
    };
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self GETdata:_tableview];
    } failure:nil];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_textfield resignFirstResponder];
    
    return YES;
}

-(void)tanchu:(NSNotification*)sender{
    NSDictionary *userInfo = [sender userInfo ];
    NSValue *value = [userInfo objectForKey : UIKeyboardFrameEndUserInfoKey ];
    CGFloat keyBoardEndY = value. CGRectValue . origin . y ;  // 得到键盘弹出后的键盘视图所在 y 坐标
    NSNumber *duration = [userInfo objectForKey : UIKeyboardAnimationDurationUserInfoKey ];
    NSNumber *curve = [userInfo objectForKey : UIKeyboardAnimationCurveUserInfoKey ];

    // 添加移动动画，使视图跟随键盘移动
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:[curve intValue]];
    [UIView setAnimationDuration:[duration intValue]];
    _textfield.y=keyBoardEndY-45;
    
    
    [UIView commitAnimations];
    
}
-(void)GETdata:(UITableView*)sender{
    AFHTTPSessionManager*manager=[AFHTTPSessionManager manager];
    [manager GET:_url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [_cellarray removeAllObjects];
        _dataArray=responseObject[@"result"];
        [_cellarray addObjectsFromArray:_dataArray];
        [sender reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PinlunTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    PinlunTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    PinlunModel*model=[[PinlunModel alloc]init];
    [model setValuesForKeysWithDictionary: _cellarray[indexPath.row]];
    cell.model=model;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cellarray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //
    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth-60, 0)];
    label.text=_cellarray[indexPath.row][@"content"];
    label.numberOfLines=0;
    label.font=[UIFont systemFontOfSize:17];
    [label sizeToFit];
    
    return label.height+80;
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
