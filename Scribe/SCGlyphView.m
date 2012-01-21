//
//  SCGlyphView.m
//  Scribe
//
//  Created by Stephen Searles on 1/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SCGlyphView.h"
#import "SCMiniGridView.h"
#import "SCMiniGrid.h"
#import "SCCellView.h"
#import "XY.h"

@implementation SCGlyphView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |
        UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleRightMargin |
        UIViewAutoresizingFlexibleTopMargin |
        UIViewAutoresizingFlexibleHeight |
        UIViewAutoresizingFlexibleBottomMargin;
        CGFloat cellWidth = frame.size.width/3 - MINI_GRID_PADDING;
        CGFloat cellHeight = frame.size.height/3 - MINI_GRID_PADDING;
        
        for (int x = 0; x < MINI_GRID_SIZE; x++) {
            for (int y = 0; y < MINI_GRID_SIZE; y++) {
                CGRect grid = CGRectMake(x * cellWidth + (x + 1) * MINI_GRID_PADDING, y * cellHeight + (y + 1) * MINI_GRID_PADDING, cellWidth, cellHeight);
                SCCellView * cellView = [[SCCellView alloc] initWithFrame:grid];
                [self addSubview:cellView];
                cellView.positionInMiniGrid = [[XY alloc] initWithX:x Y:y];
            }
        }
    }
    return self;
}

@end
