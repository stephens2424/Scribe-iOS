//
//  SCCellView.h
//  Scribe
//
//  Created by Stephen Searles on 12/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCCellView : UIView {
    CGAffineTransform * _transformToSmall;
    CGColorRef _red;
    CGColorRef _blue;
    CGColorRef color;
    CGColorSpaceRef _colorSpace;
}

@property (assign) CGColorRef color;

- (CGAffineTransform *)transformToSmall;
- (CGColorRef)red;
- (CGColorRef)blue;
- (CGColorSpaceRef)colorSpace;

@end
