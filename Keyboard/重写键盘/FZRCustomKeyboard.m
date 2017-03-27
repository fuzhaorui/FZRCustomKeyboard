//
//  CustomKeyboard.m
//  JiaKe
//
//  Created by hgs泽泓 on 15/7/3.
//  Copyright (c) 2015年 HgsZehong. All rights reserved.
//

#import "FZRCustomKeyboard.h"

//数字
#define kNumber @[@"1",@"2",@"3",@"%",@"4",@"5",@"6",@"0",@"7",@"8",@"9",@"."]

//按键盘顺序的字母
#define kLetter @[@"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p",@"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l",@"z",@"x",@"c",@"v",@"b",@"n",@"m"]

//特殊符号
#define kSymbol @[@"~",@"！",@"@",@"#",@"￥",@"$",@"&",@"*",@"（",@"）",@"+",@"-"]

//功能键
#define kBtu @[@"英文",@"数字",@"字符",@"回收键盘",@"删除"]


#define FZRKeyboardBtnHeight  40
#define FZRLetterKeyboardBtnWidth  28
#define FZRNumberKeyboardBtnWidth  71

#define kRECT [UIScreen mainScreen].bounds

#define kUNIT [UIScreen mainScreen].bounds.size.width/320

@interface FZRCustomKeyboard()
@property (strong, nonatomic) id<UITextInput> textInput;
@end

@implementation FZRCustomKeyboard

/**
 MARK: - 创建共享实例
 **/
+ (instancetype)shareInstance{
    static dispatch_once_t once;
    static FZRCustomKeyboard *__shareInstance;
    dispatch_once(&once, ^{
        __shareInstance = [FZRCustomKeyboard new];
    });
    return __shareInstance;
}

/**
 MARK: - 初始化实例
 **/
-(instancetype)init
{
    self  = [super init];
    if(self)
    {
        self.frame = CGRectMake(0, 0, kRECT.size.width*kUNIT, 200*kUNIT);
        self.backgroundColor = [UIColor grayColor];
        [self createView];
    }
    return self;
}

/**
 MARK: - 初始化键盘
 **/
-(void)createView
{
    
    //数字排序
    NSArray *numberBtn = kNumber;
    [numberBtn enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {

        UIButton *button = [self createButton:CGRectMake(9+(FZRNumberKeyboardBtnWidth+6)*(idx%4), 8+(FZRKeyboardBtnHeight+8)*(idx/4), FZRNumberKeyboardBtnWidth, FZRKeyboardBtnHeight) buttonTilte:numberBtn[idx] buttonTilteColor:[UIColor blackColor] buttonTag:1000+idx];
        
        [button setHidden:YES];
        
        [self addSubview:button];
    }];
    
    
    //按键盘顺序的字母排序
    NSArray *charBtnArray = kLetter;
    [charBtnArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {

        if(idx<10)
        {
        
            [self addSubview:[self createButton:CGRectMake((FZRLetterKeyboardBtnWidth+3.5)*idx+3.5, 8, FZRLetterKeyboardBtnWidth, FZRKeyboardBtnHeight) buttonTilte:charBtnArray[idx] buttonTilteColor:[UIColor blackColor] buttonTag:2000+idx]];
        }
        else if (idx<19)
        {
            
            [self addSubview:[self createButton:CGRectMake((FZRLetterKeyboardBtnWidth+3.5)*(idx-10)+15, 8+8+FZRKeyboardBtnHeight, FZRLetterKeyboardBtnWidth, FZRKeyboardBtnHeight) buttonTilte:charBtnArray[idx] buttonTilteColor:[UIColor blackColor] buttonTag:2000+idx]];
            
        }else
        {

            [self addSubview:[self createButton:CGRectMake((FZRLetterKeyboardBtnWidth+3.5)*(idx-19)+35, 8+(8+FZRKeyboardBtnHeight)*2, FZRLetterKeyboardBtnWidth, FZRKeyboardBtnHeight) buttonTilte:charBtnArray[idx] buttonTilteColor:[UIColor blackColor] buttonTag:2000+idx]];
        }
    }];
    //字母 切换大小按钮
    UIButton *button = [self createButton:CGRectMake((FZRLetterKeyboardBtnWidth+3.5)*7+35, 8+(8+FZRKeyboardBtnHeight)*2, FZRLetterKeyboardBtnWidth*2, FZRKeyboardBtnHeight) buttonTilte:@"A / a" buttonTilteColor:[UIColor blueColor] buttonTag:9999];
    
    button.selected = YES;
    
    [self addSubview:button];
    
    //特殊符号排序
    NSArray *kSymbolBtn = kSymbol;
    [kSymbolBtn enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        UIButton *button = [self createButton:CGRectMake(9+(FZRNumberKeyboardBtnWidth+6)*(idx%4), 8+(FZRKeyboardBtnHeight+8)*(idx/4), FZRNumberKeyboardBtnWidth, FZRKeyboardBtnHeight) buttonTilte:kSymbolBtn[idx] buttonTilteColor:[UIColor blackColor] buttonTag:3000+idx];
        
        [button setHidden:YES];
        
        [self addSubview:button];
    }];
    
    
    
    
    NSArray *kBtnArray = kBtu;
    //功能按钮
    [kBtnArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self addSubview: [self createButton:CGRectMake((FZRLetterKeyboardBtnWidth*2+(idx==4?5:0))*idx+10.5, 8+(8+FZRKeyboardBtnHeight)*3,idx==3?FZRLetterKeyboardBtnWidth*2+18:FZRLetterKeyboardBtnWidth*2-2, FZRKeyboardBtnHeight) buttonTilte:kBtnArray[idx] buttonTilteColor:idx==4?[UIColor redColor]:idx==3?[UIColor brownColor]:idx==0?[UIColor blueColor]:[UIColor blackColor] buttonTag:9994+idx]];
        
    }];
    
}

-(UIButton *)createButton:(CGRect)frame buttonTilte:(NSString *)tilte buttonTilteColor:(UIColor *)tilteColor buttonTag:(NSInteger)tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    
    button = [[UIButton alloc]initWithFrame:CGRectMake(frame.origin.x * kUNIT, frame.origin.y * kUNIT, frame.size.width * kUNIT, frame.size.height * kUNIT)];

    [button setTitle:tilte forState:UIControlStateNormal];
    
    button.titleLabel.font = [UIFont boldSystemFontOfSize:14.f * kUNIT];
    
    [button setTitleColor:tilteColor forState:UIControlStateNormal];
    
    button.backgroundColor = [UIColor whiteColor];
    
    button.layer.cornerRadius = 3;
    
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    button.tag = tag;
    
    return button;
}

+(void)setCustomKeyboard:(id<UITextInput>)textInput
{
    
    if([textInput isKindOfClass:[UITextField class]])
    {
        [(UITextField *)textInput setInputView:[FZRCustomKeyboard shareInstance]];
    }
    if([textInput isKindOfClass:[UITextView class]])
    {
        [(UITextView *)textInput setInputView:[FZRCustomKeyboard shareInstance]];
    }
    
    [FZRCustomKeyboard shareInstance].textInput = textInput;
    [[FZRCustomKeyboard shareInstance]isConfusion:NO];
}

/**
 MARK       : - 将键盘与控件绑定  必须放在 代理中
 textInput  : UITextField 或 UITextView
 confusion  : 是否混乱随机排序
 **/
+(void)setCustomKeyboard:(id<UITextInput>)textInput confusion:(BOOL)confusion
{
    [FZRCustomKeyboard setCustomKeyboard:textInput];
    
    [[FZRCustomKeyboard shareInstance]isConfusion:confusion];
    
}

-(void)isConfusion:(BOOL)confusion
{
    //数字排序
    NSArray *numberBtn = kLetter;
    //按键盘顺序的字母排序
    NSArray *charBtnArray = kNumber;
    //特殊符号排序
    NSArray *kSymbolBtn = kSymbol;
    
    if (confusion) {
        numberBtn = [numberBtn sortedArrayUsingComparator:(NSComparator)^(id obj1, id obj2) {
            return (arc4random() % 3) - 1;
        }];
        charBtnArray = [charBtnArray sortedArrayUsingComparator:(NSComparator)^(id obj1, id obj2) {
            return (arc4random() % 3) - 1;
        }];
        kSymbolBtn = [kSymbolBtn sortedArrayUsingComparator:(NSComparator)^(id obj1, id obj2) {
            return (arc4random() % 3) - 1;
        }];
    }
    
    
    
    for (int i = 0; i<26; i++) {
        UIButton *button = [self viewWithTag:2000+i];
        [button setTitle:numberBtn[i] forState:UIControlStateNormal];
    }
    for (int i = 0; i<12; i++) {
        UIButton *button = [self viewWithTag:1000+i];
        [button setTitle:charBtnArray[i] forState:UIControlStateNormal];
    }
    for (int i = 0; i<12; i++) {
        UIButton *button = [self viewWithTag:3000+i];
        [button setTitle:kSymbolBtn[i] forState:UIControlStateNormal];
    }
}


/**
 MARK: - 按钮的实现方法
 **/
-(void)buttonAction:(UIButton *)sender
{
    NSLog(@"%ld",sender.tag);
     if(sender.tag<4000)
    {
        [self.textInput insertText:sender.titleLabel.text];
    }
    //切换英文键盘
    else if(sender.tag == 9994)
    {
        
        for (int i = 0; i<26; i++) {
            UIButton *button = [self viewWithTag:2000+i];
            [button setHidden:NO];
        }
        for (int i = 0; i<12; i++) {
            UIButton *button1 = [self viewWithTag:1000+i];
            [button1 setHidden:YES];
            UIButton *button2 = [self viewWithTag:3000+i];
            [button2 setHidden:YES];
        }
        UIButton *button = [self viewWithTag:9999];
        [button setHidden:NO];
        
        for (int i = 0; i<3; i++) {
            UIButton *button = [self viewWithTag:9994+i];
            if (i == 0) {
                [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            }
            else
            {
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }
        
    }
    else if(sender.tag == 9995)
    {
        for (int i = 0; i<26; i++) {
            UIButton *button = [self viewWithTag:2000+i];
            [button setHidden:YES];
        }
        for (int i = 0; i<12; i++) {
            UIButton *button = [self viewWithTag:1000+i];
            [button setHidden:NO];
            UIButton *button2 = [self viewWithTag:3000+i];
            [button2 setHidden:YES];
        }
        UIButton *button = [self viewWithTag:9999];
        [button setHidden:YES];
        
        for (int i = 0; i<3; i++) {
            UIButton *button = [self viewWithTag:9994+i];
            if (i == 1) {
                [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            }
            else
            {
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }
    }
    else if(sender.tag == 9996)
    {
        for (int i = 0; i<26; i++) {
            UIButton *button = [self viewWithTag:2000+i];
            [button setHidden:YES];
        }
        for (int i = 0; i<12; i++) {
            UIButton *button1 = [self viewWithTag:1000+i];
            [button1 setHidden:YES];
            UIButton *button2 = [self viewWithTag:3000+i];
            [button2 setHidden:NO];
        }
        UIButton *button = [self viewWithTag:9999];
        [button setHidden:YES];
        
        for (int i = 0; i<3; i++) {
            UIButton *button = [self viewWithTag:9994+i];
            if (i == 2) {
                [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            }
            else
            {
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }
    }
    else if(sender.tag == 9997)
    {
        [[[UIApplication sharedApplication]keyWindow]endEditing:YES];
    }
    else if(sender.tag == 9998)
    {
        [[UIDevice currentDevice] playInputClick];
        [self.textInput deleteBackward];
    }
    //大小写切换
    else if(sender.tag == 9999)
    {
        for (int i = 0; i<26; i++) {
            
            UIButton *button = (UIButton *)[self viewWithTag:(2000+i)];
            
            if (sender.selected == YES) {
                
                [button setTitle:[button.titleLabel.text uppercaseString] forState:UIControlStateNormal];
                
            }
            else
            {
                
                [button setTitle:[button.titleLabel.text lowercaseString] forState:UIControlStateNormal];
                
            }
            
        }
        
        sender.selected = !sender.selected;

    }
    
}


@end
