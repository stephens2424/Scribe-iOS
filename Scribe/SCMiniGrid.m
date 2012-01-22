//
//  SCMiniGrid.m
//  Scribe
//
//  Created by Stephen Searles on 12/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SCMiniGrid.h"
#import "SCCellView.h"
#import "SCScribeBoard.h"
#import "SCRegion.h"
#import "XY.h"

const NSUInteger MINI_GRID_SIZE = 3;

@implementation SCMiniGrid

@synthesize positionInGrid;

- (id)initWithPosition:(XY *)position onBoard:(SCScribeBoard *)board {
    self = [super init];
    if (self) {
        positionInGrid = position;
        scribeBoard = board;
        cellOwnerships = [[NSMutableDictionary alloc] initWithCapacity:9];
    }
    return self;
}

- (id)initWithTestString:(NSString *)string {
    self = [self initWithPosition:nil onBoard:nil];
    NSUInteger row = 0;
    NSUInteger cell = 0;
    while ([string length] > 0) {
        NSString * current = [string substringToIndex:1];
        string = [string substringFromIndex:1];
        if ([current isEqualToString:@"+"]) {
            XY * currentXY = [[XY alloc] initWithX:cell Y:row];
            [self addOwnership:SCBluePlayer at:currentXY];
            cell += 1;
        } else if ([current isEqualToString:@"O"]) {
            XY * currentXY = [[XY alloc] initWithX:cell Y:row];
            [self addOwnership:SCRedPlayer at:currentXY];
            cell += 1;
        } else {
            row += 1;
            cell = 0;
        }
    }
    return self;
}

- (BOOL)legalBlueMove:(XY *)move {
    if (
        scribeBoard.currentPlayer == SCBluePlayer && 
        ([scribeBoard.lastBluePlayedCell isEqual:move] || scribeBoard.lastBluePlayedCell == nil)) 
        return YES;
    else
        return NO;
}

- (BOOL)legalRedMove:(XY *)move {
    if (
        scribeBoard.currentPlayer == SCRedPlayer && 
        ([scribeBoard.lastRedPlayedCell isEqual:move] || scribeBoard.lastRedPlayedCell == nil))
        return YES;
    else
        return NO;
}

- (void)cellTapped:(NSNotification *)notification {
    SCCellView * cell = [notification object];
    if (![self legalBlueMove:positionInGrid] && ![self legalRedMove:positionInGrid] && ![scribeBoard canMoveAnywhere]) return;
    
    if (cell.cellState != SCCellUnplayed) return;
    [[NSNotificationCenter defaultCenter] postNotificationName:SCCellSelectedNotification object:cell];
    scribeBoard.currentlySelectedMiniGrid = self;
    scribeBoard.currentlySelectedCell = cell.positionInMiniGrid;
    if (scribeBoard.currentPlayer == SCBluePlayer) {
        cell.cellOwnership = SCCellBlue;
    } else {
        cell.cellOwnership = SCCellRed;
    }
    cell.cellState = SCCellInPlay;
}

- (void)addOwnership:(SCPlayer)ownership at:(XY *)xy {
    id key = [xy description];
    id value = [NSNumber numberWithUnsignedInteger:ownership];
    [cellOwnerships setObject:value forKey:key];
}

- (BOOL)cellOwned:(XY *)xy {
    if ([cellOwnerships objectForKey:[xy description]] && [[cellOwnerships objectForKey:[xy description]] unsignedIntegerValue] != SCCellUnowned)
        return YES;
    else
        return NO;
}

- (SCPlayer)cellOwnedBy:(XY *)xy {
    if ([cellOwnerships objectForKey:[xy description]] && [[cellOwnerships objectForKey:[xy description]] unsignedIntegerValue] == SCRedPlayer)
        return SCRedPlayer;
    else if ([cellOwnerships objectForKey:[xy description]] && [[cellOwnerships objectForKey:[xy description]] unsignedIntegerValue] == SCBluePlayer)
        return SCBluePlayer;
    else
        return SCNoPlayer;
}

- (BOOL)availablePosition {
    for (XY * xy in [XY allXYs]) {
        if (![self cellOwned:xy]) return YES;
    }
    return NO;
}

- (NSSet *)regions {
    NSLog(@"%@",[self description]);
    NSMutableSet * regions = [[NSMutableSet alloc] initWithCapacity:9];
    for (id cell in cellOwnerships) {
        SCRegion * newRegion = [[SCRegion alloc] initForPlayer:[[cellOwnerships objectForKey:cell] unsignedIntegerValue]];
        [newRegion addPotentialMember:[[XY alloc] initWithString:cell] forPlayer:[[cellOwnerships objectForKey:cell] unsignedIntegerValue]];
        [regions addObject:newRegion];
    }
    assert([regions count] == 9);
    for (SCRegion * region in regions) {
        assert([region.squares count] == 1);
    }
    [self checkRegions:regions];
    BOOL merged;
    do {
        merged = NO;
        NSMutableSet * newRegions = [[NSMutableSet alloc] initWithCapacity:[regions count]];
        for (SCRegion * firstRegion in regions) {
            for (SCRegion * secondRegion in regions) {
                if (firstRegion != secondRegion && [firstRegion regionsShouldMerge:secondRegion] && !merged) {
                    SCRegion * combinedRegion = [[SCRegion alloc] initByMergingRegions:firstRegion and:secondRegion];
                    [newRegions addObject:combinedRegion];
                    [newRegions unionSet:regions];
                    [newRegions removeObject:firstRegion];
                    [newRegions removeObject:secondRegion];
                    merged = YES;
                } else if (merged) {
                    break;
                }
            }
            if (merged) break;
        }
        if (merged) {
            regions = newRegions;
            [self checkRegions:regions];
        }
    } while (merged);
    return regions;
}

- (void)checkRegions:(NSSet *)regions {
    NSSet * xys = [XY allXYs];
    NSMutableArray * rXys = [[NSMutableArray alloc] initWithCapacity:9];
    for (SCRegion * region in regions) {
        [rXys addObjectsFromArray:[region.squares allObjects]];
    }
    NSUInteger expectedCount = 9;
    assert([rXys count] == expectedCount);
    for (id xy in xys) {
        [rXys removeObject:xy];
        expectedCount -= 1;
        assert([rXys count] == expectedCount);
    }
}

- (SCPlayer)winner {
    NSUInteger blueGlyphs = 0;
    NSUInteger redGlyphs = 0;
    for (SCRegion * region in [self regions]) {
        if ([region isGlyph]) {
            if (region.player == SCBluePlayer) {
                blueGlyphs += [region.squares count];
            }
            else if (region.player == SCRedPlayer) {
                redGlyphs += [region.squares count];
            }
        }
    }
    if (blueGlyphs > redGlyphs) {
        return SCBluePlayer;
    }
    else if (redGlyphs < blueGlyphs) {
        return SCRedPlayer;
    }
    else return SCNoPlayer;
}

- (NSString *)description {
    NSDictionary * ownerships = [self allOwnerships];
    NSMutableString * desc = [[NSMutableString alloc] initWithCapacity:13];
    [desc appendString:@"\n"];
    for (NSUInteger x = 0; x <= 2; x++) {
        for (NSUInteger y = 0; y <= 2; y++) {
            id key = [[XY alloc] initWithX:x Y:y];
            id current = [ownerships objectForKey:[key description]];
            if ([current unsignedIntegerValue] == SCBluePlayer)
                current = @"+";
            else if ([current unsignedIntegerValue] == SCRedPlayer)
                current = @"O";
            else
                current = @" ";
            [desc appendFormat:@"%@",current];
        }
        [desc appendString:@"\n"];
    }
    return desc;
}

- (void)printRegions:(NSSet *)regions {
    NSArray * regionArray = [regions allObjects];
    NSMutableString * desc = [[NSMutableString alloc] initWithCapacity:13];
    [desc appendString:@"\n"];
    for (NSUInteger x = 0; x <= 2; x++) {
        for (NSUInteger y = 0; y <= 2; y++) {
            NSString * key = [[[XY alloc] initWithX:x Y:y] description];
            NSString * current = @" ";
            for (SCRegion * region in regionArray) {
                if ([region.squares containsObject:key]) {
                    current = [NSString stringWithFormat:@"%u",[regionArray indexOfObject:region]];
                }
            }
            [desc appendFormat:@"%@",current];
        }
        [desc appendString:@"\n"];
    }
    NSLog(@"%@",desc);
}

- (NSDictionary *)allOwnerships {
    NSMutableDictionary * ownerships = [[NSMutableDictionary alloc] initWithCapacity:9];
    NSSet * xys = [XY allXYs];
    for (XY * xy in xys) {
        NSUInteger ownership = [self cellOwnedBy:xy];
        NSNumber * wOwnership = [NSNumber numberWithUnsignedInteger:ownership];
        [ownerships setObject:wOwnership forKey:[xy description]];
    }
    return ownerships;
}

@end
