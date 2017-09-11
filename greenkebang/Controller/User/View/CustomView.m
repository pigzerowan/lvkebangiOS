//
//  CustomView.m
//  KeyboardInput
//
//  Created by Brian Mancini on 10/4/14.
//  Copyright (c) 2014 iOSExamples. All rights reserved.
//

#import "CustomView.h"
#import "KeyboardBar.h"

@interface CustomView()

// Override inputAccessoryView to readWrite
@property (nonatomic, strong) UIView *inputAccessoryView;
    
@end

@implementation CustomView

// Override canBecomeFirstResponder
// to allow this view to be a responder
- (BOOL) canBecomeFirstResponder {
    return true;
}

// Override inputAccessoryView to use
// an instance of KeyboardBar
- (UIView *)inputAccessoryView {
    if(!_inputAccessoryView) {
        _inputAccessoryView = [[KeyboardBar alloc] initWithDelegate:self.keyboardBarDelegate];
    }
    return _inputAccessoryView;
}

@end
