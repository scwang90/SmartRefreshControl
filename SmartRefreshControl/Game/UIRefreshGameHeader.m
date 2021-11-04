//
//  UIRefreshGameHeader.m
//  Refresh
//
//  Created by SCWANG on 2021/6/6.
//  Copyright © 2021 Teeyun. All rights reserved.
//
#import <SpriteKit/SpriteKit.h>

#import "UIRefreshGameHeader.h"
#import "UIRefreshGameStartScene.h"
#import "UIRefreshGamePlayingScene.h"

@interface UIRefreshHeader (UIRefreshGameHeader)

@property (nonatomic, assign) BOOL isSuccess;

@end

@interface UIRefreshGameHeader ()

@property (nonatomic, assign) BOOL requestFinish;
@property (nonatomic, strong) SKView *gameView;
@property (nonatomic, strong) UIRefreshGameStartScene *sceneStart;
@property (nonatomic, strong) UIRefreshGamePlayingScene *scenePlaying;

- (UIRefreshGamePlayingScene*) newPlayingScene;

@end

@implementation UIRefreshGameHeader

- (void)setUpComponent {
    [super setUpComponent];
    
    [self setHeight:100];
    [self setColorAccent:UIColor.whiteColor];
    [self setColorPrimary:UIColor.darkGrayColor];
    [self setScrollMode:UISmartScrollModeMove];
}

- (SKView *)gameView {
    if (_gameView == nil) {
        _gameView = [SKView new];
    }
    return _gameView;
}

- (UIRefreshGameStartScene *)sceneStart {
    if (_sceneStart == nil) {
        _sceneStart = [UIRefreshGameStartScene new];
        _sceneStart.colorAccent = self.colorAccent;
        _sceneStart.colorPrimary = self.colorPrimary;
    }
    return _sceneStart;
}

- (UIRefreshGamePlayingScene *)scenePlaying {
    if (_scenePlaying == nil) {
        _scenePlaying = [self newPlayingScene];
        _scenePlaying.colorAccent = self.colorAccent;
        _scenePlaying.colorPrimary = self.colorPrimary;
    }
    return _scenePlaying;
}

- (void)setFrame:(CGRect)frame {
    if (self.isAttached && self.frame.size.width != frame.size.width) {
        [super setFrame:frame];
        [self.sceneStart setSize:self.bounds.size];
        [self.scenePlaying setSize:self.bounds.size];
        [self.gameView setFrame:self.bounds];
    } else {
        [super setFrame:frame];
    }
}

- (void)setColorPrimary:(UIColor *)colorPrimary {
    [super setColorPrimary:colorPrimary];
    [self.scenePlaying setColorPrimary:colorPrimary];
    [self.sceneStart setColorPrimary:colorPrimary];
}

- (void)setColorAccent:(UIColor *)colorAccent {
    [super setColorAccent:colorAccent];
    [self.scenePlaying setColorAccent:colorAccent];
    [self.sceneStart setColorAccent:colorAccent];
}


- (UIRefreshGamePlayingScene *)newPlayingScene {
    return [UIRefreshGamePlayingScene new];
}

- (void)scrollView:(UIScrollView *)scrollView attached:(BOOL)attach {
    [super scrollView:scrollView attached:attach];
    [self.sceneStart setSize:self.bounds.size];
    [self.scenePlaying setSize:self.bounds.size];
    [self.gameView setFrame:self.bounds];
    [self.gameView presentScene:self.sceneStart];
    [self addSubview:self.gameView];
}

- (void)scrollView:(UIScrollView *)scrollView didScroll:(CGFloat)offset percent:(CGFloat)percent drag:(BOOL)isDragging {
    [super scrollView:scrollView didScroll:offset percent:percent drag:isDragging];
    if (self.isRefreshing) {
        if (!isDragging && self.requestFinish) {
            [self setRequestFinish:FALSE];
            [super finishRefreshWithSuccess:self.isSuccess];
        }
    }
}


//- (void)scrollView:(UIScrollView *)scrollView didChange:(UIRefreshStatus)old status:(UIRefreshStatus)status {
- (void)onStatus:(UIRefreshStatus)old changed:(UIRefreshStatus)status {
//    [super scrollView:scrollView didChange:old status:status];
    [super onStatus:old changed:status];
    if (status == UIRefreshStatusRefreshing) {
        [self setScrollMode:UISmartScrollModeFront];
    } else if (status == UIRefreshStatusFinish) {
        [self setScrollMode:UISmartScrollModeMove];
        SKTransition* transition = [SKTransition doorsCloseVerticalWithDuration:0.4];
        [self.gameView presentScene:self.sceneStart transition:transition];
    } else if (status == UIRefreshStatusIdle) {
        [self setNeedsLayout];
    }
}

- (void)onScrollingWithOffset:(CGFloat)offset percent:(CGFloat)percent drag:(BOOL)isDragging {
    if (isDragging) {
        [self.scenePlaying moveHandle:MIN(1,MAX((percent-1),0))];
    }
}

- (void)finishRefreshWithSuccess:(BOOL)success {
    [self.scenePlaying finishWithSuccess: success];
    if (self.scrollView.isDragging) {
        [self setIsSuccess:success];
        [self setRequestFinish:TRUE];
    } else {
        [super finishRefreshWithSuccess:success];
    }
}

- (void)onStartAnimationWhenRefreshing {
    SKTransition* transition = [SKTransition doorsOpenVerticalWithDuration:0.4];
    [self.scenePlaying reset];
    [self.scenePlaying start];
    [self.scenePlaying setTitle:@"Refreshing..."];
    [self.gameView presentScene:self.scenePlaying transition:transition];
}

@end
