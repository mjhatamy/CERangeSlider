//
//  TextFieldEffects.m
//  CERangeSlider
//
//  Created by Majid Hatami Aghdam on 12/16/15.
//  Copyright © 2015 Majid Hatami Aghdam. All rights reserved.
//

#import "TextFieldEffects.h"

@implementation TextFieldEffects {
 
    
}
@synthesize text = _text;

-(void) animateViewsForTextEntry {
     NSLog(@"Supper view animateViewsForTextEntry");
}
-(void) animateViewsForTextDisplay{
    NSLog(@"Supper view animateViewsForTextDisplay");
}

-(void) setText:(NSString *)text{
    NSLog(@"Set Text");
    _text = text;
    if(text==self.text && (text.length >0)){
        [self animateViewsForTextEntry];
    }else{
        [self animateViewsForTextDisplay];
    }

}

-(void) updateViewsForBoundsChange:(CGRect) bounds
{
    NSLog(@"\(__FUNCTION__) must be overridden");
}

-(void)drawPlaceholderInRect:(CGRect)rect{
    // Don't draw any placeholders
}


/**
 Draws the receiver’s image within the passed-in rectangle.
 - parameter rect:	The portion of the view’s bounds that needs to be updated.
 */
-(void) drawViewsForRect:(CGRect)rect
{
    NSLog(@"Super drawViewsForRect called !!!!!");
}

-(void) drawRect:(CGRect)rect
{
    NSLog(@"Super drawRect called");
    [self drawViewsForRect: rect];
}

-(void) willMoveToSuperview:(UIView *)newSuperview
{
    if(newSuperview != nil){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidEndEditing) name:
         UITextFieldTextDidEndEditingNotification object:self];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidBeginEditing:) name:
         UITextFieldTextDidBeginEditingNotification object:self];
    }else{
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}



-(void) textFieldDidBeginEditing
{
    [self animateViewsForTextEntry];
}

-(void) textFieldDidEndEditing
{
    [self animateViewsForTextDisplay];
}

-(void) prepareForInterfaceBuilder{
    [self drawViewsForRect:self.frame ];
}

@end
