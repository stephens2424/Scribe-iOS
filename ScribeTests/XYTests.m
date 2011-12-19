//
//  XYTests.m
//  Scribe
//
//  Created by Stephen Searles on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "XYTests.h"
#import "XY.h"

@implementation XYTests

// All code under test must be linked into the Unit Test bundle
- (void)testAllXYs
{
    NSUInteger trueXYs = 9;
    NSSet * xys = [XY allXYs];
    NSUInteger testedXYs = [xys count];
    STAssertEqualsWithAccuracy(trueXYs, testedXYs, 0, @"Incorrect number of coordinates");
    NSUInteger xTotal = 0;
    NSUInteger yTotal = 0;
    for (XY * xy in xys) {
        xTotal += xy.x;
        yTotal += xy.y;
    }
    STAssertEqualsWithAccuracy(xTotal, trueXYs, 0, @"Incorrect X coordinates. Should be 0, 1, and 2.");
    STAssertEqualsWithAccuracy(yTotal, trueXYs, 0, @"Incorrect Y coordinates. Should be 0, 1, and 2.");
}

- (void)testAdjacency {
    XY * topRight = [[XY alloc] initWithX:2 Y:0];
    XY * middleRight = [[XY alloc] initWithX:2 Y:1];
    XY * center = [[XY alloc] initWithX:1 Y:1];
    XY * bottomLeft = [[XY alloc] initWithX:0 Y:2];
    STAssertTrue([topRight isAdjacent:middleRight], @"2,0 and 2,1 should be adjacent.");
    STAssertFalse([topRight isAdjacent:bottomLeft], @"2,0 and 0,2 should not be adjacent.");
    STAssertTrue([center isAdjacent:middleRight], @"2,1 and 1,1 should be adjacent.");
}

@end
