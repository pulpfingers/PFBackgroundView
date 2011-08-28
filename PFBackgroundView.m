//
//  UACellBackgroundView.m
//  Ambiance
//
//  Created by Matt Coneybeare on 1/31/10.
//  Copyright 2010 Urban Apps LLC. All rights reserved.
//

#import "PFBackgroundView.h"

@implementation PFBackgroundView

@synthesize style;
//@synthesize gradient;
@synthesize strokeColor;
@synthesize strokeWidth;

- (id)init {
    self = [super init];
    if (self) {
        bgColor = [[UIColor whiteColor] retain];
        self.strokeColor = [UIColor grayColor];
        self.strokeWidth = 3.0f;
    }
    return self;
}

- (BOOL) isOpaque {
    return NO;
}

-(void)setBackgroundColor:(UIColor *)color {
    bgColor = [color retain];
    return;
}

-(void)drawRect:(CGRect)aRect {
    // Drawing code
        
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetShouldAntialias(context, YES);

    CGContextSetLineWidth(context, strokeWidth);
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
    CGContextSetFillColorWithColor(context, bgColor.CGColor);
    
    CGRect rrect = self.bounds;
            
    CGFloat minx = CGRectGetMinX(rrect);
    CGFloat midx = CGRectGetMidX(rrect);
    CGFloat maxx = CGRectGetMaxX(rrect);
    
    CGFloat miny = CGRectGetMinY(rrect);
    CGFloat midy = CGRectGetMidY(rrect);
    CGFloat maxy = CGRectGetMaxY(rrect);
    
    miny++;
    minx++;
    maxx--;
    maxy--;
    
    CGFloat topRadius = 10.0;
    CGFloat bottomRadius = 10.0;
    
    if (style == PFBackgroundViewStyleTopRounded) {
        
        bottomRadius = 0.0f;	
        
    } else if (style == PFBackgroundViewStyleBottomRounded) {

        topRadius = 0.0f;
        
    } else if (style == PFBackgroundViewStyleRectangle) {
		
        topRadius = 0.0f;
        bottomRadius = 0.0f;
		
    } 

    CGContextMoveToPoint(context, minx, midy);
    
    CGContextAddArcToPoint(context, minx, miny, midx, miny, topRadius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, midy, topRadius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, bottomRadius);
    CGContextAddArcToPoint(context, minx, maxy, minx, midy, bottomRadius);

    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);

    return;
}

- (void)dealloc {
    [super dealloc];
}

- (void)setStyle:(PFBackgroundViewStyle)newPosition {
    style = newPosition;
    [self setNeedsDisplay];
}

- (void)setBorderWithStyle:(PFBackgroundViewBorderStyle)borderStyle color:(UIColor *)color width:(CGFloat)width {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setValue:[NSNumber numberWithInt:borderStyle] forKey:@"borderStyle"];
    [dictionary setValue:color forKey:@"color"];
    [dictionary setValue:[NSNumber numberWithFloat:width] forKey:@"width"];
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:borders];
    [tempArray addObject:dictionary];
    borders = tempArray;
}


@end
