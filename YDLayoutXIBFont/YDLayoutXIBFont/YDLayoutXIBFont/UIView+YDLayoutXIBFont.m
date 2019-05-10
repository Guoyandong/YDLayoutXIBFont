//
//  UIView+YDLayoutXIBFont.m
//  YDLayoutXIBFont
//
//  Created by 郭严东 on 2019/5/10.
//  Copyright © 2019 guoyandong. All rights reserved.
//

#import "UIView+YDLayoutXIBFont.h"
#import <objc/runtime.h>
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define SizeScale ((CGFloat)(kScreenWidth / 375))
/*
 XIB中Label和UIButton里文字的字体等比自动适配
 **/
@implementation UIView (YDLayoutXIBFont)
+ (void)load {
    Method method1 = class_getInstanceMethod([UILabel class], @selector(label_awakeFromNib));
    Method method2 = class_getInstanceMethod([UILabel class], @selector(awakeFromNib));
    if (!class_addMethod([UILabel class], @selector(awakeFromNib), method_getImplementation(method1), method_getTypeEncoding(method1))) {
        method_exchangeImplementations(method2, method1);
    } else {
        class_replaceMethod(self, @selector(label_awakeFromNib), method_getImplementation(method2), method_getTypeEncoding(method2));
    }
    
    Method method3 = class_getInstanceMethod([UILabel class], @selector(button_awakeFromNib));
    Method method4 = class_getInstanceMethod([UILabel class], @selector(awakeFromNib));
    
    if (!class_addMethod([UIButton class], @selector(awakeFromNib), method_getImplementation(method3), method_getTypeEncoding(method3))) {
        method_exchangeImplementations(method4, method3);
    } else {
        class_replaceMethod(self, @selector(button_awakeFromNib), method_getImplementation(method4), method_getTypeEncoding(method4));
    }
    
}

/*
 方法交换以后 当系统调用 awakeFromNib 方法的时候实际上会调用 label_awakeFromNib 方法
 **/
- (void)label_awakeFromNib {
    [self label_awakeFromNib];
    UILabel * label = (UILabel *)self;
    label.font = [UIFont fontWithDescriptor:label.font.fontDescriptor size:label.font.pointSize * SizeScale];
    
}

/*
 方法交换以后 当系统调用 awakeFromNib 方法的时候实际上会调用 button_awakeFromNib 方法
 **/
- (void)button_awakeFromNib {
    [self button_awakeFromNib];
    UIButton * button = (UIButton *)self;
    button.titleLabel.font = [UIFont fontWithDescriptor:button.titleLabel.font.fontDescriptor size:button.titleLabel.font.pointSize * SizeScale];
}
@end
