//
//  SCGameBoardView.m
//  Scribe
//
//  Created by Stephen Searles on 12/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SCGameBoardView.h"

@implementation SCGameBoardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (CGPathRef)roundedRect {
    if (!roundedRect) {
        CGMutablePathRef _roundedRect = CGPathCreateMutable();
        CGPathMoveToPoint(_roundedRect, NULL, 10, 0);
        CGPathAddArcToPoint(_roundedRect, NULL, 0, 0, 0, 10, 10);
        CGPathAddLineToPoint(_roundedRect, NULL, 0, 30);
        CGPathAddArcToPoint(_roundedRect, NULL, 0, 40, 10, 40, 10);
        CGPathAddLineToPoint(_roundedRect, NULL, 30, 40);
        CGPathAddArcToPoint(_roundedRect, NULL, 40, 40, 40, 30, 10);
        CGPathAddLineToPoint(_roundedRect, NULL, 40, 10);
        CGPathAddArcToPoint(_roundedRect, NULL, 40, 0, 30, 0, 10);
        CGPathCloseSubpath(_roundedRect);
        roundedRect = CGPathCreateCopy(_roundedRect);
        free(_roundedRect);
    }
    return roundedRect;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextAddPath(context, [self roundedRect]);
    CGContextFillPath(context);
}


@end
