//
//  GuanyuViewController.m
//  果壳
//
//  Created by 李旺 on 2016/12/18.
//  Copyright © 2016年 我赢. All rights reserved.
//

#import "GuanyuViewController.h"

@interface GuanyuViewController ()
@property(nonatomic,strong)UIImageView*picview;
@property(nonatomic,strong)UILabel*label;
@property(nonatomic,strong)UILabel*version;
@end

@implementation GuanyuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"关于我们";
    _picview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    _picview.centerX=self.view.centerX;
    _picview.centerY=300;
    _picview.layer.borderWidth=1;
    _picview.layer.borderColor=[UIColor grayColor].CGColor;
    _picview.image=[UIImage imageNamed:@"果壳"];
    _picview.layer.cornerRadius=15;
    _picview.layer.masksToBounds=YES;
    [self.view addSubview:_picview];
    _version=[[UILabel alloc]init];
    
    _version.text= [NSString stringWithFormat: @"果壳精选 IOS %@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    [_version sizeToFit];
    _version.centerX=self.view.centerX;
    _version.centerY=_picview.centerY+80;
    _version.textColor=[UIColor grayColor];
    
    [self.view addSubview:_version];
    _label=[[UILabel alloc]init];
    
   _label.text=@"早晚给你好看";
    _label.font=[UIFont systemFontOfSize:25];
    [_label sizeToFit];
    _label.centerX=self.view.centerX;
    _label.centerY=_version.centerY+50;

    [self.view addSubview:_label];
    
    // Do any additional setup after loading the view.
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
