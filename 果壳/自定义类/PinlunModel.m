//
//  PinlunModel.m
//  果壳
//
//  Created by 李旺 on 2016/12/21.
//  Copyright © 2016年 我赢. All rights reserved.
//

#import "PinlunModel.h"

@implementation PinlunModel
-(instancetype)init{
    if (self=[super init]) {
        self.author=[NSMutableDictionary dictionary];
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqual:@"id"]) {
        _ID=(int)value;
    }
}
@end
