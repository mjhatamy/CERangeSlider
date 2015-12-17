//
//  JiraTextField.h
//  CERangeSlider
//
//  Created by Majid Hatami Aghdam on 12/16/15.
//  Copyright © 2015 Majid Hatami Aghdam. All rights reserved.
//

#import "TextFieldEffects.h"

@interface JiraTextField : TextFieldEffects

@property (nonatomic) IBInspectable CGFloat borderThickness;
@property (nonatomic) IBInspectable CGFloat placeholderFontScale;
@property (nonatomic) IBInspectable UIColor* borderColor;
@property (nonatomic) IBInspectable UIColor* placeholderColor;

-(void) animateViewForTextEntry;
-(void) animateViewsForTextDisplay;

@end
