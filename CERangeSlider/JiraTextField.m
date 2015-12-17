//
//  JiraTextField.m
//  CERangeSlider
//
//  Created by Majid Hatami Aghdam on 12/16/15.
//  Copyright © 2015 Majid Hatami Aghdam. All rights reserved.
//

#import "JiraTextField.h"


IB_DESIGNABLE
@implementation JiraTextField {
    CGPoint placeholderInsets;
    CGPoint textFieldInsets;
    CALayer *borderLayer;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void) setBorderColor:(UIColor *)borderColor{
    _borderColor = borderColor;
    [self updateBorder];
}

-(void) setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    [self updatePlaceHolder];
}

-(void)setPlaceholderFontScale:(CGFloat)placeholderFontScale{
    _placeholderFontScale = placeholderFontScale;
    [self updatePlaceHolder];
}

-(void) setPlaceholder:(NSString *)placeholder{
    self.placeholder = placeholder;
    [self updatePlaceHolder];
}

-(void) setBounds:(CGRect)bounds{
    self.bounds = bounds;
    [self updateBorder];
    [self updatePlaceHolder];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(!self){
        return nil;
    }
    [self setDefaultValues];
    return self;
}

-(void) setDefaultValues{
    NSLog(@"setDefaultValues");
    placeHolderLabel = [[UILabel alloc] init];
    _borderThickness = 2.0;
    //_placeholderFontScale = 0.65;
    //_placeholderColor = [UIColor blackColor];
    placeholderInsets = CGPointMake(8, 8);
    textFieldInsets  = CGPointMake(8, 12);
    borderLayer = [CALayer layer];
}

-(void) drawViewsForRect:(CGRect) rect{
     NSLog(@"Child drawViewsForRect called !!!!!");
    CGRect frame = CGRectMake( 0, 0, rect.size.width, rect.size.height);
    placeHolderLabel.frame = CGRectInset(frame, placeholderInsets.x, placeholderInsets.y);
    placeHolderLabel.font = [self placeholderFontFromFont:self.font];
    
    [self updateBorder];
    [self updatePlaceHolder];
    
    [self.layer addSublayer:borderLayer];
    [self addSubview:placeHolderLabel];
}

-(void) updateBorder
{
    borderLayer.frame = [self rectForBorder:self.borderThickness isFilled:FALSE];
    borderLayer.backgroundColor = _borderColor.CGColor;
}

-(void) updatePlaceHolder{
    placeHolderLabel.text = self.placeholder;
    placeHolderLabel.textColor = _placeholderColor;
    [placeHolderLabel sizeToFit];
    [self layoutPlaceholderInTextRect];
    
    if(self.isFirstResponder || !(self.text.length > 0) ){
        [self animateViewForTextEntry];
    }
}

-(void) layoutPlaceholderInTextRect
{
    if( (self.text.length > 0)){
        return;
    }
    CGRect textRect = [self textRectForBounds:self.bounds];
    CGFloat originX = textRect.origin.x;
    switch (self.textAlignment) {
        case NSTextAlignmentCenter:
            originX += textRect.size.width/2 - placeHolderLabel.bounds.size.width/2;
            break;
        case NSTextAlignmentRight:
            originX += textRect.size.width - placeHolderLabel.bounds.size.width;
            break;
        default:
            break;
    }
}

-(CGRect) textRectForBounds:(CGRect) bounds{
    return CGRectOffset(bounds, textFieldInsets.x, textFieldInsets.y);
}

-(CGRect) rectForBorder:(CGFloat)thickness  isFilled:(BOOL)isFilled{
    if(isFilled){
        return CGRectMake(0, placeHolderLabel.frame.origin.y, self.frame.size.width, self.frame.size.height);
    }else{
        return CGRectMake(0, self.frame.size.height-thickness, self.frame.size.width, thickness);
    }
}

-(UIFont *) placeholderFontFromFont:(UIFont*) font
{
    UIFont *smallerFont = [UIFont fontWithName:font.fontName size:font.pointSize * _placeholderFontScale];
    return smallerFont;
}

-(void) animateViewForTextEntry
{
    NSLog(@"ChildView animateViewForTextEntry");
    CGRect frame =  borderLayer.frame;
    frame.origin = CGPointMake(0, self.font.lineHeight);
    borderLayer.frame = frame;
    
    [UIView animateWithDuration:0.2 delay:0.3 usingSpringWithDamping:0.8 initialSpringVelocity:1.0 options:UIViewAnimationOptionBeginFromCurrentState  animations:^(void){
        CGRect frame = placeHolderLabel.frame;
        frame.origin = CGPointMake(placeholderInsets.x, placeholderInsets.y - placeHolderLabel.bounds.size.height);
        placeHolderLabel.frame = frame;
        
        borderLayer.frame = [self rectForBorder:_borderThickness isFilled:YES];
        
    }  completion: nil];
}

-(void) animateViewsForTextDisplay
{
    NSLog(@"animateViewsForTextDisplay child");
    if(self.text.length <= 0){
        [UIView animateWithDuration:0.35 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:2.0 options:UIViewAnimationOptionBeginFromCurrentState  animations:^(void){
            [self layoutPlaceholderInTextRect];
            placeHolderLabel.alpha = 1;
            
        }  completion: nil];
    }
}



@end
