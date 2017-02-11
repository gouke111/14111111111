//
//  Model.h
//  果壳
//
//  Created by 李旺 on 2016/12/13.
//  Copyright © 2016年 我赢. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject
@property(nonatomic,strong)NSString*link_v2_sync_img;
@property(nonatomic,strong)NSString*source_name;
@property(nonatomic,strong)NSString*video_url;
@property(nonatomic,assign)int current_user_has_collected;
@property(nonatomic,strong)NSNumber* likings_count;
@property(nonatomic,strong)NSMutableArray*images;
@property(nonatomic,strong)NSString*video_duration;
@property(nonatomic,assign)int ID;
@property(nonatomic,strong)NSString*category;
@property(nonatomic,strong)NSString*style;
@property(nonatomic,strong)NSString*title;
@property(nonatomic,strong)NSMutableDictionary*source_data;
@property(nonatomic,strong)NSString*headline_img_tb;
@property(nonatomic,strong)NSString*link_v2;
@property(nonatomic,assign)int date_picked;
@property(nonatomic,assign)BOOL is_top;
@property(nonatomic,strong)NSString*link;
@property(nonatomic,strong)NSString*headline_img;
@property(nonatomic,strong)NSNumber* replies_count;
@property(nonatomic,assign)BOOL current_user_has_liked;
@property(nonatomic,strong)NSString*page_source;
@property(nonatomic,strong)NSString*author;
@property(nonatomic,strong)NSString*summary;
@property(nonatomic,strong)NSString*source;
@property(nonatomic,assign)int reply_root_id;
@property(nonatomic,assign)int date_created;
@property(nonatomic,strong)NSString*content;


@end
