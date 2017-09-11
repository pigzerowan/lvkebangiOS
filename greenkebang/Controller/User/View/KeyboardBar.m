//
//  KeyboardBar.m
//  KeyboardInputView
//
//  Created by Brian Mancini on 10/4/14.
//  Copyright (c) 2014 iOSExamples. All rights reserved.
//

#import "KeyboardBar.h"

@implementation KeyboardBar

- (id)initWithDelegate:(id<KeyboardBarDelegate>)delegate {
    self = [self init];
    self.delegate = delegate;
    return self;
}

- (id)init {
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGRect frame = CGRectMake(0,0, CGRectGetWidth(screen), 50);
    self = [self initWithFrame:frame];
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if(self) {
        
        self.backgroundColor = UIColorWithRGBA(238, 238, 238, 1);
//        [UIColor colorWithWhite:0.75f alpha:1.0f];
        [UIColor colorWithWhite:0.5f alpha:1.0f];
                self.layer.cornerRadius = 2.0;
                self.layer.borderWidth = 1.0;
                self.layer.borderColor = UIColorWithRGBA(224, 224, 224, 1).CGColor;

    
        self.textView = [[UITextField alloc]initWithFrame:CGRectMake(5, 5, frame.size.width - 70, frame.size.height-10)];
        self.textView.placeholder = @"评论";
        self.textView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.textView];
        
        self.actionButton = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width - 60, 5, 55, frame.size.height - 10)];
        self.actionButton.backgroundColor = [UIColor LkbBtnColor];
//        [UIColor colorWithWhite:0.5f alpha:1.0f];
//        self.actionButton.layer.cornerRadius = 2.0;
//        self.actionButton.layer.borderWidth = 1.0;
//        self.actionButton.layer.borderColor = [[UIColor colorWithWhite:0.45 alpha:1.0f] CGColor];
        [self.actionButton setTitle:@"发送" forState:UIControlStateNormal];
        [self.actionButton addTarget:self action:@selector(didTouchAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.actionButton];
        
    }
    return self;
}

- (void) didTouchAction
{
    [self.delegate keyboardBar:self sendText:self.textView.text];
}

@end
