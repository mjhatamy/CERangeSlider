//
//  YoshikoTextField.m
//  CERangeSlider
//
//  Created by Majid Hatami Aghdam on 12/18/15.
//  Copyright © 2015 Majid Hatami Aghdam. All rights reserved.
//

#import "YoshikoTextField.h"

@implementation YoshikoTextField




-(void)updateBorder {
    borderLayer.frame = [self rectForBounds:self.bounds];
    borderLayer.borderWidth = _borderSize;
    borderLayer.borderColor = (self.isFirstResponder || (self.text.length > 0)) ? _activeBorderColor.CGColor : _inactiveBorderColor.CGColor;
}

-(void)updateBackground {
    if(self.isFirstResponder || (self.text.length > 0)) {
        borderLayer.backgroundColor = _activeBackgroundColor.CGColor;
    } else {
        borderLayer.backgroundColor = _inactiveBorderColor.CGColor;
    }
}

-(void)updatePlaceholder {
    placeHolderLabel.frame = [self placeholderRectForBounds:self.bounds];
    placeHolderLabel.text = self.placeholder;
    placeHolderLabel.textAlignment = self.textAlignment;
    
    if(self.isFirstResponder || (self.text.length >0)) {
        placeHolderLabel.font = [self placeholderFontFromFontAndPercentageOfOriginalSize:self.font percentageOfOriginalSize: _placeholderFontScale * 0.8];

        placeHolderLabel.text = self.placeholder.uppercaseString;//placeholder?.uppercaseString
        placeHolderLabel.textColor = _activeBorderColor;
    } else {
        placeHolderLabel.font = [self placeholderFontFromFontAndPercentageOfOriginalSize:self.font percentageOfOriginalSize: _placeholderFontScale];
        placeHolderLabel.textColor = _placeholderColor;
    }
}

-(UIFont *)placeholderFontFromFontAndPercentageOfOriginalSize: (UIFont*)font percentageOfOriginalSize:(CGFloat)percentageOfOriginalSize
{
    return [UIFont fontWithName:font.fontName size:font.pointSize * percentageOfOriginalSize];
}

-(CGRect)rectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x, bounds.origin.y+[self placeholderHeight], self.bounds.size.width, self.bounds.size.height - [self placeholderHeight]);
}

-(CGFloat)placeholderHeight
{
    return placeholderInsets.y + [self placeholderFontFromFontAndPercentageOfOriginalSize:self.font percentageOfOriginalSize:self.placeholderFontScale].lineHeight;
}

-(void)animateViews {
    [UIView animateWithDuration:0.2 animations:^(void){
        placeHolderLabel.alpha = 0;
        placeHolderLabel.frame = [self placeholderRectForBounds:self.bounds];
    }  completion:^(BOOL finished){
        placeHolderLabel.alpha = 1;
        [self updateBorder];
        [self updateBackground];
    }];
}

// MARK: - TextFieldEffects

-(void)animateViewsForTextEntry {
    //guard text!.isEmpty else { return }
    
    [self animateViews];
}

-(void)animateViewsForTextDisplay {
    //guard text!.isEmpty else { return }
    
    [self animateViews];
}


-(void)drawViewsForRect:(CGRect)rect
{
    [self updatePlaceholder];
    [self updateBorder];
    [self updateBackground];
    
    [self.layer addSublayer:borderLayer];
    [self addSubview:placeHolderLabel];
    
}

@end
