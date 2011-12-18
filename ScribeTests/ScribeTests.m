//
//  ScribeTests.m
//  ScribeTests
//
//  Created by Stephen Searles on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ScribeTests.h"
#import "SCScribeBoard.h"

@implementation ScribeTests

- (void)setUp
{
    [super setUp];
    testSubject = [[SCScribeBoard alloc] init];
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testMiniGrids
{
    NSUInteger n = [[testSubject miniGrids] count];
    NSUInteger miniGrids = 9;
    STAssertEqualsWithAccuracy(n, miniGrids, 0, @"Board does not have 9 mini grids.");
}

@end
