//
//  UIRefreshHeader.h
//  Teecloud
//
//  Created by Teeyun on 2020/8/17.
//  Copyright © 2020 SCWANG. All rights reserve.d
//

#import "UIRefreshComponent.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * 刷新状态
 */
typedef NS_ENUM(NSUInteger, UIRefreshStatus) {
    UIRefreshStatusIdle,
    UIRefreshStatusPullToRefresh,
    UIRefreshStatusReleaseToRefresh,
    UIRefreshStatusWillRefresh,                //调用 beginRefresh 时才会触发
    UIRefreshStatusReleasing,
    UIRefreshStatusRefreshing,
    UIRefreshStatusFinish,
};


@class UIRefreshHeader;

typedef void(^RefreshBlock)(UIRefreshHeader *header);

@interface UIRefreshHeader : UIRefreshComponent

@property (nonatomic, copy) RefreshBlock refreshBlock;
@property (nonatomic, copy) NSString *keyForLastRefreshTime;
@property (nonatomic, copy) NSString *nameForLastRefreshTime;

@property (nonatomic, strong) NSDate *lastRefreshTime;
@property (nonatomic, strong) NSDateFormatter *lastRefreshTimeFormatter;

@property (nonatomic, readonly) BOOL isRefreshing;
@property (nonatomic, readonly) UIRefreshStatus status;
@property (nonatomic, readonly) NSString *textLastRefreshTime;

- (BOOL) inStatus:(UIRefreshStatus)status, ...;//多状态判断，最后一个必须是0

- (void) beginRefresh;
- (void) finishRefresh;
- (void) finishRefreshWithSuccess:(BOOL) success;
- (void) performRefreshEvent;//执行绑定事件，跳过下拉刷新，直接执行刷新代码

- (void) onStartAnimationWhenRealeasing;
- (void) onStartAnimationWhenRefreshing;
- (void) onStatus:(UIRefreshStatus) old changed:(UIRefreshStatus) status;
- (void) onScrollingWithOffset:(CGFloat) offset percent:(CGFloat) percent drag:(BOOL) isDragging;
- (void) onRefreshFinished:(BOOL) success;
- (CGFloat) onRefreshFinishing:(BOOL) success;    //返回停留时间

@end

NS_ASSUME_NONNULL_END
