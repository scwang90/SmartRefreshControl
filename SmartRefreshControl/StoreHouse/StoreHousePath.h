//
//  StoreHousePath.h
//  Refresh
//
//  Created by SCWANG on 2021/3/10.
//  Copyright © 2021 Teeyun. All rights reserved.
//

#import "StoreHouseLine.h"

NS_ASSUME_NONNULL_BEGIN

@interface StoreHousePath : NSObject

+ (NSArray<StoreHouseLine*>*)linesFromArray:(NSArray<NSString*>*)array;
+ (NSArray<StoreHouseLine*>*)linesFrom:(NSString*) str scale:(CGFloat) scale space:(NSInteger) space;

+ (NSArray<NSString*>*) arrayAkta;
+ (NSArray<NSString*>*) arrayStoreHouse;

@end

NS_ASSUME_NONNULL_END
