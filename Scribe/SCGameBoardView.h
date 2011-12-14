//
//  SCGameBoardView.h
//  Scribe
//
//  Created by Stephen Searles on 12/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface SCGameBoardView : UIView {
    CGPathRef roundedRect;
    CGAffineTransform * _transformToSmall;
    CGColorRef _red;
    CGColorRef _blue;
    CGColorSpaceRef _colorSpace;
}

- (CGPathRef)transformedRoundedRect:(CGAffineTransform *)m;
- (CGAffineTransform *)transformToSmall;
- (CGColorRef)red;
- (CGColorRef)blue;
- (CGColorSpaceRef)colorSpace;

@end
