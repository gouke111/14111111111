//
//  DengluViewController.m
//  果壳
//
//  Created by 李旺 on 2016/12/21.
//  Copyright © 2016年 我赢. All rights reserved.
//

#import "DengluViewController.h"

@interface DengluViewController ()<UIWebViewDelegate>
@end

@implementation DengluViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.web.delegate=self;
    // Do any additional setup after loading the view.
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSArray *nCookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];NSHTTPCookie *cookie;
    //NSLog(@"%@",nCookies);
    for (id c in nCookies)
    {
        if ([c isKindOfClass:[NSHTTPCookie class]]){
            cookie=(NSHTTPCookie *)c;
//            NSLog(@"%@: %@", cookie.name, cookie.value);
        }
        if([cookie.name containsString:@"access_token"]){
            _access_token=cookie.value;
            NSLog(@"%@",_access_token);
        }else if([cookie.name containsString:@"sign_in_ukey"]){
            _ukey=cookie.value;
            NSLog(@"%@",_ukey);
        }
        
    }
    
    
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if([request.URL.absoluteString isEqualToString:@"http://m.guokr.com/"]){
        [[NSUserDefaults standardUserDefaults]setObject:_access_token forKey:@"access_token"];
        [[NSUserDefaults standardUserDefaults]setObject:_ukey forKey:@"ukey"];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"denglu" object:nil];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        
    }
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
