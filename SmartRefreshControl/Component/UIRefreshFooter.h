//
//  UIRefreshFooter.h
//  Refresh
//
//  Created by SCWANG on 2021/7/1.
//  Copyright © 2021 Teeyun. All rights reserved.
//

#if __has_include(<SmartRefreshControl/UIRefreshComponent.h>)
#import <SmartRefreshControl/UIRefreshComponent.h>
#else
#import "UIRefreshComponent.h"
#endif

NS_ASSUME_NONNULL_BEGIN

/**
 * 刷新状态
 */
typedef NS_ENUM(NSUInteger, UISmartFooterStatus) {
    UISmartFooterStatusIdle,
    UISmartFooterStatusPullToLoadMore,
    UISmartFooterStatusReleaseToLoadMore,
    UISmartFooterStatusWillLoadMore,                //调用 beginLoadMore 时才会触发
    UISmartFooterStatusReleasing,
    UISmartFooterStatusLoading,
    UISmartFooterStatusFinish,
    UISmartFooterStatusNoMoreData,
};


@class UIRefreshFooter;

typedef void(^UISmartFooterBlock)(UIRefreshFooter *footer);

@interface UIRefreshFooter : UIRefreshComponent

@property (nonatomic, copy) UISmartFooterBlock loadMoreBlock;

@property (nonatomic, assign) BOOL isAutoLoadMore;
//@property (nonatomic, assign) CGFloat triggerAutoLoadMorePercent;
@property (nonatomic, readonly) BOOL isLoading;
@property (nonatomic, readonly) BOOL isNoMoreData;//判断当前是否处于没有更多数据状态
@property (nonatomic, readonly) UISmartFooterStatus status;

- (BOOL) inStatus:(UISmartFooterStatus)status, ...;//多状态判断，最后一个必须是0

//- (void) beginLoadMore;
- (void) finishLoadMore;
- (void) finishLoadMoreWithNoMoreData;//关闭加载更多，并标记为没有更多的数据，不再触发
- (void) finishLoadMoreWithSuccess:(BOOL) success;
- (void) performLoadMoreEvent;//执行绑定事件，跳过下拉刷新，直接执行刷新代码

- (void) resetNoMoreData;//重置没有更多数据，可再次触发加载更多，一般用在下拉刷新之后

- (void) onStartAnimationWhenLoading;
- (void) onStartAnimationWhenRealeasing;
- (void) onStatus:(UISmartFooterStatus) old changed:(UISmartFooterStatus) status;
- (void) onScrollingWithOffset:(CGFloat) offset percent:(CGFloat) percent drag:(BOOL) isDragging;
- (void) onLoadMoreFinished:(BOOL) success;
- (CGFloat) onLoadMoreFinishing:(BOOL) success;    //返回停留时间

@end

NS_ASSUME_NONNULL_END
