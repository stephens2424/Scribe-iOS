//
//  SCCellView.m
//  Scribe
//
//  Created by Stephen Searles on 12/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SCCellView.h"
#import "XY.h"

@implementation SCCellView

@synthesize color;
@synthesize positionInMiniGrid = xy;
@synthesize listenForTaps = _listenForTaps;
@synthesize cellState;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |
        UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleRightMargin |
        UIViewAutoresizingFlexibleTopMargin |
        UIViewAutoresizingFlexibleHeight |
        UIViewAutoresizingFlexibleBottomMargin;
        self.contentMode = UIViewContentModeRedraw;
        float _color[4] = {0.8, 0.8, 0.8, 0.8};
        self.color = CGColorCreate([self colorSpace], _color);
        cellState = SCCellUnplayed;
    }
    recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(notifyOnTap)];
    self.listenForTaps = NO;
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)setListenForTaps:(BOOL)listenForTaps {
    if (listenForTaps) {
        [self addGestureRecognizer:recognizer];
    } else {
        [self removeGestureRecognizer:recognizer];
    }
}

- (void)notifyOnTap {
    [[NSNotificationCenter defaultCenter] postNotificationName:SCCellTappedNotification object:self];
    cellState = SCCellJustPlayed;
    [self setNeedsDisplay];
}

- (CGPathRef)roundedRect:(CGRect)bounds radius:(CGFloat)radius {
    CGMutablePathRef _roundedRect = CGPathCreateMutable();
    CGPathMoveToPoint(_roundedRect, NULL, bounds.origin.x + radius, bounds.origin.y);
    CGPathAddArcToPoint(_roundedRect, NULL, bounds.origin.x, bounds.origin.y, bounds.origin.x, bounds.origin.y + radius, radius);
    CGPathAddLineToPoint(_roundedRect, NULL, bounds.origin.x,bounds.size.height - radius);
    CGPathAddArcToPoint(_roundedRect, NULL, bounds.origin.x, bounds.size.height, bounds.origin.x + radius, bounds.size.height, radius);
    CGPathAddLineToPoint(_roundedRect, NULL, bounds.size.width - radius, bounds.size.height);
    CGPathAddArcToPoint(_roundedRect, NULL, bounds.size.width, bounds.size.height, bounds.size.width, bounds.size.height - radius, radius);
    CGPathAddLineToPoint(_roundedRect, NULL, bounds.size.width, bounds.origin.y + radius);
    CGPathAddArcToPoint(_roundedRect, NULL, bounds.size.width, bounds.origin.y, bounds.size.width - radius, bounds.origin.y, radius);
    CGPathCloseSubpath(_roundedRect);
    return _roundedRect;
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
    
    CGContextSetFillColorWithColor(context, color);
    CGContextBeginPath(context);
    CGPathRef roundedRect = [self roundedRect:rect radius:self.bounds.size.height/5];
    CGContextAddPath(context, roundedRect);
    CGContextFillPath(context);
    
    CGContextBeginPath(context);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextAddPath(context, roundedRect);
    CGContextSetRGBStrokeColor(context, .1, .1, .1, .4);
    CGContextSetLineWidth(context, 1);
    CGContextStrokePath(context);
    
    switch (cellState) {
        case SCCellInPlay:
            CGContextBeginPath(context);
            CGContextSetRGBStrokeColor(context, 1, 1, 1, 1);
            CGContextAddArc(context, self.bounds.size.height/2,self.bounds.size.width/2, self.bounds.size.height/4, 0, 2*M_PI, 0);
            CGContextStrokePath(context);
            break;
        case SCCellJustPlayed:
            CGContextBeginPath(context);
            CGContextSetRGBFillColor(context, 1, 1, 1, 1);
            CGContextAddArc(context, self.bounds.size.height/2,self.bounds.size.width/2, self.bounds.size.height/4, 0, 2*M_PI, 0);
            CGContextFillPath(context);
            break;
        default:
            break;
    }
    
}


@end
