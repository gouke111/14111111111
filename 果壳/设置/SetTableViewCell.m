//
//  SetTableViewCell.m
//  果壳
//
//  Created by 李旺 on 2016/12/18.
//  Copyright © 2016年 我赢. All rights reserved.
//

#import "SetTableViewCell.h"
#import "SetViewController.h"

@implementation SetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.swith addTarget:self action:@selector(swith:) forControlEvents:UIControlEventValueChanged];
        
        
    // Initialization code
}
-(void)swith:(UISwitch*)sender{
    sender.selected=!sender.selected;
    
    [[NSUserDefaults standardUserDefaults] setObject:@(sender.selected) forKey:self.title.text];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
