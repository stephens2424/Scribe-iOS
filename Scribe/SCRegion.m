//
//  SCRegion.m
//  Scribe
//
//  Created by Stephen Searles on 1/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SCRegion.h"
#import "XY.h"

@implementation SCRegion

@synthesize squares;
@synthesize player = _player;

- (id)initForPlayer:(SCPlayer)player {
    self = [super init];
    if (self) {
        _player = player;
        squares = [[NSMutableSet alloc] initWithCapacity:9];
    }
    return self;
}

- (id)initByMergingRegions:(SCRegion *)regionOne and:(SCRegion *)regionTwo {
    self = [self initForPlayer:[regionOne player]];
    if (self) {
        [squares unionSet:regionOne.squares];
        [squares unionSet:regionTwo.squares];
    }
    return self;
}

- (BOOL)addPotentialMember:(XY *)xy forPlayer:(SCPlayer)player {
    if (player == _player) {
        if ([squares count] > 0) {
            for (XY * memberSquare in squares) {
                if ([xy isAdjacent:memberSquare]) {
                    [squares addObject:xy];
                    return YES;
                }
            }
        } else {
            [squares addObject:xy];
            return YES;
        }
    }
    return NO;
}

- (BOOL)regionsShouldMerge:(SCRegion *)otherRegion {
    if ([self player] == [otherRegion player]) {
        for (id otherSquare in otherRegion.squares) {
            if ([self addPotentialMember:otherSquare forPlayer:[otherRegion player]]) {
                return YES;
            }
        }
    }
    return NO;
}

@end
