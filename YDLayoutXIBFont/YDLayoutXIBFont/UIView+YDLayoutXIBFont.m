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
//#define SizeScale ((CGFloat)(kScreenWidth / 375))
#define SizeScale ((CGFloat)(kScreenWidth / 1000))

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
    
    Method method3 = class_getInstanceMethod([UIButton class], @selector(button_awakeFromNib));
    Method method4 = class_getInstanceMethod([UIButton class], @selector(awakeFromNib));
    if (!class_addMethod([UIButton class], @selector(awakeFromNib), method_getImplementation(method3), method_getTypeEncoding(method3))) {
        method_exchangeImplementations(method4, method3);
    } else {
        class_replaceMethod(self, @selector(button_awakeFromNib), method_getImplementation(method4), method_getTypeEncoding(method4));
    }
    
    Method method5 = class_getInstanceMethod([UITextField class], @selector(textField_awakeFromNib));
    Method method6 = class_getInstanceMethod([UITextField class], @selector(awakeFromNib));
    if (!class_addMethod([UITextField class], @selector(awakeFromNib), method_getImplementation(method5), method_getTypeEncoding(method5))) {
        method_exchangeImplementations(method6, method5);
    } else {
        class_replaceMethod(self, @selector(textField_awakeFromNib), method_getImplementation(method6), method_getTypeEncoding(method6));
    }
    
    Method method7 = class_getInstanceMethod([UITextView class], @selector(textView_awakeFromNib));
    Method method8 = class_getInstanceMethod([UITextView class], @selector(awakeFromNib));
    if (!class_addMethod([UITextView class], @selector(awakeFromNib), method_getImplementation(method7), method_getTypeEncoding(method7))) {
        method_exchangeImplementations(method8, method7);
    } else {
        class_replaceMethod(self, @selector(textView_awakeFromNib), method_getImplementation(method8), method_getTypeEncoding(method8));
    }
    
    Method method9 = class_getInstanceMethod([UISearchBar class], @selector(searchBar_awakeFromNib));
    Method method10 = class_getInstanceMethod([UISearchBar class], @selector(awakeFromNib));
    if (!class_addMethod([UISearchBar class], @selector(awakeFromNib), method_getImplementation(method9), method_getTypeEncoding(method9))) {
        method_exchangeImplementations(method10, method9);
    } else {
        class_replaceMethod(self, @selector(searchBar_awakeFromNib), method_getImplementation(method10), method_getTypeEncoding(method10));
    }

    
    
    
}

/*
 UILabel
 方法交换以后 当系统调用 awakeFromNib 方法的时候实际上会调用 label_awakeFromNib 方法
 **/
- (void)label_awakeFromNib {
    [self label_awakeFromNib];
    UILabel * label = (UILabel *)self;
    label.font = [UIFont fontWithDescriptor:label.font.fontDescriptor size:label.font.pointSize * SizeScale];
    
}

/*
 UIButton
 方法交换以后 当系统调用 awakeFromNib 方法的时候实际上会调用 button_awakeFromNib 方法
 **/
- (void)button_awakeFromNib {
    [self button_awakeFromNib];
    UIButton * button = (UIButton *)self;
    button.titleLabel.font = [UIFont fontWithDescriptor:button.titleLabel.font.fontDescriptor size:button.titleLabel.font.pointSize * SizeScale];
}


/*
 UITextField
 方法交换以后 当系统调用 awakeFromNib 方法的时候实际上会调用 textField_awakeFromNib 方法
 **/
- (void)textField_awakeFromNib {
    [self textField_awakeFromNib];
    UITextField * textField = (UITextField *)self;
    textField.font = [UIFont fontWithDescriptor:textField.font.fontDescriptor size:textField.font.pointSize * SizeScale];
}

/*
 UITextView
 方法交换以后 当系统调用 awakeFromNib 方法的时候实际上会调用 textView_awakeFromNib 方法
 **/
- (void)textView_awakeFromNib {
    [self textView_awakeFromNib];
    UITextView * textView = (UITextView *)self;
    textView.font = [UIFont fontWithDescriptor:textView.font.fontDescriptor size:textView.font.pointSize * SizeScale];
}

/*
 UISearchBar
 方法交换以后 当系统调用 awakeFromNib 方法的时候实际上会调用 searchBar_awakeFromNib 方法
 **/
- (void)searchBar_awakeFromNib {
    [self searchBar_awakeFromNib];
    UISearchBar * searchBar = (UISearchBar *)self;
    UITextField *textField = [searchBar valueForKey:@"_searchField"];
    textField.font = [UIFont fontWithDescriptor:textField.font.fontDescriptor size:textField.font.pointSize * SizeScale];
}




@end
