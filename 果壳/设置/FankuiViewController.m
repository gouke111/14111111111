//
//  FankuiViewController.m
//  果壳
//
//  Created by 李旺 on 2016/12/18.
//  Copyright © 2016年 我赢. All rights reserved.
//

#import "FankuiViewController.h"

@interface FankuiViewController ()
@property(nonatomic,strong)UITextField*textfield;
@property(nonatomic,strong)UITextField*textfield2;
@property(nonatomic,strong)UILabel*poplabel;

@end

@implementation FankuiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"反馈";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(tijiao)];
    
    //
    _textfield=[[UITextField alloc]initWithFrame:CGRectMake(20, 90, ScreenWidth-40, 45)];
    _textfield.layer.borderWidth=1;
    _textfield.placeholder=@"请留下你的QQ或邮箱";
    
    [self.view addSubview:_textfield];
    _textfield2=[[UITextField alloc]initWithFrame:CGRectMake(20, 160, ScreenWidth-40, 90)];
    _textfield2.layer.borderWidth=1;
    _textfield2.placeholder=@"请留下您的反馈";
    _textfield2.contentVerticalAlignment=UIStackViewAlignmentTop;
    [self.view addSubview:_textfield2];
    _poplabel=[[UILabel alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth/4, 30)];
   
    _poplabel.backgroundColor=[UIColor colorWithWhite:0 alpha:0.5];
    _poplabel.textAlignment=NSTextAlignmentCenter;
    _poplabel.layer.cornerRadius=10;
    _poplabel.layer.masksToBounds=YES;
    
    [self.view addSubview:_poplabel];
    // Do any additional setup after loading the view.
    
}

-(void)tijiao{
    [_textfield resignFirstResponder];
    NSString* matches=@"[0-9]{6,}";
    NSString*matches1=@"\\w+@[A-Za-z0-9_]+.[A-Za-z0-9_]+";
    NSPredicate *Predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",matches];
    NSPredicate *Predicate1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",matches1];
    if([_textfield.text isEqualToString:@""]){
        [self POP:@"邮箱或QQ不能空哦~"];
    }else{
        if ([Predicate evaluateWithObject:_textfield.text]&&[Predicate1 evaluateWithObject:_textfield.text]) {
            if([_textfield2.text isEqualToString:@""] ){
                [self POP:@"您的意见不能空哦~"];
            }else{
                [self POP:@"反馈发送成功"];
            }
            
        }else{
            [self POP:@"QQ或邮箱格式错误"];
        }
    }
    
    
        
    

}
-(void)POP:(NSString*)title{
     _poplabel.text=title;
    [_poplabel sizeToFit];
    _poplabel.width+=10;
    _poplabel.height+=5;
     _poplabel.centerX=self.view.centerX;
    POPSpringAnimation *anSpring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anSpring.toValue = @(_poplabel.center.y-400);
    anSpring.beginTime = CACurrentMediaTime() + 1.0f;
    anSpring.springBounciness = 10.0f;
    anSpring.springSpeed=1;
    
    anSpring.autoreverses=YES;
    [_poplabel pop_addAnimation:anSpring forKey:@"position"];
}
//弹窗提醒
-(void)tanchuang:(NSString*)title message:(NSString*)message{
    UIAlertController*alert=[UIAlertController alertControllerWithTitle:title                                                    message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [self showDetailViewController:alert sender:nil];
    
}

//textfield方法
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
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
