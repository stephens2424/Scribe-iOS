//
//  SCScribeBoard.m
//  Scribe
//
//  Created by Stephen Searles on 12/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SCScribeBoard.h"
#import "SCMiniGrid.h"
#import "XY.h"
#import "SCCellView.h"

const NSUInteger GRID_SIZE = 3;

@implementation SCScribeBoard

@synthesize currentPlayer;
@synthesize miniGrids;
@synthesize lastRedPlayedCell;
@synthesize lastBluePlayedCell;
@synthesize lastRedPlayedMiniGrid;
@synthesize lastBluePlayedMiniGrid;
@synthesize currentlySelectedCell;
@synthesize currentlySelectedMiniGrid;

- (id)init {
    self = [super init];
    if (self) {
        currentPlayer = SCRedPlayer;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchPlayers:) name:SCCellPlayedNotification object:nil];
        NSMutableSet * minigrids = [[NSMutableSet alloc] initWithCapacity:9];
        for (XY * xy in [XY allXYs]) {
            [minigrids addObject:[[SCMiniGrid alloc] initWithPosition:xy onBoard:self]];
        }
        miniGrids = minigrids;
    }
    return self;
}

- (void)switchPlayers:(NSNotification *)notification {
    if (currentPlayer == SCRedPlayer) {
        [currentlySelectedMiniGrid addOwnership:SCCellRed at:currentlySelectedCell];
        lastRedPlayedCell = currentlySelectedCell;
        lastRedPlayedMiniGrid = currentlySelectedMiniGrid;
        currentPlayer = SCBluePlayer;
    } else {
        [currentlySelectedMiniGrid addOwnership:SCCellBlue at:currentlySelectedCell];
        lastBluePlayedCell = currentlySelectedCell;
        lastBluePlayedMiniGrid = currentlySelectedMiniGrid;
        currentPlayer = SCRedPlayer;
    }
    currentlySelectedCell = nil;
    currentlySelectedMiniGrid = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:SCPlayersSwitchedNotification object:self];
}

- (SCMiniGrid *)miniGridAt:(XY *)xy {
    BOOL (^test)(SCMiniGrid * obj, BOOL *stop);
    test = ^ (SCMiniGrid * obj, BOOL *stop) {
        if ([[obj positionInGrid] isEqual:xy]) {
            *stop = YES;
            return YES;
        } else {
            return NO;
        }
    };
    return [[miniGrids objectsPassingTest:test] anyObject];
}

- (BOOL)availablePositionsAtXY:(XY *)xy {
    for (SCMiniGrid * miniGrid in miniGrids) {
        if (![miniGrid cellOwned:xy])
            return YES;
    }
    return NO;
}

- (BOOL)canMoveAnywhere {
    if (currentPlayer == SCRedPlayer && lastRedPlayedCell == nil) return YES;
    if (currentPlayer == SCBluePlayer && lastBluePlayedCell == nil) return YES;
    return ![[self miniGridAt:currentPlayer == SCRedPlayer ? lastRedPlayedCell : lastBluePlayedCell] availablePosition];
}

@end
