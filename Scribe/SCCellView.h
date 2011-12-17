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

typedef enum {
    SCCellUnplayed,
    SCCellInPlayRed,
    SCCellInPlayBlue,
    SCCellJustPlayedRed,
    SCCellJustPlayedBlue,
    SCCellPlayedRed,
    SCCellPlayedBlue
} SCCellState;

@interface SCCellView : UIView {
    CGAffineTransform * _transformToSmall;
    CGColorRef _red;
    CGColorRef _blue;
    CGColorRef _unplayed;
    CGColorSpaceRef _colorSpace;
    UIGestureRecognizer * recognizer;
    SCCellState _cellState;
    XY * xy;
    BOOL _listenForTaps;
}

@property (retain) XY * positionInMiniGrid;
@property (nonatomic,assign) BOOL listenForTaps;
@property (nonatomic,assign) SCCellState cellState;

- (CGAffineTransform *)transformToSmall;
- (CGColorRef)red;
- (CGColorRef)blue;
- (CGColorSpaceRef)colorSpace;

@end