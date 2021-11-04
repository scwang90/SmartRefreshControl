//
//  ValueAnimator.h
//  Refresh
//
//  Created by Teeyun on 2020/9/14.
//  Copyright © 2020 Teeyun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, AnimatorInterpolator) {
    AnimatorInterpolatorLinear,
    AnimatorInterpolatorAccelerate,
    AnimatorInterpolatorDecelerate,
    AnimatorInterpolatorAccelerateDecelerate,
    AnimatorInterpolatorBounce,
};
typedef NS_ENUM(NSUInteger, AnimatorRepeatMode) {
    AnimatorRepeatModeRestart,
    AnimatorRepeatModeReverse,
};

@class ValueAnimator;
@protocol ValueAnimatorDelegate <NSObject>

@optional
- (void) onAnimationStart:(ValueAnimator*) animator;
- (void) onAnimationRepeat:(ValueAnimator*) animator;
- (void) onAnimationEnd:(ValueAnimator*) animator;

@end

typedef CGFloat(^AnimatorInterpolatorBlock)(CGFloat);

@interface ValueAnimator : NSObject

+ (ValueAnimator*)newWithFrom:(CGFloat) from to:(CGFloat) to;
+ (ValueAnimator*)newWithTarget:(id) target selector:(SEL) action;

- (void)setTarget:(id)target selector:(SEL)action;
- (void)setFrom:(CGFloat) from to:(CGFloat) to;                 //设置开始结束
- (void)setFromToPoints:(NSArray<NSNumber*>*) points;           //设置多断点

@property (nonatomic, assign) CGFloat fromValue;
@property (nonatomic, assign) CGFloat toValue;
@property (nonatomic, assign) CGFloat speed;
@property (nonatomic, assign) CGFloat repeatCount;              //INFINITY 表示无限
@property (nonatomic, assign) CFTimeInterval beginTime;
@property (nonatomic, assign) CFTimeInterval duration;          //动画持续时间（秒）
@property (nonatomic, assign) AnimatorRepeatMode repeatMode;
@property (nonatomic, assign) AnimatorInterpolator interpolator;

@property (nonatomic, weak) id<ValueAnimatorDelegate> delegate;
@property (nonatomic, copy) AnimatorInterpolatorBlock interpolatorBlock;

@property (nonatomic, readonly) BOOL isRunning;
@property (nonatomic, readonly) CGFloat value;
@property (nonatomic, readonly) CGFloat percent;

- (void) start;
- (void) stop;

@end

NS_ASSUME_NONNULL_END
