//
//  Element.h
//  Refresh
//
//  Created by Teeyun on 2020/9/8.
//  Copyright © 2020 Teeyun. All rights reserved.
//

//#import <Foundation/Foundation.h>
//#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Element : NSObject

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, strong) UIColor *stroke;
@property (nonatomic, strong) UIColor *fill;
@property (nonatomic, assign) CGFloat opacity;
@property (nonatomic, assign) CGFloat strokeWidth;
@property (nonatomic, assign) CGFloat strokeOpacity;
@property (nonatomic, assign) CGRect viewport;

@property (nonatomic, assign) BOOL changed;
@property (nonatomic, strong) CALayer *layer;

- (CALayer *)newLayer;

@end

NS_ASSUME_NONNULL_END
