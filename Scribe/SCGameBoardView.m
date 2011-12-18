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
#import "SCMiniGrid.h"

const NSUInteger GRID_PADDING = 4;

@implementation SCGameBoardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetBoard) name:SCCellPlayedNotification object:nil];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame gameBoard:(SCScribeBoard *)board {
    self = [self initWithFrame:frame];
    scribeBoard = board;
    CGFloat cellWidth = frame.size.width/3 - GRID_PADDING;
    CGFloat cellHeight = frame.size.height/3 - GRID_PADDING;
    
    for (int x = 0; x < GRID_SIZE; x++) {
        for (int y = 0; y < GRID_SIZE; y++) {
            CGRect grid = CGRectMake(x * cellWidth + (x + 1) * GRID_PADDING, y * cellHeight + (y + 1) * GRID_PADDING, cellWidth, cellHeight);
            SCMiniGridView * miniGrid = [[SCMiniGridView alloc] initWithFrame:grid miniGrid:[board miniGridAt:[[XY alloc] initWithX:x Y:y]]];
            [miniGrid setExpandedFrame:self.bounds];
            [self addSubview:miniGrid];
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
