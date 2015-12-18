//
//  YoshikoTextField.h
//  CERangeSlider
//
//  Created by Majid Hatami Aghdam on 12/18/15.
//  Copyright © 2015 Majid Hatami Aghdam. All rights reserved.
//

#import "TextFieldEffects.h"
#include <UIKit/UITextField.h>

IB_DESIGNABLE
@class TextFieldEffects;

@interface YoshikoTextField : TextFieldEffects
{
    CGPoint placeholderInsets;
    CGPoint textFieldInsets;
    CALayer *borderLayer;
}


@property (nonatomic) IBInspectable UIColor* placeholderColor;
@property (nonatomic) IBInspectable CGFloat placeholderFontScale;
@property (nonatomic) IBInspectable UIColor*   activeBorderColor;
@property (nonatomic) IBInspectable UIColor* inactiveBorderColor;
@property (nonatomic) IBInspectable UIColor*   activeBackgroundColor;
@property (nonatomic) IBInspectable CGFloat borderSize;

@end
