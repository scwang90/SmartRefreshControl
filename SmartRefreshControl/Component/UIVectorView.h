//
//  UIVectorView.h
//  Refresh
//
//  Created by Teeyun on 2020/9/10.
//  Copyright © 2020 Teeyun. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VectorImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIVectorView : UIView

@property (nonatomic, strong, nullable) VectorImage *image;

- (void)parserPaths:(NSArray<NSString*>*) paths;
- (void)parserColors:(NSArray<UIColor*>*) colors;

@end

NS_ASSUME_NONNULL_END
