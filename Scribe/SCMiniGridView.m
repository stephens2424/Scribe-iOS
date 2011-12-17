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
#import "XY.h"

const NSUInteger MINI_GRID_PADDING = 2;

@implementation SCMiniGridView

@synthesize expandedFrame;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        originalFrame = frame;
        CGRect grid[9];
        gridForFrame(grid, self.bounds, MINI_GRID_PADDING, MINI_GRID_SIZE);
        int gridLength = sizeof(grid)/sizeof(CGRect);
        for (int i = 0; i < gridLength; i++) {
            SCCellView * cellView = [[SCCellView alloc] initWithFrame:grid[i]];
            [self addSubview:cellView];
            cellView.positionInMiniGrid = [[XY alloc] initWithX:i % 3 + 1 Y:ceil(i / 3) + 1];
        }
        self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |
                                UIViewAutoresizingFlexibleWidth |
                                UIViewAutoresizingFlexibleRightMargin |
                                UIViewAutoresizingFlexibleTopMargin |
                                UIViewAutoresizingFlexibleHeight |
                                UIViewAutoresizingFlexibleBottomMargin;
    }
    return self;
}

- (void)makeMiniGrid:(XY *)xy onBoard:(SCScribeBoard *)board{
    _miniGrid = [[SCMiniGrid alloc] initWithPosition:xy onBoard:board];
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
