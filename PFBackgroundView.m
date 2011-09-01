//
//  PFBackgroundView.m
//  Pulpfingers
//
//  Created by David Charlec & Jerome Scheer on 08/26/2011
//  Copyright 2011 Pulpfingers. All rights reserved.
//

#import "PFBackgroundView.h"

@implementation PFBackgroundView

@synthesize style;
@synthesize radius;
@synthesize thumbnail;

- (id)init {
    self = [super init];
    if (self) {
        bgColor = [[UIColor whiteColor] retain];
        [self setRadius:12];
        self.style = PFBackgroundViewStyleRectangle;
    }
    return self;
}

- (BOOL)isOpaque {
    return NO;
}

-(void)setBackgroundColor:(UIColor *)color {
    bgColor = [color retain];
    return;
}

-(void)drawRect:(CGRect)aRect {
    [super drawRect:aRect];
    // Drawing code
        
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetShouldAntialias(context, YES);

    CGContextSetFillColorWithColor(context, bgColor.CGColor);
    
    CGRect rrect = self.bounds;
    CGFloat minx = CGRectGetMinX(rrect);
    CGFloat midx = CGRectGetMidX(rrect);
    CGFloat maxx = CGRectGetMaxX(rrect);
    
    CGFloat miny = CGRectGetMinY(rrect);
    CGFloat midy = CGRectGetMidY(rrect);
    CGFloat maxy = CGRectGetMaxY(rrect);
    
    minx++;
    maxx--;
//    miny++;
    maxy--;
    
    CGFloat topRadius = 10.0;
    CGFloat bottomRadius = 10.0;
    
    if (style == PFBackgroundViewStyleTopRounded) {
        
        bottomRadius = 0.0f;	
        
    } else if (style == PFBackgroundViewStyleBottomRounded) {
        NSLog(@"BOBBOM");

        topRadius = 0.0f;
        
    } else if (style == PFBackgroundViewStyleRectangle) {
		
        topRadius = 0.0f;
        bottomRadius = 0.0f;
		
    } 
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, minx, midy);
    
    CGContextAddArcToPoint(context, minx, miny, midx, miny, topRadius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, midy, topRadius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, bottomRadius);
    CGContextAddArcToPoint(context, minx, maxy, minx, midy, bottomRadius);
    
    CGContextClip(context);
    
    CGContextFillRect(context, self.bounds);
    if(self.thumbnail) {
        [self.thumbnail.image drawInRect:self.thumbnail.frame];
    }
    
    return;
}

- (void)dealloc {
    [super dealloc];
}

- (void)setStyle:(PFBackgroundViewStyle)newStyle {
    style = newStyle;
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
