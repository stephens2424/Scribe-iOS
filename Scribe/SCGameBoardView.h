//
//  SCGameBoardView.h
//  Scribe
//
//  Created by Stephen Searles on 12/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class SCScribeBoard;

@interface SCGameBoardView : UIView {
    SCScribeBoard * scribeBoard;
}

- (id)initWithFrame:(CGRect)frame gameBoard:(SCScribeBoard *)board;

@end
