//
//  SCCellView.h
//  Scribe
//
//  Created by Stephen Searles on 12/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XY;

static NSString * SCCellTappedNotification = @"SCCellTappedNotification";

@interface SCCellView : UIView {
    CGAffineTransform * _transformToSmall;
    CGColorRef _red;
    CGColorRef _blue;
    CGColorRef color;
    CGColorSpaceRef _colorSpace;
    UIGestureRecognizer * recognizer;
    XY * xy;
    BOOL _listenForTaps;
}

@property (assign) CGColorRef color;
@property (retain) XY * positionInMiniGrid;
@property (nonatomic,assign) BOOL listenForTaps;

- (CGAffineTransform *)transformToSmall;
- (CGColorRef)red;
- (CGColorRef)blue;
- (CGColorSpaceRef)colorSpace;

@end
