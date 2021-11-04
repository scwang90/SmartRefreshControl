//
//  StoreHouseLine.h
//  Refresh
//
//  Created by SCWANG on 2021/3/10.
//  Copyright © 2021 Teeyun. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StoreHouseLine : NSObject

@property (nonatomic, assign) CGPoint start;
@property (nonatomic, assign) CGPoint end;
@property (nonatomic, assign) CGPoint middle;
@property (nonatomic, assign) CGFloat alpha;
@property (nonatomic, assign) CGFloat offset;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) CGAffineTransform transform;

@end

NS_ASSUME_NONNULL_END
