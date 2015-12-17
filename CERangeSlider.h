//
//  CERangeSlider.h
//  CERangeSlider
//
//  Created by Majid Hatami Aghdam on 12/16/15.
//  Copyright © 2015 Majid Hatami Aghdam. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface CERangeSlider : UIControl

@property (nonatomic) IBInspectable float maxmimumValue;
@property (nonatomic) IBInspectable float minimumValue;
@property (nonatomic) IBInspectable float upperValue;
@property (nonatomic) IBInspectable float lowerValue;

@property (nonatomic) UIColor *trackColour;
@property (nonatomic) UIColor *trackHighlightColour;
@property (nonatomic) UIColor *knobColour;
@property (nonatomic) float curvaceousness;

-(float) positionForValue:(float)value;

@end
