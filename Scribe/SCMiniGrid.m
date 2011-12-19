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
#import "XY.h"

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
    if ((scribeBoard.currentPlayer == SCBluePlayer  && [scribeBoard.lastBluePlayedCell isEqual:cell.positionInMiniGrid]) ||
        (scribeBoard.currentPlayer == SCRedPlayer   && [scribeBoard.lastRedPlayedCell isEqual:cell.positionInMiniGrid])) {
            return;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:SCCellSelectedNotification object:cell];
    scribeBoard.currentlySelectedMiniGrid = self;
    scribeBoard.currentlySelectedCell = cell.positionInMiniGrid;
    if (scribeBoard.currentPlayer == SCBluePlayer) {
        cell.cellOwnership = SCCellBlue;
    } else {
        cell.cellOwnership = SCCellRed;
    }
    cell.cellState = SCCellInPlay;
}

@end
