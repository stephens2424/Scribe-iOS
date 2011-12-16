//
//  XY.m
//  Scribe
//
//  Created by Stephen Searles on 12/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "XY.h"

@implementation XY

@synthesize x = _x;
@synthesize y = _y;

- (id)initWithX:(NSUInteger)x Y:(NSUInteger)y {
    self = [super init];
    if (self) {
        _x = x;
        _y = y;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%u,%u",_x,_y];
}

@end
