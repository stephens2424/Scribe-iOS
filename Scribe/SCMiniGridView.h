//
//  SCMiniGridView.h
//  Scribe
//
//  Created by Stephen Searles on 12/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCMiniGrid.h"
#import "SCGridView.h"

@interface SCMiniGridView : SCGridView {
    SCMiniGrid * miniGrid;
    CGRect originalFrame;
    CGRect expandedFrame;
    UITapGestureRecognizer * gestureRecognizer;
}

@property (nonatomic,assign) CGRect expandedFrame;

- (void)reduceFrame;

@end
