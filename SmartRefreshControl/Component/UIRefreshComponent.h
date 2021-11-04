//
//  UIRefreshComponent.h
//  Teecloud
//
//  Created by Teeyun on 2020/8/17.
//  Copyright © 2020 SCWANG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * 滚动模式
 */
typedef NS_ENUM(NSInteger, UISmartScrollMode) {
    UISmartScrollModeMove,                //移动
    UISmartScrollModeStretch,             //拉伸
    UISmartScrollModeFront,               //前置
};

///**
// * 刷新状态
// */
//typedef NS_ENUM(NSUInteger, UIRefreshStatus) {
//    UIRefreshStatusIdle,
//    UIRefreshStatusPullToRefresh,
//    UIRefreshStatusReleaseToRefresh,
//    UIRefreshStatusWillRefresh,                //调用 beginRefresh 时才会触发
//    UIRefreshStatusReleasing,
//    UIRefreshStatusRefreshing,
//    UIRefreshStatusFinish,
//};

@interface UIRefreshComponent : UIControl

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;         //高度，拉伸类型时刻变化，请使用 expandHeight
@property (nonatomic, assign) CGFloat triggerRate;    //触发刷新距离 与 展开具体 的比率（默认1）
@property (nonatomic, assign) CGFloat finishDuration; //刷新完成时，停留时间（秒）

@property (nonatomic, assign) NSTimeInterval durationFast;
@property (nonatomic, assign) NSTimeInterval durationNormal;
@property (nonatomic, assign) UISmartScrollMode scrollMode;

@property (nonatomic, strong) UIColor *colorAccent;
@property (nonatomic, strong) UIColor *colorPrimary;

@property (nonatomic, readonly) BOOL isAttached;
@property (nonatomic, readonly) BOOL isExpanded;
//@property (nonatomic, readonly) BOOL isRefreshing;
@property (nonatomic, readonly) CGFloat dragOffset;
@property (nonatomic, readonly) CGFloat dragPercent;
@property (nonatomic, readonly) CGFloat expandHeight;   //展开的高度，是一个设置的固定值
//@property (nonatomic, readonly) BOOL isIgnoreObserve;
//@property (nonatomic, readonly) UIRefreshStatus status;
//@property (nonatomic, readonly) UIEdgeInsets originalInset;

@property (nonatomic, readonly, weak) id target;
@property (nonatomic, readonly, weak) UIScrollView *scrollView;

- (void) setUpComponent NS_REQUIRES_SUPER;
- (void) addObservers:(UIScrollView*) scrollView NS_REQUIRES_SUPER;
- (void) removeObservers:(UIScrollView*) scrollView NS_REQUIRES_SUPER;
//- (void) adjustInset:(UIScrollView*) scrollView expand:(BOOL) expand;

- (void) scrollView:(UIScrollView*) scrollView attached:(BOOL) attach NS_REQUIRES_SUPER;
- (void) scrollView:(UIScrollView*) scrollView detached:(BOOL) detach NS_REQUIRES_SUPER;
- (void) scrollView:(UIScrollView*) scrollView didChange:(CGPoint) old contentOffset:(CGPoint) value NS_REQUIRES_SUPER;
- (void) scrollView:(UIScrollView *)scrollView didChange:(UIEdgeInsets) old contentInset:(UIEdgeInsets)value NS_REQUIRES_SUPER;
//- (void) scrollView:(UIScrollView*) scrollView didChange:(UIRefreshStatus) old status:(UIRefreshStatus) status;
- (void) scrollView:(UIScrollView*) scrollView didScroll:(CGFloat) offset percent:(CGFloat) percent drag:(BOOL) isDragging;

- (void) adjustFrameWithHeight:(CGFloat)expandHeight inset:(CGFloat)insetTop expand:(BOOL)isExpanded offset:(CGFloat)offset;

- (CGFloat) finalyContentInsetsFrom:(UIScrollView*) scrollView;

//API-method
- (void) attach:(UIScrollView*) scrollView;
//- (void) performRefreshEvent;//执行绑定事件，跳过下拉刷新，直接执行刷新代码
- (void) addTarget:(id) target action:(SEL) action;//添加刷新事件监听
//- (BOOL) inStatus:(UIRefreshStatus)status, ...;//多状态判断，最后一个必须是0

//API-static
+ (instancetype) attach:(UIScrollView*) scrollView;
+ (instancetype) attach:(UIScrollView*) scrollView target:(id) target action:(SEL) action;

@end

NS_ASSUME_NONNULL_END
