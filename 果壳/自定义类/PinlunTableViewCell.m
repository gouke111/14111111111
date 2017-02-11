//
//  PinlunTableViewCell.m
//  果壳
//
//  Created by 李旺 on 2016/12/21.
//  Copyright © 2016年 我赢. All rights reserved.
//

#import "PinlunTableViewCell.h"

@implementation PinlunTableViewCell
-(void)setModel:(PinlunModel*)model{
    if(!_model){
        _model=[[PinlunModel alloc]init];
    }
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    _model=model;
    [_picview sd_setImageWithURL:[NSURL URLWithString:_model.author[@"avatar"][@"large"]]];
    _zancell.selected=_model.current_user_has_liked;
    _account.text=_model.author[@"nickname"];
    _content.text=_model.content;
    [_content sizeToFit];
    _lou.text=[self changedate:_model.date_created];
}
//
-(NSString*)changedate:(NSString*)datestr{
     NSString * sub = [datestr substringWithRange:NSMakeRange(0, 19)];
    //UTC时间格式转换成北京时间
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSDate *localDate = [dateFormatter dateFromString:sub];
    
    NSDateFormatter * farmat = [[NSDateFormatter alloc]init];
    [farmat setDateFormat:@"MM月dd日"];
    NSString * timestr = [farmat stringFromDate:localDate];
   
    return timestr;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)zan:(UIButton*)sender {

        //[[NSNotificationCenter defaultCenter]postNotificationName:@"pinglunzan" object:sender];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
