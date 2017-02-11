//
//  CustomTableViewCell.h
//  果壳
//
//  Created by 李旺 on 2016/12/13.
//  Copyright © 2016年 我赢. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"

@interface CustomTableViewCell : UITableViewCell
    @property (weak, nonatomic) IBOutlet UIImageView *touxiang;
    @property (weak, nonatomic) IBOutlet UIButton *zuozhe;

@property (weak, nonatomic) IBOutlet UIButton *zanbutton;
@property (weak, nonatomic) IBOutlet UILabel *key;
    @property (weak, nonatomic) IBOutlet UIButton *fenlei;
    @property (weak, nonatomic) IBOutlet UILabel *biaoti;
    @property (weak, nonatomic) IBOutlet UILabel *gaishu;
    @property (weak, nonatomic) IBOutlet UIImageView *tu;
    @property (weak, nonatomic) IBOutlet UIButton *fenxiang;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tutop;

@property (weak, nonatomic) IBOutlet UIButton *xiaoxibutton;
@property (weak, nonatomic) IBOutlet UIView *riliview;
@property(nonatomic,strong)Model*model;
@property (weak, nonatomic) IBOutlet UIImageView *picview;
@property (weak, nonatomic) IBOutlet UILabel *tubiaoti;
@property (weak, nonatomic) IBOutlet UILabel *tugaishu;
@property (weak, nonatomic) IBOutlet UILabel *year;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *day;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *xiaoxiheight;
@property(nonatomic,assign)int pick_id;
@end
