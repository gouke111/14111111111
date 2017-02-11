//
//  ChildViewController.h
//  果壳
//
//  Created by 李旺 on 2016/12/24.
//  Copyright © 2016年 我赢. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChildViewController : UIViewController
@property(nonatomic,strong)NSString* access_token;
@property(nonatomic,strong)NSString* url;
@property(nonatomic,strong)NSString*urlstr;

@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)NSMutableArray*dataArray;
@property(nonatomic,strong)NSMutableArray*cellArray;
@property(nonatomic,assign)int page;

-(void)GETdata:(UITableView*)sender;
@end
