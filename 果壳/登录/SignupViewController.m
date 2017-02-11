//
//  SignupViewController.m
//  果壳
//
//  Created by 李旺 on 2016/12/16.
//  Copyright © 2016年 我赢. All rights reserved.
//



//由于验证码原因 请直接点击登录按钮跳转到网页登录
//第三方登录应用不符 只是跳转;

#import "SignupViewController.h"
#import "ZiliaoViewController.h"


@interface SignupViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField* zhanghutextfield;
@property(nonatomic,strong)UITextField*passwordtextfield;
@property(nonatomic,strong)UITextField*yanzhengtextfield;
@property(nonatomic,strong)NSMutableArray*dataArray;
@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"登录";

    
    //账户------------------
    _zhanghutextfield=[[UITextField alloc]init];
    
    _zhanghutextfield.layer.borderWidth=1.;
    _zhanghutextfield.placeholder=@"手机号或果壳网账户邮箱";
    _zhanghutextfield.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    _zhanghutextfield.leftViewMode=UITextFieldViewModeAlways;
    [self.view addSubview:_zhanghutextfield];
    [_zhanghutextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@80);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.equalTo(@40);
    }];
    //-密码-----------------------
    _passwordtextfield=[[UITextField alloc]init];
    _passwordtextfield.layer.borderWidth=1.0;
    _passwordtextfield.placeholder=@"密码";
    _passwordtextfield.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    _passwordtextfield.leftViewMode=UITextFieldViewModeAlways;
    UIButton*losePwd=[UIButton buttonWithType:UIButtonTypeCustom];
    [losePwd setTitle:@"忘记密码?" forState:UIControlStateNormal];
    losePwd.tag=110;
    [losePwd addTarget:self action:@selector(buttonWEB:) forControlEvents:UIControlEventTouchUpInside];
    [losePwd sizeToFit];
    losePwd.width+=10;
    [losePwd setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    _passwordtextfield.rightView=losePwd;
    _passwordtextfield.rightViewMode=UITextFieldViewModeAlways;
    [self.view addSubview:_passwordtextfield];
    [_passwordtextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_zhanghutextfield.mas_bottom).offset(20);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.equalTo(@40);
    }];
    //-验证码-----
    _yanzhengtextfield=[[UITextField alloc]init];
    _yanzhengtextfield.layer.borderWidth=1.0;
    _yanzhengtextfield.placeholder=@"验证码";
    _yanzhengtextfield.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    _yanzhengtextfield.leftViewMode=UITextFieldViewModeAlways;
    UIView*right=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 130, 40)];
    UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(40, 5, 80, 30)];
    imageview.backgroundColor=[UIColor lightGrayColor];
    imageview.tag=110;
    [right addSubview:imageview];
    UIButton*shuaxin=[UIButton buttonWithType:UIButtonTypeCustom];
    [shuaxin addTarget:self action:@selector(GetYanzhengMa:) forControlEvents:UIControlEventTouchUpInside];
    shuaxin.frame=CGRectMake(0, 0, 40, 40);
    [shuaxin setImage:[UIImage imageNamed:@"刷新"] forState:UIControlStateNormal];
    [right addSubview:shuaxin];
    _yanzhengtextfield.rightView=right;
    _yanzhengtextfield.rightViewMode=UITextFieldViewModeAlways;
    [self.view addSubview:_yanzhengtextfield];
    [_yanzhengtextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwordtextfield.mas_bottom).offset(20);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.equalTo(@40);
    }];
    //labels&buttons
    UILabel*chakan=[[UILabel alloc]initWithFrame:CGRectMake(10, 250, 40, 30)];
    chakan.text=@"查看";
    chakan.font=[UIFont systemFontOfSize:15];
    chakan.textColor=[UIColor grayColor];
    [chakan sizeToFit];
    [self.view addSubview:chakan];
    UIButton*fuwu=[UIButton buttonWithType:UIButtonTypeCustom];
    fuwu.frame=CGRectMake(chakan.x+chakan.width, chakan.y, 130, 30);
    [fuwu setTitle:@"<<用户服务协议>>" forState:UIControlStateNormal];
    [fuwu setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    fuwu.titleLabel.font=[UIFont systemFontOfSize:15];
    [fuwu sizeToFit];
    fuwu.centerY=chakan.centerY;
    fuwu.tag=111;
    [fuwu addTarget:self action:@selector(buttonWEB:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fuwu];
    UILabel*ji=[[UILabel alloc]initWithFrame:CGRectMake(fuwu.x+fuwu.width, chakan.y, 40, 30)];
    ji.text=@"及";
    ji.font=[UIFont systemFontOfSize:15];
    ji.textColor=[UIColor grayColor];
    [ji sizeToFit];
    [self.view addSubview:ji];
    UIButton*yinsi=[UIButton buttonWithType:UIButtonTypeCustom];
    yinsi.frame=CGRectMake(ji.x+ji.width, ji.y, 130, 30);
    [yinsi setTitle:@"<<隐私条款>>" forState:UIControlStateNormal];
    [yinsi setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    yinsi.titleLabel.font=[UIFont systemFontOfSize:15];
    [yinsi sizeToFit];
    yinsi.centerY=chakan.centerY;
    yinsi.tag=112;
    [yinsi addTarget:self action:@selector(buttonWEB:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yinsi];
    //
    UIButton*denglu=[UIButton buttonWithType:UIButtonTypeCustom];
    denglu.frame=CGRectMake(10, 300, ScreenWidth-20, 45);
    denglu.layer.cornerRadius=10;
    denglu.layer.masksToBounds=YES;
    [denglu setTitle:@"登录" forState:UIControlStateNormal];
    denglu.backgroundColor=[UIColor greenColor];
    [denglu addTarget:self action:@selector(denglu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:denglu];
    UILabel*sanfang=[[UILabel alloc]initWithFrame:CGRectMake(10, denglu.y+100, 200, 30)];
    sanfang.text=@"第三方登录:";
    sanfang.textColor=[UIColor grayColor];
    [self.view addSubview:sanfang];
    UIButton*sina=[UIButton buttonWithType:UIButtonTypeCustom];
    sina.frame=CGRectMake(10, sanfang.y+50, 70, 70);
    [sina setImage:[UIImage imageNamed:@"新浪"] forState:UIControlStateNormal];
    [sina addTarget:self action:@selector(sanfang) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sina];
    
    
    
    UILabel*aaaaa=[[UILabel alloc]initWithFrame:CGRectMake(120, ScreenHeight-100, 100, 30)];
    aaaaa.text=@"还没有账户?";
    aaaaa.textColor=[UIColor grayColor];
    [self.view addSubview:aaaaa];
    UIButton*zhuce=[UIButton buttonWithType:UIButtonTypeCustom];
    zhuce.frame=CGRectMake(aaaaa.x+100, aaaaa.y, 100, 30);
    [zhuce setTitle:@"立即注册" forState:UIControlStateNormal];
    [zhuce setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [zhuce addTarget:self action:@selector(zhuce) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: zhuce];
    // Do any additional setup after loading the view.
}
-(void)sanfang{
    [self getAuthWithUserInfoFromSina];
}
-(void)zhuce{
    WebViewController*zhuce=[[WebViewController alloc]init];
    zhuce.url=@"https://account.guokr.com/phone/sign_up/?success=http%3A%2F%2Fwww.guokr.com%2Fsso%2F%3Fsuppress_prompt%3D1%26lazy%3Dy%26success%3Dhttp%253A%252F%252Fwww.guokr.com%252Fgroup%252Fuser%252Frecent_replies%252F";
    UINavigationController*nav=[[UINavigationController alloc]initWithRootViewController:zhuce];
    [self.navigationController showViewController:nav sender:nil];
}
-(void)left{
    [self.sideMenuViewController presentLeftMenuViewController];
}
-(void)denglu{
    DengluViewController*denglu=[[DengluViewController alloc]init];
    denglu.url=@"https://account.guokr.com/sign_in/?success=http%3A%2F%2Fwww.guokr.com%2F";
    UINavigationController*nav=[[UINavigationController alloc]initWithRootViewController:denglu];
    [self.navigationController showViewController:nav sender:nil];
    
}
-(void)GetYanzhengMa:(UIButton*)sender{
    UIImageView*image=[sender.superview viewWithTag:110];
    
    [image sd_setImageWithURL:[NSURL URLWithString:@"https://account.guokr.com/captcha/1481958939984130540676928333085968287116/"] placeholderImage:nil options:SDWebImageRefreshCached progress:nil completed:nil];
    //
    
}
- (void)getAuthWithUserInfoFromSina{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"Sina uid: %@", resp.uid);
            NSLog(@"Sina accessToken: %@", resp.accessToken);
//            [[NSUserDefaults standardUserDefaults]setValue:resp.accessToken forKey:@"access_token"];
            NSLog(@"授权的应用程序不是果壳精选所以 暂不支持 ");
            NSLog(@"Sina refreshToken: %@", resp.refreshToken);
            NSLog(@"Sina expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Sina name: %@", resp.name);
            NSLog(@"Sina iconurl: %@", resp.iconurl);
            NSLog(@"Sina gender: %@", resp.gender);
            
            // 第三方平台SDK源数据
            NSLog(@"Sina originalResponse: %@", resp.originalResponse);
            [[NSNotificationCenter defaultCenter]postNotificationName:@"denglu" object:nil];
        }
    }];
}

-(void)buttonWEB:(UIButton*)sender{
    WebViewController*web=[[WebViewController alloc]init];
    switch (sender.tag) {
        case 110:
            web.url=@"https://account.guokr.com/phone/forgot_password/?success=https%3A%2F%2Faccount.guokr.com%2Foauth2%2Fauthorize%2F%3Fclient_id%3D32353%26redirect_uri%3Dhttp%253A%252F%252Fwww.guokr.com%252Fsso%252F%253Flazy%253Dy%2526rid%253D796074576%2526success%253Dhttp%25253A%25252F%25252Fwww.guokr.com%25252Fpost%25252F17882%25252F%26response_type%3Dcode%26state%3Dcf3419aa4c0cb4f1abeb89953fa5f24b95616e4aff7f4a4278e6aadcce788e38--1483954996%26suppress_prompt%3D1";
            break;
        case 111:
            web.url=@"http://jingxuan.guokr.com/about/agreement/";
            break;
        case 112:
            web.url=@"http://jingxuan.guokr.com/about/privacy/";
            break;
            
        default:
            break;
    }
    UINavigationController*nav=[[UINavigationController alloc]initWithRootViewController:web];
    [self showDetailViewController:nav sender:nil];
    
}
-(void)GetData:(NSString*)url{
    AFHTTPSessionManager*manager=[AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _dataArray=responseObject;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
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
