//
//  WebViewController.m
//  果壳
//
//  Created by 李旺 on 2016/12/17.
//  Copyright © 2016年 我赢. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(fanhui)];
    self.navigationController.navigationBar.backgroundColor=[UIColor whiteColor];
    _web=[[UIWebView alloc]initWithFrame:ScreenFrame];
    _web.delegate=self;
    [self.view addSubview:_web];
    NSURL*URL=[NSURL URLWithString:_url];
    NSURLRequest*request=[NSURLRequest requestWithURL:URL];
    
    [_web loadRequest:request];
    
    // Do any additional setup after loading the view.
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if([request.URL.absoluteString containsString:@"http://www.guokr.com/"]){
        [self fanhui];
    }
    return YES;
}
-(void)fanhui{
    [self dismissViewControllerAnimated:YES completion:nil];
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
