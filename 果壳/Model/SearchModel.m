//
//  SearchModel.m
//  果壳
//
//  Created by 李旺 on 2016/12/15.
//  Copyright © 2016年 我赢. All rights reserved.
//

#import "SearchModel.h"

@implementation SearchModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _ID=(int)value;
    }
}
@end
