//
//  SCGlyphs.m
//  Scribe
//
//  Created by Stephen Searles on 1/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SCGlyphs.h"
#import "JSONKit.h"
#import "SCRegion.h"
#import "XY.h"
#import "SCScribeBoard.h"

static SCGlyphs * sharedSingleton;
static NSMutableArray * glyphs;

@implementation SCGlyphs

@synthesize allGlyphs = _allGlyphs;

+ (void)initialize
{
    static BOOL initialized = NO;
    if(!initialized)
    {
        initialized = YES;
        sharedSingleton = [[SCGlyphs alloc] init];
    }
}

- (id)init {
    if (!sharedSingleton) {
        NSURL * jsonURL = [[NSBundle mainBundle] URLForResource:@"Glyphs" withExtension:@"json"];
        NSString * json = [[NSString alloc] initWithContentsOfURL:jsonURL encoding:NSUTF8StringEncoding error:nil];
        NSArray * intermediateGlyphs = [json mutableObjectFromJSONString];
        glyphs = [[NSMutableArray alloc] initWithCapacity:20];
        for (NSMutableDictionary * glyph in intermediateGlyphs) {
            NSMutableSet * xys = [[NSMutableSet alloc] initWithCapacity:9];
            for (NSString * xyString in [glyph objectForKey:@"regionCoordinates"]) {
                [xys addObject:[[XY alloc] initWithString:xyString]];
            }
            [glyph setObject:[[SCRegion alloc] initWithSquares:xys forPlayer:SCInformationPlayer] forKey:@"region"];
            [glyphs addObject:glyph];
            [xys release];
        }
        _allGlyphs = glyphs;
        sharedSingleton = self;
    }
    return sharedSingleton;
}

- (NSArray *)allGlyphs {
    return glyphs;
}

@end
