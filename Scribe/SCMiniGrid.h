//
//  SCMiniGrid.h
//  Scribe
//
//  Created by Stephen Searles on 12/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XY;
@class SCCellView;
@class SCScribeBoard;

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
- (void)cellTapped:(SCCellView *)cell;
- (void)addOwnership:(NSUInteger)ownership at:(XY *)xy;
- (BOOL)cellOwned:(XY *)xy;

@end
