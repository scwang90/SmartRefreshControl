//
//  UIVectorView.h
//  Refresh
//
//  Created by Teeyun on 2020/9/10.
//  Copyright © 2020 Teeyun. All rights reserved.
//

#import <UIKit/UIKit.h>

#if __has_include(<SmartRefreshControl/VectorImage.h>)
#import <SmartRefreshControl/VectorImage.h>
#else
#import "VectorImage.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface UIVectorView : UIView

@property (nonatomic, strong, nullable) VectorImage *image;

- (void)parserPaths:(NSArray<NSString*>*) paths;
- (void)parserColors:(NSArray<UIColor*>*) colors;

@end

NS_ASSUME_NONNULL_END
