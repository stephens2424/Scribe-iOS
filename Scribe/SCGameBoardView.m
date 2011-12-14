//
//  SCGameBoardView.m
//  Scribe
//
//  Created by Stephen Searles on 12/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SCGameBoardView.h"
#import "SCMiniGridView.h"

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
            [self addSubview:[[SCMiniGridView alloc] initWithFrame:grid[i]]];
        }
    }
    return self;
}


/*
- (void)drawRect:(CGRect)rect
{
}
*/

@end
