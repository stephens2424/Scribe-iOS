//
//  ScribeTests.m
//  ScribeTests
//
//  Created by Stephen Searles on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ScribeTests.h"
#import "SCScribeBoard.h"
#import "SCMiniGrid.h"

@implementation ScribeTests

- (void)setUp
{
    [super setUp];
    testSubject = [[SCScribeBoard alloc] init];
    
    // + is Blue, O is Red
    
    testGrids = [NSArray arrayWithObjects:
    // I guess you would call this a "squat U"?
    [NSArray arrayWithObjects:@"++O O+O ++O", [NSNumber numberWithUnsignedInteger:3], [NSNumber numberWithUnsignedInteger:SCRedPlayer], nil],
    
    [NSArray arrayWithObjects:@"OOO +OO O++", [NSNumber numberWithUnsignedInteger:4], [NSNumber numberWithUnsignedInteger:SCBluePlayer], nil],
    
    // Bomber
    [NSArray arrayWithObjects:@"+++ O++ OO+", [NSNumber numberWithUnsignedInteger:2], [NSNumber numberWithUnsignedInteger:SCBluePlayer], nil],
    [NSArray arrayWithObjects:@"+OO ++O +++", [NSNumber numberWithUnsignedInteger:2], [NSNumber numberWithUnsignedInteger:SCBluePlayer], nil],
    
    // Chair
    [NSArray arrayWithObjects:@"++O OOO O+O", [NSNumber numberWithUnsignedInteger:3], [NSNumber numberWithUnsignedInteger:SCRedPlayer], nil],
    [NSArray arrayWithObjects:@"+OO +O+ OOO", [NSNumber numberWithUnsignedInteger:3], [NSNumber numberWithUnsignedInteger:SCRedPlayer], nil],
    
    // Earring
    [NSArray arrayWithObjects:@"O++ +O+ +++", [NSNumber numberWithUnsignedInteger:3], [NSNumber numberWithUnsignedInteger:SCBluePlayer], nil],
    [NSArray arrayWithObjects:@"+OO O+O OOO", [NSNumber numberWithUnsignedInteger:3], [NSNumber numberWithUnsignedInteger:SCRedPlayer], nil],
    [NSArray arrayWithObjects:@"++O +O+ +++", [NSNumber numberWithUnsignedInteger:3], [NSNumber numberWithUnsignedInteger:SCBluePlayer], nil],
    [NSArray arrayWithObjects:@"+++ +O+ O++", [NSNumber numberWithUnsignedInteger:3], [NSNumber numberWithUnsignedInteger:SCBluePlayer], nil],
    
    // House
    [NSArray arrayWithObjects:@"O+O +++ +++", [NSNumber numberWithUnsignedInteger:3], [NSNumber numberWithUnsignedInteger:SCBluePlayer], nil],
    [NSArray arrayWithObjects:@"++O +++ ++O", [NSNumber numberWithUnsignedInteger:3], [NSNumber numberWithUnsignedInteger:SCBluePlayer], nil],
    [NSArray arrayWithObjects:@"+++ +++ O+O", [NSNumber numberWithUnsignedInteger:3], [NSNumber numberWithUnsignedInteger:SCBluePlayer], nil],
    [NSArray arrayWithObjects:@"O++ +++ O++", [NSNumber numberWithUnsignedInteger:3], [NSNumber numberWithUnsignedInteger:SCBluePlayer], nil],
    
    // O
    [NSArray arrayWithObjects:@"OOO O+O OOO", [NSNumber numberWithUnsignedInteger:2], [NSNumber numberWithUnsignedInteger:SCRedPlayer], nil],
    [NSArray arrayWithObjects:@"+++ +O+ +++", [NSNumber numberWithUnsignedInteger:2], [NSNumber numberWithUnsignedInteger:SCBluePlayer], nil],
    
    // J
    [NSArray arrayWithObjects:@"++O O+O OOO", [NSNumber numberWithUnsignedInteger:2], [NSNumber numberWithUnsignedInteger:SCRedPlayer], nil],
    [NSArray arrayWithObjects:@"OO+ O++ OOO", [NSNumber numberWithUnsignedInteger:2], [NSNumber numberWithUnsignedInteger:SCRedPlayer], nil],
    [NSArray arrayWithObjects:@"O++ O+O OOO", [NSNumber numberWithUnsignedInteger:2], [NSNumber numberWithUnsignedInteger:SCRedPlayer], nil],
    
    // Cross
    [NSArray arrayWithObjects:@"O+O +++ O+O", [NSNumber numberWithUnsignedInteger:5], [NSNumber numberWithUnsignedInteger:SCBluePlayer], nil],
    [NSArray arrayWithObjects:@"+O+ OOO +O+", [NSNumber numberWithUnsignedInteger:5], [NSNumber numberWithUnsignedInteger:SCRedPlayer], nil],
    
    // Six Block
    [NSArray arrayWithObjects:@"+++ +++ OOO", [NSNumber numberWithUnsignedInteger:2], [NSNumber numberWithUnsignedInteger:SCBluePlayer], nil],
    [NSArray arrayWithObjects:@"++O ++O ++O", [NSNumber numberWithUnsignedInteger:2], [NSNumber numberWithUnsignedInteger:SCBluePlayer], nil],
    
    // T
    [NSArray arrayWithObjects:@"OOO +O+ +O+", [NSNumber numberWithUnsignedInteger:3], [NSNumber numberWithUnsignedInteger:SCRedPlayer], nil],
    [NSArray arrayWithObjects:@"+O+ +O+ OOO", [NSNumber numberWithUnsignedInteger:3], [NSNumber numberWithUnsignedInteger:SCRedPlayer], nil],
    [NSArray arrayWithObjects:@"O++ OOO O++", [NSNumber numberWithUnsignedInteger:3], [NSNumber numberWithUnsignedInteger:SCRedPlayer], nil],
    [NSArray arrayWithObjects:@"++O OOO ++O", [NSNumber numberWithUnsignedInteger:3], [NSNumber numberWithUnsignedInteger:SCRedPlayer], nil],
    
    // U
    [NSArray arrayWithObjects:@"+O+ +O+ +++", [NSNumber numberWithUnsignedInteger:2], [NSNumber numberWithUnsignedInteger:SCBluePlayer], nil],
    [NSArray arrayWithObjects:@"+++ +OO +++", [NSNumber numberWithUnsignedInteger:2], [NSNumber numberWithUnsignedInteger:SCBluePlayer], nil],
    [NSArray arrayWithObjects:@"+++ +O+ +O+", [NSNumber numberWithUnsignedInteger:2], [NSNumber numberWithUnsignedInteger:SCBluePlayer], nil],
    [NSArray arrayWithObjects:@"+++ OO+ +++", [NSNumber numberWithUnsignedInteger:2], [NSNumber numberWithUnsignedInteger:SCBluePlayer], nil],
    
    // ottoman
    [NSArray arrayWithObjects:@"O+O OOO OOO", [NSNumber numberWithUnsignedInteger:2], [NSNumber numberWithUnsignedInteger:SCRedPlayer], nil],
    [NSArray arrayWithObjects:@"OOO +OO OOO", [NSNumber numberWithUnsignedInteger:2], [NSNumber numberWithUnsignedInteger:SCRedPlayer], nil],
    [NSArray arrayWithObjects:@"OOO OO+ OOO", [NSNumber numberWithUnsignedInteger:2], [NSNumber numberWithUnsignedInteger:SCRedPlayer], nil],
    [NSArray arrayWithObjects:@"OOO OOO O+O", [NSNumber numberWithUnsignedInteger:2], [NSNumber numberWithUnsignedInteger:SCRedPlayer], nil],
    
    // Four block
    [NSArray arrayWithObjects:@"++O ++O OOO", [NSNumber numberWithUnsignedInteger:2], [NSNumber numberWithUnsignedInteger:SCBluePlayer], nil],
    [NSArray arrayWithObjects:@"O++ O++ OOO", [NSNumber numberWithUnsignedInteger:2], [NSNumber numberWithUnsignedInteger:SCBluePlayer], nil],
    [NSArray arrayWithObjects:@"OOO ++O ++O", [NSNumber numberWithUnsignedInteger:2], [NSNumber numberWithUnsignedInteger:SCBluePlayer], nil],
    [NSArray arrayWithObjects:@"OOO O++ O++", [NSNumber numberWithUnsignedInteger:2], [NSNumber numberWithUnsignedInteger:SCBluePlayer], nil],
    
    // Nine block
    [NSArray arrayWithObjects:@"+++ +++ +++", [NSNumber numberWithUnsignedInteger:1], [NSNumber numberWithUnsignedInteger:SCBluePlayer], nil],
    [NSArray arrayWithObjects:@"OOO OOO OOO", [NSNumber numberWithUnsignedInteger:1], [NSNumber numberWithUnsignedInteger:SCRedPlayer], nil],
    
    // line line line
    [NSArray arrayWithObjects:@"+++ OOO +++", [NSNumber numberWithUnsignedInteger:3], [NSNumber numberWithUnsignedInteger:SCBluePlayer], nil],
    
    // checkboard pattern: all singles
    [NSArray arrayWithObjects:@"+O+ O+O +O+", [NSNumber numberWithUnsignedInteger:9], [NSNumber numberWithUnsignedInteger:SCBluePlayer], nil],
    
    // single in the corner wins
    [NSArray arrayWithObjects:@"+OO OOO OOO", [NSNumber numberWithUnsignedInteger:2], [NSNumber numberWithUnsignedInteger:SCBluePlayer], nil],
    [NSArray arrayWithObjects:@"OO+ OOO OOO", [NSNumber numberWithUnsignedInteger:2], [NSNumber numberWithUnsignedInteger:SCBluePlayer], nil],
    [NSArray arrayWithObjects:@"OOO OOO +OO", [NSNumber numberWithUnsignedInteger:2], [NSNumber numberWithUnsignedInteger:SCBluePlayer], nil],
    [NSArray arrayWithObjects:@"OOO OOO OO+", [NSNumber numberWithUnsignedInteger:2], [NSNumber numberWithUnsignedInteger:SCBluePlayer], nil],
    
    [NSArray arrayWithObjects:@"O+O +O+ O++", [NSNumber numberWithUnsignedInteger:7], [NSNumber numberWithUnsignedInteger:SCRedPlayer], nil],
    
    // pipe
    [NSArray arrayWithObjects:@"OO+ +++ OOO", [NSNumber numberWithUnsignedInteger:3], [NSNumber numberWithUnsignedInteger:SCRedPlayer], nil], // O wins with 2+3
    [NSArray arrayWithObjects:@"+OO +++ OOO", [NSNumber numberWithUnsignedInteger:3], [NSNumber numberWithUnsignedInteger:SCRedPlayer], nil], // mirror image of previous
    [NSArray arrayWithObjects:@"OOO OO+ +++", [NSNumber numberWithUnsignedInteger:2], [NSNumber numberWithUnsignedInteger:SCBluePlayer], nil], // + wins because O has a nonglyph 5-region
    
    // squat T
    [NSArray arrayWithObjects:@"O+O +++ OOO", [NSNumber numberWithUnsignedInteger:4], [NSNumber numberWithUnsignedInteger:SCRedPlayer], nil], // O wins with 1+1+3
    [NSArray arrayWithObjects:@"O+O O++ O+O", [NSNumber numberWithUnsignedInteger:4], [NSNumber numberWithUnsignedInteger:SCRedPlayer], nil],
    [NSArray arrayWithObjects:@"O+O ++O O+O", [NSNumber numberWithUnsignedInteger:4], [NSNumber numberWithUnsignedInteger:SCRedPlayer], nil],
    [NSArray arrayWithObjects:@"OOO O+O +++", [NSNumber numberWithUnsignedInteger:2], [NSNumber numberWithUnsignedInteger:SCBluePlayer], nil], // + wins since O has nonglyph 5-region
    
    // H
    [NSArray arrayWithObjects:@"O+O OOO O+O", [NSNumber numberWithUnsignedInteger:3], [NSNumber numberWithUnsignedInteger:SCRedPlayer], nil],
    [NSArray arrayWithObjects:@"OOO +O+ OOO", [NSNumber numberWithUnsignedInteger:3], [NSNumber numberWithUnsignedInteger:SCRedPlayer], nil],
     nil];
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
    
    for (NSArray * miniGridTest in testGrids) {
        SCMiniGrid * miniGrid = [[SCMiniGrid alloc] initWithTestString:[miniGridTest objectAtIndex:0]];
        STAssertEquals([[miniGrid regions] count],
                       [[miniGridTest objectAtIndex:1] unsignedIntegerValue],
                       [NSString stringWithFormat:@"%@ has incorrect number of regions",[miniGridTest objectAtIndex:0]]);
        STAssertEquals((NSUInteger) [miniGrid winner],
                       [[miniGridTest objectAtIndex:2] unsignedIntegerValue],
                       [NSString stringWithFormat:@"%@ has incorrect winner",[miniGridTest objectAtIndex:0]]);
    }
}

@end
