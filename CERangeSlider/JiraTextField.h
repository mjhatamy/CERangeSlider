//
//  JiraTextField.h
//  CERangeSlider
//
//  Created by Majid Hatami Aghdam on 12/16/15.
//  Copyright © 2015 Majid Hatami Aghdam. All rights reserved.
//

#import "TextFieldEffects.h"

IB_DESIGNABLE
#include <UIKit/UITextField.h>
@class UITextField;
@class TextFieldEffects;

@interface JiraTextField : TextFieldEffects {
    CGPoint placeholderInsets;
    CGPoint textFieldInsets;
    CALayer *borderLayer;
}

@property (nonatomic) IBInspectable CGFloat borderThickness;
@property (nonatomic) IBInspectable CGFloat placeholderFontScale;
@property (nonatomic) IBInspectable UIColor* borderColor;
@property (nonatomic) IBInspectable UIColor* placeholderColor;

-(void) animateViewsForTextEntry;
-(void) animateViewsForTextDisplay;

-(CGRect) textRectForBounds:(CGRect) bounds;

@end
