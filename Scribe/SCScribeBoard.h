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
static NSString * SCPlayersSwitchedNotification = @"SCPlayersSwitchedNotification";

typedef enum {
    SCNoPlayer,
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
}

@property (readonly) SCPlayer currentPlayer;
@property (readonly) NSSet * miniGrids;
@property (retain) SCMiniGrid * lastRedPlayedMiniGrid;
@property (retain) SCMiniGrid * lastBluePlayedMiniGrid;
@property (retain) XY * lastRedPlayedCell;
@property (retain) XY * lastBluePlayedCell;
@property (retain) SCMiniGrid * currentlySelectedMiniGrid;
@property (retain) XY * currentlySelectedCell;

- (SCMiniGrid *)miniGridAt:(XY *)xy;
- (BOOL)availablePositionsAtXY:(XY *)xy;
- (BOOL)canMoveAnywhere;


@end
