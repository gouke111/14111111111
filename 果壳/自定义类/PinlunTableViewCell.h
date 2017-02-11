//
//  PinlunTableViewCell.h
//  果壳
//
//  Created by 李旺 on 2016/12/21.
//  Copyright © 2016年 我赢. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PinlunModel.h"

@interface PinlunTableViewCell : UITableViewCell
@property(nonatomic,strong)PinlunModel*model;
@property (weak, nonatomic) IBOutlet UIButton *zancell;
@property (weak, nonatomic) IBOutlet UIImageView *picview;
@property (weak, nonatomic) IBOutlet UILabel *account;
@property (weak, nonatomic) IBOutlet UILabel *lou;

@property (weak, nonatomic) IBOutlet UILabel *content;

@end
