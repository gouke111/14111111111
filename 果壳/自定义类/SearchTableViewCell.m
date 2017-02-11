//
//  SearchTableViewCell.m
//  果壳
//
//  Created by 李旺 on 2016/12/15.
//  Copyright © 2016年 我赢. All rights reserved.
//

#import "SearchTableViewCell.h"

@implementation SearchTableViewCell
-(void)setModel:(SearchModel*)model{
    if(!_model){
        _model=[[SearchModel alloc]init];
    }
    _model=model;
    _model.title=[self filterHTML:_model.title];
    _title.text=_model.title;
    
    _model.summary=[self filterHTML:_model.summary];
    if([_model.headline_img isEqualToString:@"http://3.im.guokr.com/Jo1X_EzAaZO2u6F7KjM_5kEBeNUMmi1M1ZzEwL5re3tSAQAADgEAAFBO.png"]){
        _picwidth.constant=0;
    }else{
        _picwidth.constant=130;
    }
    _content.text=_model.summary;
    NSLog(@"%@",_content.text);
    [_picview sd_setImageWithURL:[NSURL URLWithString:_model.headline_img]];
    

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return html;
}
@end
