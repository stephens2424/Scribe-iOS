//
//  SCGridView.m
//  Scribe
//
//  Created by Stephen Searles on 12/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SCGridView.h"

@implementation SCGridView

void gridForFrame(CGRect grid[], CGRect frame, NSUInteger padding,NSUInteger gridSize) {
    
    CGFloat cellWidth = frame.size.width/3 - padding;
    CGFloat cellHeight = frame.size.height/3 - padding;
    
    int i = 0;
    for (int x = 0; x < gridSize; x++) {
        for (int y = 0; y < gridSize; y++) {
            grid[i] = CGRectMake(x * cellWidth + (x + 1) * padding, y * cellHeight + (y + 1) * padding, cellWidth, cellHeight);;
            i++;
        }
    }
}

@end
