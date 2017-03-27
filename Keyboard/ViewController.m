//
//  ViewController.m
//  Keyboard
//
//  Created by fuzhaurui on 2017/2/21.
//  Copyright © 2017年 fuzhaurui. All rights reserved.
//

#import "ViewController.h"
#import "FZRCustomKeyboard.h"

@interface ViewController ()<UITextFieldDelegate,UITextViewDelegate>
@property(strong ,nonatomic)IBOutlet UITextField *textField;

@property(strong ,nonatomic)IBOutlet UITextView *textView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
//    [CustomKeyboard setCustomKeyboard:self.textField];
//    [CustomKeyboard setCustomKeyboard:self.textView];
    
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [FZRCustomKeyboard setCustomKeyboard:textField confusion:YES];
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [FZRCustomKeyboard setCustomKeyboard:textView];
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[[UIApplication sharedApplication]keyWindow]endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
