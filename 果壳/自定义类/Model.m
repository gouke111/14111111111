//
//  Model.m
//  果壳
//
//  Created by 李旺 on 2016/12/13.
//  Copyright © 2016年 我赢. All rights reserved.
//

#import "Model.h"

@implementation Model

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _ID=[value intValue];
    }
    NSLog(@"%@,%@",key,value);
}
@end
