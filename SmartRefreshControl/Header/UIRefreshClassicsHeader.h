//
//  UIRefreshClassicsHeader.h
//  Teecloud
//
//  Created by Teeyun on 2020/8/17.
//  Copyright © 2020 SCWANG. All rights reserved.
//

#import "UIRefreshHeader.h"

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
