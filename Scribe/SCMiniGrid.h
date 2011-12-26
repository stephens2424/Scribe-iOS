//
//  SCMiniGrid.h
//  Scribe
//
//  Created by Stephen Searles on 12/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCScribeBoard.h"
@class XY;
@class SCCellView;

extern const NSUInteger MINI_GRID_SIZE;
static NSString * SCCellSelectedNotification = @"SCMoveSelectedNotification";
static NSString * SCCellPlayedNotification = @"SCCellPlayedNotification";

@interface SCMiniGrid : NSObject {
    XY * positionInGrid;
    SCScribeBoard * scribeBoard;
    NSMutableDictionary * cellOwnerships;
}

@property (readonly) XY * positionInGrid;

- (id)initWithPosition:(XY *)position onBoard:(SCScribeBoard *)board;
- (id)initWithTestString:(NSString *)string;
- (void)cellTapped:(SCCellView *)cell;
- (void)addOwnership:(SCPlayer)ownership at:(XY *)xy;
- (BOOL)cellOwned:(XY *)xy;
- (BOOL)availablePosition;

- (NSUInteger)regions;
- (SCPlayer)winner;

@end
