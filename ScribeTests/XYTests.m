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

@end
