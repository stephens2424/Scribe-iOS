//
//  SCMiniGridView.m
//  Scribe
//
//  Created by Stephen Searles on 12/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SCMiniGridView.h"
#import "SCCellView.h"
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
            [self addSubview:[[SCCellView alloc] initWithFrame:grid[i]]];
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

- (void)setExpandedFrame:(CGRect)frame {
    expandedFrame = frame;
    gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(expandToFrame)];
    [self addGestureRecognizer:gestureRecognizer];
}

- (void)reduceFrame {
    self.frame = originalFrame;
}

- (void)expandToFrame {
    [self.superview bringSubviewToFront:self];
    self.frame = expandedFrame;
    CGRect grid[9];
    gridForFrame(grid, self.bounds, MINI_GRID_PADDING, MINI_GRID_SIZE);
    int i = 0;
    for (UIView * subview in self.subviews) {
        subview.frame = grid[i];
        i++;
        [subview setNeedsDisplay];
    }
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
