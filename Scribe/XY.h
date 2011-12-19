//
//  XY.h
//  Scribe
//
//  Created by Stephen Searles on 12/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XY : NSObject {
    NSUInteger _x;
    NSUInteger _y;
}

@property (readonly) NSUInteger x;
@property (readonly) NSUInteger y;

+ (NSSet *)allXYs;

- (id)initWithX:(NSUInteger)x Y:(NSUInteger)y;
- (BOOL)isAdjacent:(XY *)xy;
- (NSSet *)neighbors;

@end
