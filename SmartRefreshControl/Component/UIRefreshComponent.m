//
//  UIRefreshComponent.m
//  Teecloud
//
//  Created by Teeyun on 2020/8/17.
//  Copyright © 2020 SCWANG. All rights reserved.
//

#import "UIRefreshComponent.h"

@interface UIRefreshComponent ()

@property (nonatomic, weak) id target;
@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, assign) CGFloat dragOffset;
@property (nonatomic, assign) CGFloat dragPercent;
@property (nonatomic, assign) CGFloat expandHeight;   //展开的高度，是一个设置的固定值

@property (nonatomic, assign) BOOL isAttached;
@property (nonatomic, assign) BOOL isExpanded;
//@property (nonatomic, assign) BOOL isIgnoreObserve;
//@property (nonatomic, assign) UIRefreshStatus status;
//@property (nonatomic, assign) UIEdgeInsets originalInset;

@end

@implementation UIRefreshComponent

#pragma mark - Class

+ (instancetype)attach:(UIScrollView *)scrollView {
    UIRefreshComponent* component = [self new];
    [component attach:scrollView];
    return component;
}

+ (instancetype)attach:(UIScrollView *)scrollView target:(id)target action:(SEL)action {
    UIRefreshComponent* component = [self attach:scrollView];
    [component addTarget:target action:action];
    return component;
}

#pragma mark - Init

- (void)dealloc
{
    NSLog(@"dealloc-%@", self.class);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpComponent];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setUpComponent];
    }
    return self;
}

/**
 * 初始化参数
 */
- (void)setUpComponent {
    self.dragOffset = -1;
    self.dragPercent = 0;
    self.triggerRate = 1;
    self.durationFast = 0.1;
    self.durationNormal = 0.25;
    self.isAttached = FALSE;
//    self.originalInset = UIEdgeInsetsZero;
    self.colorPrimary = [UIColor clearColor];
    self.colorAccent = [UIColor darkGrayColor];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.height == 0 && self.scrollMode != UISmartScrollModeStretch) {
            self.height = 45;//如果子类没有设置，自动设置为45，以便演示
            self.backgroundColor = [UIColor systemBlueColor];
        }
    });
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGFloat)expandHeight {
    if (self.scrollMode == UISmartScrollModeStretch) {
        return MAX(_expandHeight, 1);
    }
    return MAX(self.frame.size.height, 1);
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    [self setFrame:frame];
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    [self setFrame:frame];
    [self setExpandHeight:height];
}

//- (BOOL)inStatus:(UIRefreshStatus)status, ... {
//    va_list args;
//    va_start(args, status);
//    UIRefreshStatus arg = status;
//    do {
//        if (self.status == arg) {
//            return true;
//        }
//        arg = va_arg(args, UIRefreshStatus);
//    } while (arg != 0);
//    va_end(args);
//    return false;
//}
//
//- (BOOL)isRefreshing {
//    return [self inStatus:UIRefreshStatusWillRefresh,UIRefreshStatusReleasing,UIRefreshStatusRefreshing,0];
//}

#pragma mark - Api

- (void)attach:(UIScrollView *)scrollView {
//    self.translatesAutoresizingMaskIntoConstraints = FALSE;
//    scrollView.translatesAutoresizingMaskIntoConstraints = FALSE;
    [scrollView insertSubview:self atIndex:0];
}

- (void)addTarget:(id)target action:(SEL)action {
    [self addTarget:target action:action forControlEvents:UIControlEventValueChanged];
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    if (controlEvents == UIControlEventValueChanged) {
        self.target = target;
    }
    [super addTarget:target action:action forControlEvents:controlEvents];
}


//- (void)setStatus:(UIRefreshStatus)status {
//    UIRefreshStatus old = _status;
//
//    _status = status;
//
//    BOOL changed = old != status;
//    UIScrollView* scrollView = self.scrollView;
//    if (changed && scrollView != nil) {
//        [self scrollView:scrollView didChange:old status:status];
//    }
//}

#pragma mark - Override

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    id superView = self.superview;
    if ([superView isKindOfClass:[UIScrollView class]]) {
        [self scrollView:superView detached:TRUE];
    }
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    id superView = self.superview;
    if ([superView isKindOfClass:[UIScrollView class]]) {
        [self scrollView:superView attached:TRUE];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {

    UIScrollView* scrollView = self.scrollView;
    if (scrollView == nil || change == nil) {
        return;
    }
    
    if ([@"contentOffset" isEqualToString:keyPath]) {
        CGPoint newValue = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
        CGPoint oldValue = [[change valueForKey:NSKeyValueChangeOldKey] CGPointValue];
        
        [self scrollView:scrollView didChange:oldValue contentOffset:newValue];
    } else if ([@"contentInset" isEqualToString:keyPath]) {
        UIEdgeInsets newValue = [[change valueForKey:NSKeyValueChangeNewKey] UIEdgeInsetsValue];
        UIEdgeInsets oldValue = [[change valueForKey:NSKeyValueChangeOldKey] UIEdgeInsetsValue];
        [self scrollView:scrollView didChange:oldValue contentInset:newValue];
    }
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGSize size = self.bounds.size;
    if (size.height > 0 && size.height > 0 && self.layer.sublayers.count == 0) {
        [self.colorPrimary setFill];
        CGContextFillRect(UIGraphicsGetCurrentContext(), self.bounds);
    }
}

#pragma mark - Method


- (void)addObservers:(UIScrollView*) scrollView {
    NSUInteger opt = NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld;
    [scrollView addObserver:self forKeyPath:@"contentInset" options:opt context:nil];
    [scrollView addObserver:self forKeyPath:@"contentOffset" options:opt context:nil];
}

- (void)removeObservers:(UIScrollView*) scrollView {
    [scrollView removeObserver:self forKeyPath:@"contentInset"];
    [scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

//- (void)adjustInset:(UIScrollView*) scrollView expand:(BOOL) expand {
//    if (expand != self.isExpanded) {
//        self.isExpanded = expand;
//        self.isIgnoreObserve = TRUE;
//
//        UIEdgeInsets inset = self.originalInset;
//        CGFloat expandHeight = self.expandHeight;
////        CGFloat offset = -[self finalyContentInsetsFrom:scrollView];
//        if (expand) {
////            offset -= expandHeight;
//            inset.top += expandHeight;
////        } else {
////            offset += expandHeight;
//        }
//        [UIView animateWithDuration:self.durationNormal animations:^{
//            [scrollView setContentInset:inset];
////            [scrollView setContentOffset:CGPointMake(0, offset) animated:FALSE];
//        } completion:^(BOOL finished) {
//            if (expand) {
//                [self setStatus:UIRefreshStatusRefreshing];
//                [self performRefreshEvent];
//            } else {
//                [self setStatus:UIRefreshStatusIdle];
//            }
//        }];
//        self.isIgnoreObserve = FALSE;
//    }
//
//}

- (void)scrollView:(UIScrollView*) scrollView attached:(BOOL) attach {
//    self.originalInset = scrollView.contentInset;
    [self setScrollView:scrollView];
    [self setWidth:scrollView.frame.size.width];
    [self addObservers:scrollView];
    [self setIsAttached:TRUE];
}

- (void)scrollView:(UIScrollView*) scrollView detached:(BOOL) detach {
    [self removeObservers:scrollView];
    [self setIsAttached:FALSE];
}

- (void)scrollView:(UIScrollView *)scrollView didChange:(UIEdgeInsets) old contentInset:(UIEdgeInsets)value {
//    if (!self.isIgnoreObserve) {
//        self.originalInset = value;
//
//        if (self.isExpanded) {
//            self.isIgnoreObserve = TRUE;
//            CGFloat offsetY = scrollView.contentOffset.y;
//            value.top += self.expandHeight;
//            scrollView.contentInset = value;
//            scrollView.contentOffset = CGPointMake(0, offsetY);
//            self.isIgnoreObserve = FALSE;
//        }
//    }
}

- (void)scrollView:(UIScrollView *)scrollView didChange:(CGPoint)old contentOffset:(CGPoint)value {
    
//    NSLog(@"contentOffset=%@", @(value));

    const BOOL isExpanded = self.isExpanded;
    const CGFloat expandHeight = self.expandHeight;
    const CGFloat inset = [self finalyContentInsetsFrom:scrollView];
    const CGFloat offsetDrag = [self finalyDragOffset:value inset:inset height:expandHeight expand:isExpanded];//-value.y - inset + (isExpanded ? expandHeight : 0);
    const CGFloat offset = MAX(0, offsetDrag);
    const CGFloat offsetLast = self.dragOffset;
//    NSLog(@"contentOffset:offset=%@", @(offset));
    //拖动位置不变时，不需要执行移动事件
    if (offsetLast != offset) {
        [self setDragOffset:offset];
        [self setDragPercent:offset / MAX(1, expandHeight * self.triggerRate)];
        [self adjustFrameWithHeight:expandHeight inset:inset expand:isExpanded offset:value.y];
        
        [self scrollView:scrollView didScroll:offset percent:self.dragPercent drag:scrollView.isDragging];
    } else if (offset == 0 && offsetDrag < 0 && self.scrollMode == UISmartScrollModeFront) {
        [self adjustFrameWithHeight:expandHeight inset:inset expand:isExpanded offset:value.y];
    }
}

//- (void)scrollView:(UIScrollView*) scrollView didChange:(UIRefreshStatus) old status:(UIRefreshStatus) status {
//
//}

- (void)scrollView:(UIScrollView *)scrollView didScroll:(CGFloat)offset percent:(CGFloat)percent drag:(BOOL)isDragging {
    
}

- (void)adjustFrameWithHeight:(CGFloat)expandHeight inset:(CGFloat)insetTop expand:(BOOL)isExpanded offset:(CGFloat)offset {
    
}

//- (void)performRefreshEvent {
//
//}

#pragma mark - Util

- (CGFloat)finalyContentInsetsFrom:(UIScrollView*) scrollView {
    if (@available(iOS 11.0, *)) {
        return scrollView.adjustedContentInset.top;
    } else {
        return scrollView.contentInset.top;
    }
}

- (CGFloat)finalyDragOffset: (CGPoint) contentOffset inset: (CGFloat) inset height: (CGFloat) expandHeight expand: (BOOL) isExpanded {
    return -contentOffset.y - inset + (isExpanded ? expandHeight : 0);
}

@end
