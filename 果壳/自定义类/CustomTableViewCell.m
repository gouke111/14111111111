//
//  CustomTableViewCell.m
//  果壳
//
//  Created by 李旺 on 2016/12/13.
//  Copyright © 2016年 我赢. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "CustomTableViewCell.h"
#import "SignupViewController.h"
@implementation CustomTableViewCell
-(void)setModel:(Model *)model{
    if(!_model){
        _model=[[Model alloc]init];
    }
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    _model=model;

    [_tu sd_setImageWithURL:[NSURL URLWithString:_model.headline_img]];
    _biaoti.text=_model.title;
    
    [_touxiang sd_setImageWithURL:[NSURL URLWithString:_model.source_data[@"image"]]];
    
    if([model.category isEqualToString:@"entertainment"]){
        _model.category=@"娱乐";
    }else if([model.category isEqualToString:@"humanities"]){
        _model.category=@"人文";
    }else if([model.category isEqualToString:@"health"]){
        _model.category=@"健康";
    }else if([model.category isEqualToString:@"learning"]){
        _model.category=@"学习";
    }else if([model.category isEqualToString:@"calendar"]){
        _model.category=@"果壳日历";
    }else if([model.category isEqualToString:@"nature"]){
        _model.category=@"自然";
    }else if([model.category isEqualToString:@"science"]){
        _model.category=@"科学";
    }else if([model.category isEqualToString:@"pic"]){
        _model.category=@"图片";
    }else if([model.category isEqualToString:@"life"]){
        _model.category=@"生活";
    }
    [_fenlei setTitle:_model.category forState:UIControlStateNormal];
    _key.text=_model.source_name;
    _gaishu.text=_model.summary;
    
    [_zanbutton setTitle:[self shushu:[_model.likings_count intValue]] forState:UIControlStateNormal];
    _zanbutton.titleLabel.textAlignment=NSTextAlignmentRight;
    [_xiaoxibutton setTitle:[self shushu:[_model.replies_count intValue]]forState:UIControlStateNormal];
    
    _xiaoxibutton.titleLabel.textAlignment=NSTextAlignmentRight;
    _zanbutton.selected=_model.current_user_has_liked;
    
    if(![_model.style isEqualToString:@"article"]){
        _picview.hidden=NO;
        [_picview sd_setImageWithURL:[NSURL URLWithString:_model.headline_img]];
        _tubiaoti.hidden=NO;
        _tubiaoti.text=_model.title;
        _biaoti.text=@"";
        _gaishu.text=@"";
        _tugaishu.hidden=NO;
        _tugaishu.text=_model.summary;
        _xiaoxiheight.constant=70;
        if(![_model.style isEqualToString:@"pic"]){
            _riliview.hidden=NO;
            _tutop.constant=70;
         [_picview sd_setImageWithURL:[NSURL URLWithString:[_model.images firstObject]]];
            NSDate*date=[NSDate dateWithTimeIntervalSince1970:_model.date_picked ];
        
            NSCalendar*calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
           NSDateComponents*week=[calendar components:NSCalendarUnitWeekday fromDate:date];
        NSArray*Weekday=@[@"SUN",@"MON",@"TUE",@"WED",@"THU",@"FRI",@"SAT"];
        NSDateComponents*year=[calendar components:NSCalendarUnitYear fromDate:date];
        NSDateComponents*day=[calendar components:NSCalendarUnitDay fromDate:date];
        NSDateComponents*month=[calendar components:NSCalendarUnitMonth fromDate:date];
    NSArray*monthArray=@[@"JAN",@"FEB",@"MAR",@"APR",@"MAY",@"JUN",@"JUL",@"AUG",@"SEP",@"OCT",@"NOV",@"DEC"];
        _day.text=Weekday[week.weekday-1];
            
        _year.text=[NSString stringWithFormat:@"%ld",(long)year.year];
        _date.text=[NSString stringWithFormat:@"%ld %@",(long)day.day,monthArray[month.month-1]];
        
        }
    }else{
        _tugaishu.hidden=YES;
        _tubiaoti.hidden=YES;
        _picview.hidden=YES;
        _riliview.hidden=YES;
        _tutop.constant=10;
        _xiaoxiheight.constant=10;
    }
    self.height=190+_xiaoxiheight.constant;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _xiaoxibutton.userInteractionEnabled=NO;
    
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)zancell:(UIButton*)sender {
    if([[NSUserDefaults standardUserDefaults]valueForKey:@"access_token"]==nil){
        [[NSNotificationCenter defaultCenter]postNotificationName:@"zancell" object:nil];
    }else{
    sender.selected=!sender.selected;
        AFHTTPSessionManager*manager=[AFHTTPSessionManager manager];
        NSString*str=[[NSUserDefaults standardUserDefaults] valueForKey:@"access_token"];
        str=[NSString stringWithFormat:@"http://apis.guokr.com/handpick/article_liking.json?access_token=%@&pick_id=%d",str,_model.ID];
        [self changetitle:sender];
        //点赞
        if(sender.selected){
        [manager POST:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@",str);
            } failure:nil];
        }else{
        //取消点赞
        [manager DELETE:str parameters:nil success:nil failure:nil];
            
        }

    }

}

-(void)changetitle:(UIButton*)sender{
    int a=[sender.titleLabel.text intValue];
    if(sender.selected){
        a+=1;
        [sender setTitle:[NSString stringWithFormat:@"%d",a ] forState:UIControlStateNormal];
    }else{
        a-=1;
        [sender setTitle:[NSString stringWithFormat:@"%d",a ] forState:UIControlStateNormal];
    }
}
-(NSString*)shushu:(int)sender{
     if(sender>=1000){
        return @"🔥";
    }else if(sender==0){
        return @"";
    }else{
        return [NSString stringWithFormat:@"%d",sender];
    }
    
}
- (IBAction)fenxiang:(id)sender {
    //显示分享面板
    WeakSelf;
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        [weakSelf fenxiangxiaoxi:platformType];
         }];
        
}


//把UIView 转换成图片
-(UIImage *)getImageFromView:(UIView *)view{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
-(void)fenxiangxiaoxi:(UMSocialPlatformType)platformType{
    NSString*str=[NSString stringWithFormat:@"这个有意思→_→[%@]http://jingxuan.guokr.com/pick/%d/ 分享自@果壳网",_model.title,_model.ID];
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    messageObject.text=str;
    UMShareImageObject*obj=[[UMShareImageObject alloc]init];
    if([_model.style isEqualToString:@"calendar"]){
        obj.thumbImage=[self getImageFromView:self];
        obj.shareImage=[self getImageFromView:self];
    }else{
        obj.thumbImage=_tu.image;
        obj.shareImage=_tu.image;
    }
    messageObject.shareObject=obj;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}


@end
