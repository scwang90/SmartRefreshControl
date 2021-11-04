//
//  UIRefreshClassicsFooter.m
//  Refresh
//
//  Created by SCWANG on 2021/7/5.
//  Copyright © 2021 Teeyun. All rights reserved.
//

#import "UIRefreshClassicsFooter.h"

@interface UIRefreshClassicsFooter ()

@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UIImageView *viewArrow;
@property (nonatomic, strong) UIActivityIndicatorView *viewLoading;

@end

@implementation UIRefreshClassicsFooter

- (void)setUpComponent {
    [super setUpComponent];
    [self setIsAutoLoadMore:TRUE];
    
    [self setHeight:50];
    [self setSpaceOfLoadingAndText:10];
    [self setScrollMode:UISmartScrollModeMove];
    
    [self addSubview:self.labelTitle];
    [self addSubview:self.viewArrow];
    [self addSubview:self.viewLoading];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGSize sizeHeader = self.frame.size;
    CGFloat centerArrowX = sizeHeader.width / 2;
    CGFloat centerArrowY = sizeHeader.height / 2;
    
    if (!self.labelTitle.isHidden) {
        CGSize sizeTitle = [self.labelTitle sizeThatFits:self.bounds.size];
        CGRect rectTitle = CGRectMake(0, 0, sizeTitle.width, sizeTitle.height);
        CGFloat textWidth = sizeTitle.width;
        
        rectTitle.origin.x = (sizeHeader.width - sizeTitle.width) / 2;

        rectTitle.origin.y = (sizeHeader.height - sizeTitle.height) / 2;
        
        centerArrowX -= textWidth / 2 + self.spaceOfLoadingAndText;
        
        self.labelTitle.frame = rectTitle;
    }
    
    CGSize sizeLoading = self.viewLoading.frame.size;
    CGSize sizeArrow = self.viewArrow.image ? self.viewArrow.image.size : CGSizeZero;
    CGPoint originArrow = CGPointMake(centerArrowX - sizeArrow.width / 2, centerArrowY - sizeArrow.height / 2);
    self.viewArrow.frame = CGRectMake(originArrow.x, originArrow.y, sizeArrow.width, sizeArrow.height);
    self.viewArrow.center = CGPointMake(centerArrowX - sizeArrow.width / 2, centerArrowY);
    self.viewLoading.center = CGPointMake(centerArrowX - sizeLoading.width / 2, centerArrowY);
}

- (void)setColorAccent:(UIColor *)colorAccent {
    [super setColorAccent:colorAccent];
    self.labelTitle.textColor = colorAccent;
    self.viewLoading.color = colorAccent;
    self.viewArrow.tintColor = colorAccent;
}

- (void)setColorPrimary:(UIColor *)colorPrimary {
    [super setColorPrimary:colorPrimary];
    self.backgroundColor = colorPrimary;
}

#pragma mark - Lazy

- (UILabel *)labelTitle {
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.font = [UIFont systemFontOfSize:15];
    }
    return _labelTitle;
}

- (UIImageView *)viewArrow {
    if (_viewArrow == nil) {
        _viewArrow = [UIImageView new];
        
        CGFloat width = 18,height = 18;
        CGFloat lineWidth = width * 25 / 225;
        CGFloat vector1 = (lineWidth * 0.70710678118654752440084436210485f);//Math.sin(Math.PI/4));
        CGFloat vector2 = (lineWidth / 0.70710678118654752440084436210485f);//Math.sin(Math.PI/4));
                
        CGFloat scale =  [UIScreen mainScreen].scale;
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextMoveToPoint(context, width/2, height);
        CGContextAddLineToPoint(context, 0, height / 2);
        CGContextAddLineToPoint(context, vector1, height / 2 - vector1);
        CGContextAddLineToPoint(context, width / 2 - lineWidth / 2, height - vector2 - lineWidth / 2);
        CGContextAddLineToPoint(context, width / 2 - lineWidth / 2, 0);
        CGContextAddLineToPoint(context, width / 2 + lineWidth / 2, 0);
        CGContextAddLineToPoint(context, width / 2 + lineWidth / 2, height - vector2 - lineWidth / 2);
        CGContextAddLineToPoint(context, width - vector1, height / 2 - vector1);
        CGContextAddLineToPoint(context, width, height / 2);
        CGContextClosePath(context);
        
        CGContextFillPath(context);
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        _viewArrow.image = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    return _viewArrow;
}

- (UIActivityIndicatorView *)viewLoading {
    if (_viewLoading == nil) {
        NSInteger style = 2;//UIActivityIndicatorViewStyleGray;
        _viewLoading = [UIActivityIndicatorView alloc];
        _viewLoading = [_viewLoading initWithActivityIndicatorStyle:style];
        _viewLoading.hidesWhenStopped = TRUE;
    }
    return _viewLoading;
}

#pragma mark - Override


- (void)onStatus:(UISmartFooterStatus)old changed:(UISmartFooterStatus)status {
    [super onStatus:old changed:status];
    
    [self setNeedsLayout];
    
    switch (status) {
    case UISmartFooterStatusWillLoadMore:
    case UISmartFooterStatusLoading:
        self.labelTitle.text = @"正在加载...";
        break;
    case UISmartFooterStatusReleaseToLoadMore:
        self.labelTitle.text = @"释放立即加载";
        break;
    case UISmartFooterStatusNoMoreData:
        self.labelTitle.text = @"没有更多数据了";
        break;
    default:
        if (self.isAutoLoadMore) {
            self.labelTitle.text = @"点击加载更多";
        } else {
            self.labelTitle.text = @"下拉开始加载";
        }
        break;
    }
    
    if (status == UISmartFooterStatusReleaseToLoadMore) {
        [UIView animateWithDuration:self.durationNormal animations:^{
            self.viewArrow.transform = CGAffineTransformMakeRotation(M_PI);
        }];
    } else if (old == UISmartFooterStatusReleaseToLoadMore) {
        [UIView animateWithDuration:self.durationNormal animations:^{
            self.viewArrow.transform = CGAffineTransformIdentity;
        }];
    }
    
    if (status == UISmartFooterStatusLoading) {
        self.viewArrow.hidden = true;
        [self.viewLoading startAnimating];
    } else if (old == UISmartFooterStatusLoading) {
        self.viewArrow.hidden = false;
        [self.viewLoading stopAnimating];
    }
    
    if (self.isAutoLoadMore) {
        self.viewArrow.hidden = true;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
