//
//  UIRefreshGamePlayingScene.h
//  Refresh
//
//  Created by SCWANG on 2021/6/8.
//  Copyright © 2021 Teeyun. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIRefreshGamePlayingScene : SKScene

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UIColor *colorAccent;
@property (nonatomic, strong) UIColor *colorPrimary;

- (void) reset;
- (void) start;

- (void) gameWin;
- (void) gameOver;
- (void) moveHandle: (CGFloat) percent;
- (void) finishWithSuccess: (BOOL) success;

@end

NS_ASSUME_NONNULL_END
