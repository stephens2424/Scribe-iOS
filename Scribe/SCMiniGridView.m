//
//  SCMiniGridView.m
//  Scribe
//
//  Created by Stephen Searles on 12/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SCMiniGridView.h"
#import "SCCellView.h"

const NSUInteger MINI_GRID_PADDING = 2;

@implementation SCMiniGridView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect grid[9];
        gridForFrame(grid, frame, MINI_GRID_PADDING, MINI_GRID_SIZE);
        int gridLength = sizeof(grid)/sizeof(CGRect);
        for (int i = 0; i < gridLength; i++) {
            [self addSubview:[[SCCellView alloc] initWithFrame:grid[i]]];
        }
    }
    return self;
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
