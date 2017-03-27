//
//  CustomKeyboard.h
//  JiaKe
//
//  Created by hgs泽泓 on 15/7/3.
//  Copyright (c) 2015年 HgsZehong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FZRCustomKeyboard : UIView

/**
 MARK: - 创建共享实例 重新键盘
 **/
+ (instancetype)shareInstance;


/**
 MARK       : - 将键盘与控件绑定  必须放在 代理中
 textInput  : UITextField 或 UITextView
 **/
+(void)setCustomKeyboard:(id<UITextInput>)textInput;


/**
 MARK       : - 将键盘与控件绑定  必须放在 代理中
 textInput  : UITextField 或 UITextView
 confusion  : 是否混乱随机排序
 **/
+(void)setCustomKeyboard:(id<UITextInput>)textInput confusion:(BOOL)confusion;

@end


