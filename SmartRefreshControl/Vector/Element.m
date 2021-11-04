//
//  Element.m
//  Refresh
//
//  Created by Teeyun on 2020/9/8.
//  Copyright © 2020 Teeyun. All rights reserved.
//

#import "Element.h"

@implementation Element
@synthesize layer = _layer;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.strokeWidth = 0;
        self.fill = [UIColor whiteColor];
        self.opacity = 1;
    }
    return self;
}

- (void)setLayer:(CALayer *)layer {
    _layer = layer;
    _changed = FALSE;
}

- (void)setStroke:(UIColor *)stroke {
    _stroke = stroke;
    _changed = TRUE;
}

- (void)setFill:(UIColor *)fill {
    _fill = fill;
    _changed = TRUE;
}

- (void)setOpacity:(CGFloat)opacity {
    _opacity = opacity;
    _changed = TRUE;
}

- (void)setStrokeWidth:(CGFloat)strokeWidth {
    _strokeWidth = strokeWidth;
    _changed = TRUE;
}

- (CALayer *)layer {
    if (_changed) {
        return _layer = [self newLayer];
    }
    return _layer;
}

- (CALayer *)newLayer {
    return nil;
}

@end
