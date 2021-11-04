//
//  MountainView.h
//  Refresh
//
//  Created by SCWANG on 2021/6/13.
//  Copyright © 2021 Teeyun. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

#define RATIO_Y(rect) (CGRectGetMaxY(rect) / 120.f)
#define RATIO_X(rect) (CGRectGetMaxX(rect) / 240.f)

NS_ASSUME_NONNULL_BEGIN

@interface MountainView : UIView

@property (nonatomic, strong) UIColor *colorAccent;
@property (nonatomic, strong) UIColor *colorPrimary;

- (void)onScrollingWithOffset:(CGFloat)offset percent:(CGFloat)percent;

@end

NS_ASSUME_NONNULL_END
