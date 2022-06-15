//
//  UIRefreshStoreHouseHeader.h
//  Refresh
//
//  Created by Teeyun on 2021/2/1.
//  Copyright © 2021 Teeyun. All rights reserved.
//

#if __has_include(<SmartRefreshControl/UIRefreshHeader.h>)
#import <SmartRefreshControl/UIRefreshHeader.h>
#else
#import "UIRefreshHeader.h"
#endif


NS_ASSUME_NONNULL_BEGIN

@interface UIRefreshStoreHouseHeader : UIRefreshHeader

@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, assign) BOOL enableReverseFlash;
@property (nonatomic, assign) BOOL enableFadeAnimation;

//@property (nonatomic, assign) CGFloat loadingAniFlastDuration;
//@property (nonatomic, assign) CGFloat loadingAniAlphaDuration;

+ (instancetype) newWithString:(NSString*) string;
+ (instancetype) newWithString:(NSString*) string scale:(CGFloat) scale;
+ (instancetype) newWithString:(NSString*) string scale:(CGFloat) scale padding:(CGFloat) padding;

- (void) initLinesWithString:(NSString*) string;
- (void) initLinesWithString:(NSString*) string scale:(CGFloat) scale;
- (void) initLinesWithString:(NSString*) string scale:(CGFloat) scale padding:(CGFloat) padding;

- (void) initLinesWithArray:(NSArray<NSString*>*)array;
- (void) initLinesWithArray:(NSArray<NSString*>*)array padding:(CGFloat) padding;

@end

NS_ASSUME_NONNULL_END
