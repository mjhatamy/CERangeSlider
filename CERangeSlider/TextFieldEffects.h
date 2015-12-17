//
//  TextFieldEffects.h
//  CERangeSlider
//
//  Created by Majid Hatami Aghdam on 12/16/15.
//  Copyright © 2015 Majid Hatami Aghdam. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for TextFieldEffects.
FOUNDATION_EXPORT double TextFieldEffectsVersionNumber;
FOUNDATION_EXPORT const unsigned char TextFieldEffectsVersionString[];

IB_DESIGNABLE
@interface TextFieldEffects : UITextField{
    UILabel* placeHolderLabel;
}

-(void) drawViewsForRect:(CGRect) rect;
-(void) updateViewsForBoundsChange:(CGRect) bounds;

@end
