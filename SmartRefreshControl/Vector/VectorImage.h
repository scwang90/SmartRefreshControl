//
//  VectorImage.h
//  Refresh
//
//  Created by Teeyun on 2020/9/10.
//  Copyright © 2020 Teeyun. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Element.h"

NS_ASSUME_NONNULL_BEGIN

@interface VectorImage : NSObject

@property (nonatomic, readonly) NSArray<Element*> *elements;

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGRect frame;
@property (nonatomic, assign) CGRect viewport;
@property (nonatomic, assign) CGFloat opacity;

- (void)addElement:(Element*) element;

- (void)parserPaths:(NSArray<NSString*>*) paths;
- (void)parserColors:(NSArray<UIColor*>*) colors;

- (void)scaleToFitInside:(CGSize) maxSize;
- (void)renderInContext:(CGContextRef) context;

- (void)setGeometricWidth:(CGFloat) width;
- (void)setGeometricHeight:(CGFloat) height;

- (void)moveTo:(CGPoint) pt;

@end

NS_ASSUME_NONNULL_END
