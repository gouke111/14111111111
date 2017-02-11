//
//  SearchModel.h
//  果壳
//
//  Created by 李旺 on 2016/12/15.
//  Copyright © 2016年 我赢. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchModel : NSObject
@property(nonatomic,strong)NSString*style;
@property(nonatomic,strong)NSString*owner_name;
@property(nonatomic,strong)NSString*title;
@property(nonatomic,strong)NSString*headline_img;
@property(nonatomic,strong)NSString*summary;
@property(nonatomic,assign)int ID;
@end
