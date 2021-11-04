//
//  UIRefreshFlyHeader.m
//  Refresh
//
//  Created by SCWANG on 2021/6/13.
//  Copyright © 2021 Teeyun. All rights reserved.
//

#import "UIRefreshFlyHeader.h"

#import "FlyView.h"
#import "MountainView.h"

#define FLOAT_VIEW_SIZE 50
#define RGB(rgb)[UIColor colorWithRed:((float)((rgb&0xFF0000)>> 16))/ 255.0 green:((float)((rgb&0x00FF00)>> 8))/ 255.0 blue: ((float)(rgb&0x0000FF))/ 255.0 alpha:1]

@interface UIRefreshHeader (UIRefreshFlyHeader)<UIScrollViewDelegate>

@property (nonatomic, weak) id<UIScrollViewDelegate> originDelegate;

- (void)adjustInset:(UIScrollView*) scrollView expand:(BOOL) expand;
- (void)resetScrollContentOffset:(UIScrollView*) scrollView start:(CGFloat) start;
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;

@end

@interface UIRefreshFlyHeader ()<CAAnimationDelegate>

@property (nonatomic, assign) BOOL attached;
@property (nonatomic, strong) UIView *floatView;
@property (nonatomic, strong) FlyView *flyView;
@property (nonatomic, strong) MountainView *mountainView;

@end

@implementation UIRefreshFlyHeader

- (void)setUpComponent {
    [self setHeight:150];
    [self setMountain:[MountainView new]];
    [self setFloatView:[UIView new]];
    [self setFlyView:[FlyView new]];
    [self setScrollMode:UISmartScrollModeStretch];
    [super setUpComponent];
    
    [self setTriggerRate:0.5];
    [self setColorPrimary:RGB(0x33aaff)];
    [self setColorAccent:UIColor.whiteColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.mountainView setFrame:self.bounds];
    [self.floatView setCenter:CGPointMake(FLOAT_VIEW_SIZE*3/4, self.frame.size.height)];
    if (!self.isRefreshing) {
        [self.flyView setCenter:CGPointMake(FLOAT_VIEW_SIZE*3/4, self.frame.size.height)];
    }
}

- (void)setFlyView:(FlyView *)flyView {
    _flyView = flyView;
    [self addSubview:flyView];
}

- (void)setFloatView:(UIView *)floatView {
    _floatView = floatView;
    [floatView setFrame:CGRectMake(0, 0, FLOAT_VIEW_SIZE, FLOAT_VIEW_SIZE)];
    [floatView.layer setCornerRadius:FLOAT_VIEW_SIZE/2];
    [self addSubview:floatView];
}

- (void)setMountain:(MountainView *)mountainView {
    _mountainView = mountainView;
    [self addSubview:mountainView];
}

/**
 * 颜色绑定
 */
- (void)setColorPrimary:(UIColor *)colorPrimary {
    [super setColorPrimary:colorPrimary];
    [self.floatView setBackgroundColor:colorPrimary];
    [self.mountainView setColorPrimary:colorPrimary];
}

/**
 * 颜色绑定
 */
- (void)setColorAccent:(UIColor *)colorAccent {
    [super setColorAccent:colorAccent];
    [self.flyView setColorAccent:colorAccent];
}

/**
 * 打开常态展开
 */
- (void)scrollView:(UIScrollView *)scrollView attached:(BOOL)attach {
    [super scrollView:scrollView attached:attach];
    [self adjustInset:scrollView expand:TRUE];
    [self setAttached:TRUE];
}

/**
 * 关闭常态展开
 */
- (void)scrollView:(UIScrollView *)scrollView detached:(BOOL)detach {
    [self setAttached:FALSE];
    [super scrollView:scrollView detached:detach];
    [self adjustInset:scrollView expand:FALSE];
}

/**
 * 重写 dragOffset
 * 父类通过比较 dragOffset 和 lastDragOffset 不一致
 * 来触发 onScrollingWithOffset，和布局操作
 * 但是 因为本 Header 默认展开了，offset 也被重写为 0
 * 导致 dragOffset 和 lastDragOffset 都为0，
 * 无法布局 setFrame 导致 height = 0
 * 所以在 height = 0 的时候强行返回 -1，可以触发 布局操作
 */
- (CGFloat)dragOffset {
    if (self.height > 0) {
        return super.dragOffset;
    } else {
        return -1;
    }
}

/**
 * 下拉时候，根据偏移量改变 背景高度，和纸飞机角度
 */
- (void)onScrollingWithOffset:(CGFloat)offset percent:(CGFloat)percent drag:(BOOL)isDragging {
    [self.mountainView onScrollingWithOffset:offset percent:percent];
    if (!self.isRefreshing) {
        percent = offset / self.expandHeight;
        [self.flyView setTransform:CGAffineTransformMakeRotation(-percent*3.1415926/4)];
    }
}

/**
 * 本刷新常态展开，但是展开关闭的逻辑封装在父类，通过调用 adjustInset 实现
 * 重写 adjustInset 实现根据情况忽略父类的展开关闭操作
 */
- (void)adjustInset:(UIScrollView *)scrollView expand:(BOOL)expand {
    if (!self.attached) {
        [super adjustInset:scrollView expand:expand];
    } else {
        if (self.dragOffset != 0) {
            self.originDelegate = scrollView.delegate;
            scrollView.delegate = self;
        } else {
            [super scrollViewDidEndScrollingAnimation:scrollView];
        }
    }
}

/**
 * 重写 resetScrollContentOffset 并不任何操作
 * 因为 第一次展开之后，再也没有展开和关闭操作，
 * offset 重置UITableView自己会完成
 */
- (void)resetScrollContentOffset:(UIScrollView *)scrollView start:(CGFloat)start {
}

/**
 * 本刷新常态展开，之后没有再展开和关闭的操作，
 * 没有 setContentOffset 操作，就不会触发 scrollViewDidEndScrollingAnimation
 * 松手时需要 scrollViewDidEndDecelerating 转发 scrollViewDidEndScrollingAnimation
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [super scrollViewDidEndScrollingAnimation: scrollView];
}

/**
 * 重写获取 insetTop
 * 因为本刷新展开为常态，所以 offset 和 percent 都不为 0
 * 重写 insetTop 可以让 offset percent 归零
 */
- (CGFloat)finalyContentInsetsFrom:(UIScrollView*) scrollView {
    return [super finalyContentInsetsFrom:scrollView] + self.expandHeight;
}

/**
 * 重写Frame计算
 * 因为 finalyContentInsetsFrom 的重写让实际展开的 Header 在计算时变成未展开的状态
 * 但是实际布局又需要布局成展开的状态，所以 insetTop-expandHeight
 */
- (void)adjustFrameWithHeight:(CGFloat)expandHeight inset:(CGFloat)inset expand:(BOOL)isExpanded offset:(CGFloat)offset {
    [super adjustFrameWithHeight:expandHeight inset:inset-expandHeight expand:isExpanded offset:offset];
}

/**
 * 用户松手，执行飞机飞出动画
 */
- (void)onStartAnimationWhenRealeasing {
    
    self.flyView.transform = CGAffineTransformIdentity;
    
    CGPoint end = CGPointMake(self.width + FLOAT_VIEW_SIZE / 2, FLOAT_VIEW_SIZE / 4);
    UIBezierPath* path = UIBezierPath.bezierPath;
    [path moveToPoint: CGPointMake(FLOAT_VIEW_SIZE*3/4, self.expandHeight + self.dragOffset)];
    [path addQuadCurveToPoint:end controlPoint:CGPointMake(0, 0)];
    
    CAKeyframeAnimation *aniFly = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    aniFly.path = path.CGPath;
    aniFly.calculationMode = kCAAnimationPaced;
    aniFly.rotationMode = kCAAnimationRotateAuto;
    
    CABasicAnimation *aniScale = [CABasicAnimation animationWithKeyPath:@"transform"];
    aniScale.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    aniScale.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.2, 1)];
    
    CAAnimationGroup *aniGroup = [[CAAnimationGroup alloc] init];
    aniGroup.animations = @[aniScale, aniFly];
    aniGroup.duration = 1.5f;
    aniGroup.fillMode = kCAFillModeForwards;
    aniGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [self.flyView.layer addAnimation:aniGroup forKey:@"fly"];
    [self.flyView setCenter:end];
}

/**
 * 用户关闭刷新，执行飞机飞回动画
 */
- (void)finishRefreshWithSuccess:(BOOL)success {
    [super finishRefreshWithSuccess:success];
    
    CGSize size = self.frame.size;
    
    CGPoint p1 = CGPointMake(-FLOAT_VIEW_SIZE, size.height - FLOAT_VIEW_SIZE);
    CGPoint p2 = CGPointMake(-FLOAT_VIEW_SIZE, size.height);
    CGPoint end = CGPointMake(FLOAT_VIEW_SIZE*3/4, self.frame.size.height);
    UIBezierPath* path = UIBezierPath.bezierPath;
    [path moveToPoint: self.flyView.center];
    [path addQuadCurveToPoint:p1 controlPoint:CGPointMake(size.width, size.height - FLOAT_VIEW_SIZE)];
    [path addQuadCurveToPoint:end controlPoint: p2];
    
    CAKeyframeAnimation *aniFly = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    aniFly.path = path.CGPath;
    aniFly.calculationMode = kCAAnimationPaced;
    aniFly.rotationMode = kCAAnimationRotateAuto;
    
    CABasicAnimation *aniScale = [CABasicAnimation animationWithKeyPath:@"transform"];
    aniScale.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.2, 1)];
    aniScale.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    CAAnimationGroup *aniGroup = [[CAAnimationGroup alloc] init];
    aniGroup.animations = @[aniScale, aniFly];
    aniGroup.duration = 1.5f;
    aniGroup.delegate = self;
    aniGroup.fillMode = kCAFillModeForwards;
    aniGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [self.flyView.layer addAnimation:aniGroup forKey:@"back"];
}

/**
 * 关闭刷新，纸飞机飞回动画结束，需要通知父类处理
 */
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        [self.flyView setCenter:CGPointMake(FLOAT_VIEW_SIZE*3/4, self.expandHeight)];
        [super scrollViewDidEndScrollingAnimation: self.scrollView];
    }
}


//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    if (!self.attached) {
//        [self adjustInset:self.scrollView expand:TRUE];
//        [self setAttached:TRUE];
//    }
//}


@end
