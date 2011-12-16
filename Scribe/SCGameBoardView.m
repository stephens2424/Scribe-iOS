//
//  SCGameBoardView.m
//  Scribe
//
//  Created by Stephen Searles on 12/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SCGameBoardView.h"
#import "SCMiniGridView.h"
#import "SCScribeBoard.h"
#import "XY.h"

const NSUInteger GRID_PADDING = 4;

@implementation SCGameBoardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect grid[9];
        gridForFrame(grid, frame, GRID_PADDING,GRID_SIZE );
        int gridLength = sizeof(grid)/sizeof(grid[0]);
        for (int i = 0; i < gridLength; i++) {
            SCMiniGridView * miniGrid = [[SCMiniGridView alloc] initWithFrame:grid[i]];
            [miniGrid setExpandedFrame:self.bounds];
            [self addSubview:miniGrid];
            [miniGrid makeMiniGrid:[[XY alloc] initWithX:i % 3 + 1 Y:ceil(i / 3) + 1]];
        }
    }
    return self;
}

- (void)resetBoard {
    for (SCMiniGridView * mg in self.subviews) {
        [mg reduceFrame];
    }
}

/*
- (void)drawRect:(CGRect)rect
{
}
*/

@end
