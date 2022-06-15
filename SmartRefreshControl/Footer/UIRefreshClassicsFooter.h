//
//  UIRefreshClassicsFooter.h
//  Refresh
//
//  Created by SCWANG on 2021/7/5.
//  Copyright © 2021 Teeyun. All rights reserved.
//

#if __has_include(<SmartRefreshControl/UIRefreshFooter.h>)
#import <SmartRefreshControl/UIRefreshFooter.h>
#else
#import "UIRefreshFooter.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface UIRefreshClassicsFooter : UIRefreshFooter

@property (nonatomic, assign) CGFloat spaceOfLoadingAndText;

@property (nonatomic, readonly) UILabel *labelTitle;
@property (nonatomic, readonly) UIImageView *viewArrow;
@property (nonatomic, readonly) UIActivityIndicatorView *viewLoading;

@end

NS_ASSUME_NONNULL_END
