//
//  SCMiniGridView.h
//  Scribe
//
//  Created by Stephen Searles on 12/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCGridView.h"
@class SCMiniGrid;
@class XY;

@interface SCMiniGridView : SCGridView {
    CGRect originalFrame;
    CGRect expandedFrame;
    UITapGestureRecognizer * gestureRecognizer;
    SCMiniGrid * _miniGrid;
}

@property (nonatomic,assign) CGRect expandedFrame;

- (void)reduceFrame;
- (void)makeMiniGrid:(XY *)xy;

@end
