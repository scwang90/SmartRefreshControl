//
//  Utilities.h
//  Refresh
//
//  Created by Teeyun on 2020/9/8.
//  Copyright © 2020 Teeyun. All rights reserved.
//

#if __has_include(<SmartRefreshControl/Element.h>)
#import <SmartRefreshControl/Element.h>
#else
#import "Element.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface Utilities : NSObject

+ (CALayer *) newLayerForElement:(Element*) element withPath:(CGPathRef) path;

@end

NS_ASSUME_NONNULL_END
