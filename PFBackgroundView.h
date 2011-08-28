//
//  PFBackgroundView.h
//  Pulpfingers
//
//  Created by David Charlec & Jerome Scheer on 08/26/2011
//  Copyright 2011 Pulpfingers. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

typedef enum  {
    PFBackgroundViewStyleRectangle = 0,
    PFBackgroundViewStyleRoundedRectangle,
    PFBackgroundViewStyleTopRounded, 
    PFBackgroundViewStyleBottomRounded
} PFBackgroundViewStyle;

typedef enum  {
    PFBackgroundViewBorderStyleTop = 0,
    PFBackgroundViewBorderStyleRight,
    PFBackgroundViewBorderStyleBottom, 
    PFBackgroundViewBorderStyleLeft,
    PFBackgroundViewBorderStyleInner,
    PFBackgroundViewBorderStyleOuter
} PFBackgroundViewBorderStyle;

@interface PFBackgroundView : UIView {
    PFBackgroundViewStyle style;    
    UIColor *bgColor;
    UIColor *innerBorderColor;
    CGFloat innerBorderWidth;
    NSArray *borders;
}

@property(nonatomic) PFBackgroundViewStyle style;
@property(nonatomic, retain) UIColor *strokeColor;
@property(nonatomic) CGFloat strokeWidth;
@property(nonatomic, retain) UIImage *image;
//@property(nonatomic) CGGradient gradient;

- (void)setBorderWithStyle:(PFBackgroundViewBorderStyle)borderStyle color:(UIColor *)color width:(CGFloat)width;
                             
@end