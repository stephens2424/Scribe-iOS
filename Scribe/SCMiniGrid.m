//
//  SCMiniGrid.m
//  Scribe
//
//  Created by Stephen Searles on 12/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SCMiniGrid.h"
#import "SCCellView.h"
#import "SCScribeBoard.h"

const NSUInteger MINI_GRID_SIZE = 3;

@implementation SCMiniGrid

@synthesize positionInGrid;

- (id)initWithPosition:(XY *)position onBoard:(SCScribeBoard *)board {
    self = [super init];
    if (self) {
        positionInGrid = position;
        scribeBoard = board;
    }
    return self;
}

- (void)cellTapped:(NSNotification *)notification {
    SCCellView * cell = [notification object];
    [[NSNotificationCenter defaultCenter] postNotificationName:SCCellSelectedNotification object:cell];
    if (scribeBoard.currentPlayer == BLUE) {
        cell.cellState = SCCellInPlayBlue;
    } else {
        cell.cellState = SCCellInPlayRed;
    }
    NSLog(@"Cell %@ in miniGrid %@",cell.positionInMiniGrid,positionInGrid);
}

@end
