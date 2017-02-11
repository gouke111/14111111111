//
//  PinlunModel.h
//  果壳
//
//  Created by 李旺 on 2016/12/21.
//  Copyright © 2016年 我赢. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface PinlunModel : NSObject
@property(nonatomic,strong)NSString*content;
@property(nonatomic,strong)NSString*html;
@property(nonatomic,assign)int pick_id;
@property(nonatomic,assign)BOOL current_user_has_liked;
@property(nonatomic,assign)int ID;

@property(nonatomic,strong)NSString*url;
@property(nonatomic,strong)NSMutableDictionary*author;
@property(nonatomic,strong)NSString*date_created;
@property(nonatomic,assign)int likings_count;

@end
