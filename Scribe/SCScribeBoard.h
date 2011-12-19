//
//  SCScribeBoard.h
//  Scribe
//
//  Created by Stephen Searles on 12/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SCMiniGrid;
@class XY;

extern const NSUInteger GRID_SIZE;

typedef enum {
    SCRedPlayer,
    SCBluePlayer
} SCPlayer;

@interface SCScribeBoard : NSObject {
    SCPlayer currentPlayer;
    NSSet * miniGrids;
    SCMiniGrid * lastRedPlayedMiniGrid;
    XY * lastRedPlayedCell;
    SCMiniGrid * lastBluePlayedMiniGrid;
    XY * lastBluePlayedCell;
    SCMiniGrid * currentlySelectedMiniGrid;
    XY * currentlySelectedCell;
    BOOL canMoveAnywhere;
}

@property (readonly) SCPlayer currentPlayer;
@property (readonly) NSSet * miniGrids;
@property (retain) SCMiniGrid * lastRedPlayedMiniGrid;
@property (retain) SCMiniGrid * lastBluePlayedMiniGrid;
@property (retain) XY * lastRedPlayedCell;
@property (retain) XY * lastBluePlayedCell;
@property (retain) SCMiniGrid * currentlySelectedMiniGrid;
@property (retain) XY * currentlySelectedCell;
@property (assign) BOOL canMoveAnywhere;

- (SCMiniGrid *)miniGridAt:(XY *)xy;
- (BOOL)availablePositionsAtXY:(XY *)xy;

@end
