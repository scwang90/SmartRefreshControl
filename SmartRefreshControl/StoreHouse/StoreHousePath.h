//
//  StoreHousePath.h
//  Refresh
//
//  Created by SCWANG on 2021/3/10.
//  Copyright © 2021 Teeyun. All rights reserved.
//

#if __has_include(<SmartRefreshControl/StoreHouseLine.h>)
#import <SmartRefreshControl/StoreHouseLine.h>
#else
#import "StoreHouseLine.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface StoreHousePath : NSObject

+ (NSArray<StoreHouseLine*>*)linesFromArray:(NSArray<NSString*>*)array;
+ (NSArray<StoreHouseLine*>*)linesFrom:(NSString*) str scale:(CGFloat) scale space:(NSInteger) space;

+ (NSArray<NSString*>*) arrayAkta;
+ (NSArray<NSString*>*) arrayStoreHouse;

@end

NS_ASSUME_NONNULL_END
