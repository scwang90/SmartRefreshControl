//
//  Utilities.h
//  Refresh
//
//  Created by Teeyun on 2020/9/8.
//  Copyright © 2020 Teeyun. All rights reserved.
//
#import "Element.h"

NS_ASSUME_NONNULL_BEGIN

@interface Utilities : NSObject

+ (CALayer *) newLayerForElement:(Element*) element withPath:(CGPathRef) path;

@end

NS_ASSUME_NONNULL_END
