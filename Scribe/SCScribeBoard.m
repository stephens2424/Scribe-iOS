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

const NSUInteger GRID_SIZE = 3;

@implementation SCScribeBoard

@synthesize currentPlayer;
@synthesize miniGrids;

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
        currentPlayer = SCBluePlayer;
    } else {
        currentPlayer = SCRedPlayer;
    }
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

@end
