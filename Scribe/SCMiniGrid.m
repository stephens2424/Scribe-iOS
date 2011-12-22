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

- (BOOL)legalBlueMove:(XY *)move {
    if (
        scribeBoard.currentPlayer == SCBluePlayer && 
        ([scribeBoard.lastBluePlayedCell isEqual:move] || scribeBoard.lastBluePlayedCell == nil)) 
        return YES;
    else
        return NO;
}

- (BOOL)legalRedMove:(XY *)move {
    if (
        scribeBoard.currentPlayer == SCRedPlayer && 
        ([scribeBoard.lastRedPlayedCell isEqual:move] || scribeBoard.lastRedPlayedCell == nil))
        return YES;
    else
        return NO;
}

- (void)cellTapped:(NSNotification *)notification {
    SCCellView * cell = [notification object];
    if (![self legalBlueMove:positionInGrid] && ![self legalRedMove:positionInGrid] && ![scribeBoard canMoveAnywhere]) return;
    
    if (cell.cellState != SCCellUnplayed) return;
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

- (void)addOwnership:(NSUInteger)ownership at:(XY *)xy {
    [cellOwnerships setObject:[NSNumber numberWithUnsignedInteger:ownership] forKey:[xy description]];
}

- (BOOL)cellOwned:(XY *)xy {
    if ([cellOwnerships objectForKey:[xy description]] && [[cellOwnerships objectForKey:[xy description]] unsignedIntegerValue] != SCCellUnowned)
        return YES;
    else
        return NO;
}

@end
