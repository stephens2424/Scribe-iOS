//
//  XY.m
//  Scribe
//
//  Created by Stephen Searles on 12/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "XY.h"

static NSMutableDictionary * allTheXYx;

@implementation XY

@synthesize x = _x;
@synthesize y = _y;

+ (NSSet *)allXYs {
    NSMutableSet * xys = [[NSMutableSet alloc] initWithCapacity:9];
    for (int x = 0; x <= 2; x++) {
        for (int y = 0; y <= 2; y++) {
            [xys addObject:[[XY alloc] initWithX:x Y:y]];
        }
    }
    return xys;
}

- (id)initWithX:(NSUInteger)x Y:(NSUInteger)y {
    NSString * key = [NSString stringWithFormat:@"%u,%u",x,y];
    XY * xy = [allTheXYx objectForKey:key];
    if (!xy) {
        self = [super init];
        if (self) {
            _x = x;
            _y = y;
        }
        [allTheXYx setObject:self forKey:key];
        return self;
    } else {
        return xy;
    }
}

- (id)initWithString:(NSString *)xyString {
    NSString * x = [xyString substringToIndex:1];
    NSString * comma = [xyString substringWithRange:NSMakeRange(1, 1)];
    NSString * y = [xyString substringFromIndex:2];
    // TODO: handle exceptions better here
    if (![comma isEqualToString:@","]) {
        return nil;
    } else {
        return [self initWithX:[x intValue] Y:[y intValue]];
    }
}

- (id)copyWithZone:(NSZone *)zone {
    return [[XY alloc] initWithX:_x Y:_y];
}

- (BOOL)isEqual:(XY *)object {
    if ([object x] == _x && [object y] == _y)
        return YES;
    else
        return NO;
}

- (BOOL)isAdjacent:(XY *)xy {
    if (abs(_x - xy.x) == 1 && _y == xy.y)
        return YES;
    else if (_x == xy.x && abs(_y - xy.y) == 1)
        return YES;
    else
        return NO;
}

- (NSSet *)neighbors {
    NSMutableSet * set = [[NSMutableSet alloc] initWithCapacity:3];
    for (int dx = -1; dx <= 1; dx++) {
        for (int dy = -1; dy <= 1; dy++) {
            if (!(dx == 0 && dy == 0) && (dx == 0 || dy == 0) && _x + dx < 3 && _y + dy < 3) {
                [set addObject:[[XY alloc] initWithX:_x + dx Y:_y + dy]];
            }
        }
    }
    return set;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%u,%u",_x,_y];
}

@end
