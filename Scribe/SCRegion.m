//
//  SCRegion.m
//  Scribe
//
//  Created by Stephen Searles on 1/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SCRegion.h"
#import "XY.h"
#import "SCMiniGrid.h"
#import "SCGlyphs.h"

@interface SCRegion()

- (id)normalizedRegion;
- (id)reflectedRegion;

@end

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

- (id)initWithSquares:(NSSet *)set forPlayer:(SCPlayer)player {
    self = [super init];
    if (self) {
        _player = player;
        squares = [[NSMutableSet alloc] initWithSet:set];
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

- (id)normalizedRegion {
    if (!normalized) {
        NSUInteger minX = MINI_GRID_SIZE;
        NSUInteger minY = MINI_GRID_SIZE;
        for (XY * xy in self.squares) {
            minX = MIN(minX, xy.x);
            minY = MIN(minY, xy.y);
        }
        normalized = [[SCRegion alloc] initForPlayer:self.player];
        for (XY * xy in self.squares) {
            [squares addObject:[[XY alloc] initWithX:xy.x - minX Y:xy.y - minY]];
        }
    }
    return normalized;
}

- (id)reflectedRegion {
    NSMutableSet * reflectedSquares = [[NSMutableSet alloc] initWithCapacity:9];
    for (XY * xy in self.squares) {
        [reflectedSquares addObject:[[XY alloc] initWithX:MINI_GRID_SIZE - xy.x Y:xy.y]];
    }
    return [[SCRegion alloc] initWithSquares:reflectedSquares forPlayer:_player];
}

- (id)rotated90Degrees {
    NSMutableSet * rotatedSquares = [[NSMutableSet alloc] initWithCapacity:9];
    for (XY * xy in self.squares) {
        [rotatedSquares addObject:[[XY alloc] initWithX:2 - xy.y Y:xy.x]];
    }
    return [[SCRegion alloc] initWithSquares:rotatedSquares forPlayer:_player];
}

- (BOOL)isEqualShape:(SCRegion *)otherRegion {
    id r = self.normalizedRegion;
    id rr = [self.normalizedRegion reflectedRegion];

    if ([r isEqual:otherRegion.normalizedRegion]) return YES;
    if ([rr isEqual:otherRegion.normalizedRegion]) return YES;
    for (int i = 3; i > 0; i--) {
        r = [r rotated90Degrees];
        rr = [rr rotated90Degrees];
        if ([r isEqual:otherRegion.normalizedRegion]) return YES;
        if ([rr isEqual:otherRegion.normalizedRegion]) return YES;
    }
    return NO;
}

- (BOOL)isEqual:(id)object {
    if ([object isMemberOfClass:[SCRegion class]]) {
        NSMutableSet * remainingOtherSquares = [NSMutableSet setWithSet:[object squares]];
        if ([remainingOtherSquares count] != [self.squares count]) return NO;
        for (XY * xy in self.squares) {
            [remainingOtherSquares removeObject:xy];
        }
        if ([remainingOtherSquares count] == 0) return YES;
    }
    return NO;
}

- (BOOL)isGlyph {
    SCGlyphs * glyphs = [[SCGlyphs alloc] init];
    for (NSDictionary * glyph in glyphs.allGlyphs) {
        if ([self isEqualShape:[glyph objectForKey:@"region"]]) return YES;
    }
    return NO;
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

- (BOOL)isPotentialMember:(XY *)xy forPlayer:(SCPlayer)player {
    if (player == _player) {
        if ([squares count] > 0) {
            for (XY * memberSquare in squares) {
                if ([xy isAdjacent:memberSquare]) {
                    return YES;
                }
            }
        } else {
            return YES;
        }
    }
    return NO;
}

- (BOOL)regionsShouldMerge:(SCRegion *)otherRegion {
    if ([self player] == [otherRegion player]) {
        for (id otherSquare in otherRegion.squares) {
            if ([self isPotentialMember:otherSquare forPlayer:[otherRegion player]]) {
                return YES;
            }
        }
    }
    return NO;
}

@end
