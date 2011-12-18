//
//  SCMiniGridView.h
//  Scribe
//
//  Created by Stephen Searles on 12/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SCMiniGrid;
@class SCScribeBoard;
@class XY;

@interface SCMiniGridView : UIView {
    CGRect originalFrame;
    CGRect expandedFrame;
    UITapGestureRecognizer * gestureRecognizer;
    SCMiniGrid * _miniGrid;
}

@property (nonatomic,assign) CGRect expandedFrame;

- (id)initWithFrame:(CGRect)frame miniGrid:(SCMiniGrid *)miniGrid;
- (void)reduceFrame;

@end
