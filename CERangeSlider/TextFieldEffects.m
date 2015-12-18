//
//  TextFieldEffects.m
//  CERangeSlider
//
//  Created by Majid Hatami Aghdam on 12/16/15.
//  Copyright © 2015 Majid Hatami Aghdam. All rights reserved.
//

#import "TextFieldEffects.h"

static void* const MyKVOContext = (void *)&MyKVOContext;

@implementation TextFieldEffects {
 
    
}

@dynamic placeholder;
@dynamic text;
@dynamic textColor;



/*
-(void) setText:(NSString *)text{
    //self.text = text;
    NSLog(@"Set Text");
    super.text = text;
    if(text==self.text && (text.length >0)){
        [self animateViewsForTextEntry];
    }else{
        [self animateViewsForTextDisplay];
    }
}
 */
 

-(void) animateViewsForTextEntry {
     NSLog(@"Supper view animateViewsForTextEntry");
}
-(void) animateViewsForTextDisplay{
    NSLog(@"Supper view animateViewsForTextDisplay");
}

-(void) updateViewsForBoundsChange:(CGRect) bounds
{
    NSLog(@"\(__FUNCTION__) must be overridden");
}

-(void)drawPlaceholderInRect:(CGRect)rect{
    // Don't draw any placeholders
}


-(void) setupKVO{
    NSLog(@"Setup KVO called");
    [self.userActivity addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:MyKVOContext];
}

-(void) removeKVO{
    NSLog(@"Remove KVO Called");
    [self.userActivity removeObserver:self forKeyPath:@"text" context:MyKVOContext];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object change:(NSDictionary *)change
                       context:(void *)context
{
    NSLog(@"Observer root");
    if ( context == MyKVOContext ) {
        if ( [object isEqual:self] ) {
            NSLog(@"Observer called here");
        }
    }
}

-(void) dealloc{
    [self removeKVO];
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
    [self setupKVO];
    
    [self drawViewsForRect: rect];
    [self animateViewsForTextDisplay];
}

-(void) willMoveToSuperview:(UIView *)newSuperview
{
    if(newSuperview != nil){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidEndEditing) name:
         UITextFieldTextDidEndEditingNotification object:self];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidBeginEditing) name:
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
