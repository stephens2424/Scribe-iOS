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
    RED,
    BLUE
} SCPlayer;

@interface SCScribeBoard : NSObject {
    SCPlayer currentPlayer;
    NSSet * miniGrids;
}

@property (readonly) SCPlayer currentPlayer;
@property (readonly) NSSet * miniGrids;

- (SCMiniGrid *)miniGridAt:(XY *)xy;

@end
