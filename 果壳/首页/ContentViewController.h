//
//  ContentViewController.h
//  果壳
//
//  Created by 李旺 on 2016/12/15.
//  Copyright © 2016年 我赢. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentViewController : UIViewController
@property(nonatomic,strong)NSString*url;
@property(nonatomic,strong)NSString*cellurl;
@property(nonatomic,strong)UIWebView*web;
@property(nonatomic,strong)NSString*ID;
@property(nonatomic,strong)UITableView*tableview;
@property(nonatomic,strong)NSString*titlestr;
@property(nonatomic,assign)int collect;

@end
