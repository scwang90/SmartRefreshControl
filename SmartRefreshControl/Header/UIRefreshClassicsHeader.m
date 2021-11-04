//
//  UIRefreshClassicsHeader.m
//  Teecloud
//
//  Created by Teeyun on 2020/8/17.
//  Copyright © 2020 SCWANG. All rights reserved.
//

#import "UIRefreshClassicsHeader.h"

//#import "UIVectorView.h"

@interface UIRefreshClassicsHeader ()

@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UILabel *labelLastTime;
@property (nonatomic, strong) UIImageView *viewArrow;
@property (nonatomic, strong) UIActivityIndicatorView *viewLoading;

@end

@implementation UIRefreshClassicsHeader

#pragma mark - Init

/**
 * 初始化参数
 */
- (void)setUpComponent {
    [super setUpComponent];

    [self setHeight:85];
    [self setSpaceOfTitleAndTime:5];
    [self setSpaceOfLoadingAndText:10];
    [self setScrollMode:UISmartScrollModeMove];
    
    [self addSubview:self.labelTitle];
    [self addSubview:self.labelLastTime];
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

        if (!self.labelLastTime.isHidden) {
            CGFloat space = self.spaceOfTitleAndTime;
            CGSize sizeTime = [self.labelLastTime sizeThatFits:self.bounds.size];
            CGRect rectTime = CGRectMake(0, 0, sizeTime.width, sizeTime.height);
            
            rectTime.origin.x = (sizeHeader.width - sizeTime.width) / 2;
            rectTime.origin.y = sizeHeader.height / 2 + space / 2;
            self.labelLastTime.frame = rectTime;
            
            rectTitle.origin.y = sizeHeader.height / 2 - space / 2 - sizeTitle.height;
            
            textWidth = MAX(sizeTitle.width, sizeTime.width);
        } else {
            rectTitle.origin.y = (sizeHeader.height - sizeTitle.height) / 2;
        }
        
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
    self.labelLastTime.textColor = colorAccent;
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

- (UILabel *)labelLastTime {
    if (_labelLastTime == nil) {
        _labelLastTime = [UILabel new];
        _labelLastTime.font = [UIFont systemFontOfSize:12];
    }
    return _labelLastTime;
}

- (UIImageView *)viewArrow {
    if (_viewArrow == nil) {
        _viewArrow = [UIImageView new];
        
        CGFloat width = 18,height = 18;
        CGFloat lineWidth = width * 25 / 225;
        CGFloat vector1 = (lineWidth * 0.70710678118654752440084436210485f);//Math.sin(Math.PI/4));
        CGFloat vector2 = (lineWidth / 0.70710678118654752440084436210485f);//Math.sin(Math.PI/4));
                
//        NSMutableString *path = [NSMutableString string];
//        [path appendFormat:@"M%@,%@", @(width/2), @(height)];
//        [path appendFormat:@"L%@,%@", @(0), @(height / 2)];
//        [path appendFormat:@"L%@,%@", @(vector1), @(height / 2 - vector1)];
//        [path appendFormat:@"L%@,%@", @(width / 2 - lineWidth / 2), @(height - vector2 - lineWidth / 2)];
//        [path appendFormat:@"L%@,%@", @(width / 2 - lineWidth / 2), @(0)];
//        [path appendFormat:@"L%@,%@", @(width / 2 + lineWidth / 2), @(0)];
//        [path appendFormat:@"L%@,%@", @(width / 2 + lineWidth / 2), @(height - vector2 - lineWidth / 2)];
//        [path appendFormat:@"L%@,%@", @(width - vector1), @(height / 2 - vector1)];
//        [path appendFormat:@"L%@,%@", @(width), @(height / 2)];
//        [path appendString:@"Z"];

//        UIVectorView *view = [UIVectorView new];
//        [view parserPaths:@[path.copy]];
//        [view setFrame:CGRectMake(0, 0, width, height)];
        
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

- (void)didMoveToWindow {
    [super didMoveToWindow];
    self.labelLastTime.text = self.textLastRefreshTime;
}

//- (void)scrollView:(UIScrollView *)scrollView didChange:(UIRefreshStatus)old status:(UIRefreshStatus)status {
- (void)onStatus:(UIRefreshStatus)old changed:(UIRefreshStatus)status {
//    [super scrollView:scrollView didChange:old status:status];
    [super onStatus:old changed:status];

    switch (status) {
    case UIRefreshStatusWillRefresh:
    case UIRefreshStatusRefreshing:
        self.labelTitle.text = @"正在刷新...";
        [self setNeedsLayout];
        break;
    case UIRefreshStatusReleaseToRefresh:
        self.labelTitle.text = @"释放立即刷新";
        [self setNeedsLayout];
        break;
    default:
        self.labelTitle.text = @"下拉开始刷新";
        self.labelLastTime.text = self.textLastRefreshTime;
        [self setNeedsLayout];
        break;
    }
    
    if (status == UIRefreshStatusReleaseToRefresh) {
        [UIView animateWithDuration:self.durationNormal animations:^{
            self.viewArrow.transform = CGAffineTransformMakeRotation(M_PI);
        }];
    } else if (old == UIRefreshStatusReleaseToRefresh) {
        [UIView animateWithDuration:self.durationNormal animations:^{
            self.viewArrow.transform = CGAffineTransformIdentity;
        }];
    }
    
    if (status == UIRefreshStatusRefreshing) {
        self.viewArrow.hidden = true;
        [self.viewLoading startAnimating];
    } else if (old == UIRefreshStatusRefreshing) {
        self.viewArrow.hidden = false;
        [self.viewLoading stopAnimating];
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
