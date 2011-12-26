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

- (id)initWithTestString:(NSString *)string {
    self = [self initWithPosition:nil onBoard:nil];
    NSUInteger row = 0;
    NSUInteger cell = 0;
    while ([string length] > 0) {
        NSString * current = [string substringToIndex:1];
        string = [string substringFromIndex:1];
        if ([current isEqualToString:@"+"]) {
            [self addOwnership:SCBluePlayer at:[[XY alloc] initWithX:cell Y:row]];
            cell += 1;
        } else if ([current isEqualToString:@"O"]) {
            [self addOwnership:SCRedPlayer at:[[XY alloc] initWithX:cell Y:row]];
            cell += 1;
        } else {
            row += 1;
            cell = 0;
        }
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

- (void)addOwnership:(SCPlayer)ownership at:(XY *)xy {
    [cellOwnerships setObject:[NSNumber numberWithUnsignedInteger:ownership] forKey:[xy description]];
}

- (BOOL)cellOwned:(XY *)xy {
    if ([cellOwnerships objectForKey:[xy description]] && [[cellOwnerships objectForKey:[xy description]] unsignedIntegerValue] != SCCellUnowned)
        return YES;
    else
        return NO;
}

- (BOOL)availablePosition {
    for (XY * xy in [XY allXYs]) {
        if (![self cellOwned:xy]) return YES;
    }
    return NO;
}

- (NSUInteger)regions {
    return 1;
}

- (SCPlayer)winner {
    return SCBluePlayer;
}

@end
