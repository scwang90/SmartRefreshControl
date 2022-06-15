//
//  UIRefreshClassicsHeader.h
//  Teecloud
//
//  Created by Teeyun on 2020/8/17.
//  Copyright © 2020 SCWANG. All rights reserved.
//

#if __has_include(<SmartRefreshControl/UIRefreshHeader.h>)
#import <SmartRefreshControl/UIRefreshHeader.h>
#else
#import "UIRefreshHeader.h"
#endif


NS_ASSUME_NONNULL_BEGIN

@interface UIRefreshClassicsHeader : UIRefreshHeader

@property (nonatomic, assign) CGFloat spaceOfTitleAndTime;
@property (nonatomic, assign) CGFloat spaceOfLoadingAndText;

@property (nonatomic, readonly) UILabel *labelTitle;
@property (nonatomic, readonly) UILabel *labelLastTime;
@property (nonatomic, readonly) UIImageView *viewArrow;
@property (nonatomic, readonly) UIActivityIndicatorView *viewLoading;

@end

NS_ASSUME_NONNULL_END
