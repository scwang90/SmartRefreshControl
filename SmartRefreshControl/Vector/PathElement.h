//
//  PathElement.h
//  Refresh
//
//  Created by Teeyun on 2020/9/8.
//  Copyright © 2020 Teeyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

#import "Element.h"

NS_ASSUME_NONNULL_BEGIN

@interface PathElement : Element

+ (instancetype) newWith:(NSString*) data;

@property (nonatomic, readonly) CGPathRef pathForShape;

@end

NS_ASSUME_NONNULL_END
