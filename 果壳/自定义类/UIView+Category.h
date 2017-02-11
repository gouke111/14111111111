//
//  UIView+Category.h
//  果壳
//
//  Created by 李旺 on 2016/12/13.
//  Copyright © 2016年 我赢. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Category)
    @property (nonatomic, assign) CGFloat x;
    @property (nonatomic, assign) CGFloat y;
    @property (nonatomic, assign) CGFloat width;
    @property (nonatomic, assign) CGFloat height;
    @property (nonatomic, assign) CGFloat centerX;
    @property (nonatomic, assign) CGFloat centerY;
    
    /** 从xib中创建一个控件 */
+ (instancetype)viewFromXib;
@end
