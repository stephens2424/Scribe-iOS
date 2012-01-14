//
//  SCRegion.h
//  Scribe
//
//  Created by Stephen Searles on 1/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XY;
#import "SCScribeBoard.h"

@interface SCRegion : NSObject {
    NSMutableSet * squares;
    SCPlayer _player;
}

@property (readonly) NSSet * squares;
@property (readonly) SCPlayer player;

- (id)initForPlayer:(SCPlayer)player;
- (id)initByMergingRegions:(SCRegion *)regionOne and:(SCRegion *)regionTwo;
- (BOOL)addPotentialMember:(XY *)xy forPlayer:(SCPlayer)player;
- (BOOL)regionsShouldMerge:(SCRegion *)otherRegion;

@end
