//
//  SCMiniGridView.m
//  Scribe
//
//  Created by Stephen Searles on 12/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SCMiniGridView.h"
#import "SCCellView.h"
#import "SCMiniGrid.h"
#import "SCScribeBoard.h"
#import "XY.h"

const NSUInteger MINI_GRID_PADDING = 2;

@implementation SCMiniGridView

@synthesize expandedFrame;
@synthesize cellShade = _shade;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        originalFrame = frame;
        self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |
                                UIViewAutoresizingFlexibleWidth |
                                UIViewAutoresizingFlexibleRightMargin |
                                UIViewAutoresizingFlexibleTopMargin |
                                UIViewAutoresizingFlexibleHeight |
                                UIViewAutoresizingFlexibleBottomMargin;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame miniGrid:(SCMiniGrid *)miniGrid {
    self = [self initWithFrame:frame];
    CGFloat cellWidth = frame.size.width/3 - MINI_GRID_PADDING;
    CGFloat cellHeight = frame.size.height/3 - MINI_GRID_PADDING;
    _miniGrid = miniGrid;
    
    for (int x = 0; x < MINI_GRID_SIZE; x++) {
        for (int y = 0; y < MINI_GRID_SIZE; y++) {
            CGRect grid = CGRectMake(x * cellWidth + (x + 1) * MINI_GRID_PADDING, y * cellHeight + (y + 1) * MINI_GRID_PADDING, cellWidth, cellHeight);
            SCCellView * cellView = [[SCCellView alloc] initWithFrame:grid];
            [self addSubview:cellView];
            cellView.positionInMiniGrid = [[XY alloc] initWithX:x Y:y];
            [[NSNotificationCenter defaultCenter] addObserver:miniGrid selector:@selector(cellTapped:) name:SCCellTappedNotification object:cellView];
        }
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playersSwitched:) name:SCPlayersSwitchedNotification object:nil];
    return self;
}

- (void)playersSwitched:(NSNotification *)notification {
    SCScribeBoard * board = [notification object];
    if (board.currentPlayer == SCRedPlayer) {
        if ([_miniGrid.positionInGrid isEqual:board.lastRedPlayedCell] || [board canMoveAnywhere]) {
            self.cellShade = NO;
        } else {
            self.cellShade = YES;
        }
    } else {
        if ([_miniGrid.positionInGrid isEqual:board.lastBluePlayedCell] || [board canMoveAnywhere]) {
            self.cellShade = NO;
        } else {
            self.cellShade = YES;
        }
    }
}

- (void)setCellShade:(BOOL)shade {
    for (SCCellView * cell in self.subviews) {
        cell.cellShade = shade;
        [cell setNeedsDisplay];
    }
}

- (void)setExpandedFrame:(CGRect)frame {
    expandedFrame = frame;
    gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(expandToFrame)];
    [self addGestureRecognizer:gestureRecognizer];
}

- (void)reduceFrame {
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = originalFrame;
        self.superview.superview.backgroundColor = [UIColor whiteColor];
        self.superview.superview.alpha = 1.0;
        for (UIView * subview in self.superview.subviews) {
            subview.alpha = 1.0;
        }
        for (SCCellView * subview in self.subviews) {
            subview.listenForTaps = NO;
        }
    }];
}

- (void)expandToFrame {
    [self.superview bringSubviewToFront:self];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.superview.superview.backgroundColor = [UIColor colorWithRed:.5 green:.5 blue:.5 alpha:.5];
        self.frame = expandedFrame;

        for (UIView * subview in self.superview.subviews) {
            if (subview != self) {
                subview.alpha = 0;
            }
        }
        
        for (SCCellView * subview in self.subviews) {
            subview.listenForTaps = YES;
        }

    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
