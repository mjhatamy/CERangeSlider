//
//  YoshikoTextField.m
//  CERangeSlider
//
//  Created by Majid Hatami Aghdam on 12/18/15.
//  Copyright © 2015 Majid Hatami Aghdam. All rights reserved.
//

#import "YoshikoTextField.h"

@implementation YoshikoTextField


-(void) setDefaultValues{
    NSLog(@"setDefaultValues");
    placeHolderLabel = [UILabel new];
    placeHolderLabel.text = @"----";
    //_borderThickness = 2.0;
    _placeholderFontScale = 0.7;
    //_placeholderColor = [UIColor blackColor];
    placeholderInsets = CGPointMake(6, 0);
    textFieldInsets  = CGPointMake(6, 0);
    borderLayer = [CALayer layer];
}

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
        placeHolderLabel.alpha = (self.text > 0) ? 1:0;
        placeHolderLabel.frame = [self placeholderRectForBounds:self.bounds];
    }  completion:^(BOOL finished){
        [self updatePlaceholder];
        [UIView animateWithDuration:0.3 animations:^(void){
            placeHolderLabel.alpha = 1;
            [self updateBorder];
            [self updateBackground];
        }];
    }];
}

// MARK: - TextFieldEffects
-(void)animateViewsForTextEntry {
    NSLog(@"animateViewsForTextEntry child");
    [self animateViews];
}

-(void)animateViewsForTextDisplay {
    NSLog(@"animateViewsForTextDisplay child");
    [self animateViews];
}

-(void)drawViewsForRect:(CGRect)rect
{
    NSLog(@"drawViewsForRect child");
    [self setDefaultValues];
    
    [self updatePlaceholder];
    [self updateBorder];
    [self updateBackground];
    
    [self.layer addSublayer:borderLayer];
    [self addSubview:placeHolderLabel];
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    if(self.isFirstResponder || (self.text.length > 0)){
        return CGRectMake(placeholderInsets.x, placeholderInsets.y, bounds.size.width, [self placeholderHeight]);
    }else{
        return [self textRectForBounds:bounds];
    }
}

- (CGRect)editingRectForBounds:(CGRect)bounds{
    return [self textRectForBounds:bounds];
}

- (CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectOffset(bounds, textFieldInsets.x, textFieldInsets.y + [self placeholderHeight] /2 );
}

-(void)prepareForInterfaceBuilder{
    [super prepareForInterfaceBuilder];
    placeHolderLabel.alpha = 1;
    //NSLog(@"Interface BNuilder");
    [self setDefaultValues];
    [self drawViewsForRect:self.frame ];
}

@end
