//
//  SCMiniGrid.m
//  Scribe
//
//  Created by Stephen Searles on 12/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SCMiniGrid.h"
#import "SCCellView.h"

const NSUInteger MINI_GRID_SIZE = 3;

@implementation SCMiniGrid

@synthesize positionInGrid;

- (id)initWithPosition:(XY *)position {
    self = [super init];
    if (self) {
        positionInGrid = position;
    }
    return self;
}

- (void)cellTapped:(SCCellView *)cell {
    [[NSNotificationCenter defaultCenter] postNotificationName:SCCellPlayedNotification object:cell];
    cell.cellState = SCCellInPlayBlue;
}

@end
