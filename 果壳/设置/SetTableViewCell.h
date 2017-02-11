//
//  SetTableViewCell.h
//  果壳
//
//  Created by 李旺 on 2016/12/18.
//  Copyright © 2016年 我赢. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subtitle;
@property (weak, nonatomic) IBOutlet UISwitch *swith;
@property (weak, nonatomic) IBOutlet UILabel *daxiao;

@end
