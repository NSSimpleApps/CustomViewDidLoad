//
//  UIViewController+CustomViewDidLoad.m
//  CustomViewDidLoad
//
//  Created by NSSimpleApps on 19.04.15.
//  Copyright (c) 2015 NSSimpleApps. All rights reserved.
//

#import "UIViewController+CustomViewDidLoad.h"
#import <objc/runtime.h>

@implementation UIViewController (CustomViewDidLoad)

+ (void)load {
    
    [self exchangeSelector:@selector(viewDidLoad) withSelector:@selector(customViewDidLoad)];
}

+ (void)exchangeSelector:(SEL)firstSelector withSelector:(SEL)secondSelector {
    
    Class class = [self class];
    
    Method firstMethod = class_getInstanceMethod(class, firstSelector);
    Method secondMethod = class_getInstanceMethod(class, secondSelector);
    
    BOOL addMethodResult = class_addMethod(class, firstSelector, method_getImplementation(secondMethod), method_getTypeEncoding(secondMethod));
    
    if (addMethodResult) {
        
        class_replaceMethod(class, secondSelector, method_getImplementation(firstMethod), method_getTypeEncoding(firstMethod));
    } else {
        
        method_exchangeImplementations(firstMethod, secondMethod);
    }
}

- (void)customViewDidLoad {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 100, 200.0, 30.0);
    [button setTitle:@"Common button" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    [self setTitle:@"Common title"];
    
    [self customViewDidLoad];
}

@end
