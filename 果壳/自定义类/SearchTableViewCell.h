//
//  SearchTableViewCell.h
//  果壳
//
//  Created by 李旺 on 2016/12/15.
//  Copyright © 2016年 我赢. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchModel.h"

@interface SearchTableViewCell : UITableViewCell
@property(nonatomic,strong)SearchModel*model;
@property (weak, nonatomic) IBOutlet UIImageView *picview;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picwidth;

@end
