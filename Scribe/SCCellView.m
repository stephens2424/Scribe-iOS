//
//  SCCellView.m
//  Scribe
//
//  Created by Stephen Searles on 12/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SCCellView.h"

@implementation SCCellView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (CGPathRef)roundedRect:(CGRect)frame radius:(CGFloat)radius {
    if (!roundedRect) {
        CGMutablePathRef _roundedRect = CGPathCreateMutable();
        CGPathMoveToPoint(_roundedRect, NULL, frame.origin.x + radius, frame.origin.y);
        CGPathAddArcToPoint(_roundedRect, NULL, frame.origin.x, frame.origin.y, frame.origin.x, frame.origin.y + radius, radius);
        CGPathAddLineToPoint(_roundedRect, NULL, frame.origin.x,frame.size.height - radius);
        CGPathAddArcToPoint(_roundedRect, NULL, frame.origin.x, frame.size.height, frame.origin.x + radius, frame.size.height, radius);
        CGPathAddLineToPoint(_roundedRect, NULL, frame.size.width - radius, frame.size.height);
        CGPathAddArcToPoint(_roundedRect, NULL, frame.size.width, frame.size.height, frame.size.width, frame.size.height - radius, radius);
        CGPathAddLineToPoint(_roundedRect, NULL, frame.size.width, frame.origin.y + radius);
        CGPathAddArcToPoint(_roundedRect, NULL, frame.size.width, frame.origin.y, frame.size.width - radius, frame.origin.y, radius);
        CGPathCloseSubpath(_roundedRect);
        roundedRect = CGPathCreateCopy(_roundedRect);
        free(_roundedRect);
    }
    return roundedRect;
}

- (CGAffineTransform *)transformToSmall {
    if (!_transformToSmall) {
        _transformToSmall = malloc(sizeof(CGAffineTransform));
        * _transformToSmall = CGAffineTransformMakeScale(2, 2);
    }
    return _transformToSmall;
}

- (CGColorRef)red {
    if (!_red) {
        float red[4] = {1.0, 0, 0, 1.0};
        _red = CGColorCreate([self colorSpace], red);
    }
    return _red;
}
- (CGColorRef)blue {
    if (!_blue) {
        float blue[4] = {0.0, 0.0, 1.0, 1.0};
        _blue = CGColorCreate([self colorSpace], blue);
    }
    return _blue;
}
- (CGColorSpaceRef)colorSpace {
    if (!_colorSpace) {
        _colorSpace = CGColorSpaceCreateDeviceRGB();
    }
    return _colorSpace;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [self blue]);
    CGContextBeginPath(context);
    CGContextAddPath(context, [self roundedRect:rect radius:10]);
    CGContextFillPath(context);
}


@end
