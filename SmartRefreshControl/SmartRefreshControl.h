//
//  SmartRefreshControl.h
//  SmartRefreshControl
//
//  Created by SCWANG on 2021/11/4.
//

#import <Foundation/Foundation.h>

//! Project version number for SmartRefreshControl.
FOUNDATION_EXPORT double SmartRefreshControlVersionNumber;

//! Project version string for SmartRefreshControl.
FOUNDATION_EXPORT const unsigned char SmartRefreshControlVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <SmartRefreshControl/PublicHeader.h>


//#import "Element.h"
//#import "Utilities.h"
//#import "PathElement.h"
//#import "PathsParser.h"
//#import "VectorImage.h"
//#import "UIVectorView.h"
//#import "StoreHousePath.h"


#if __has_include(<SmartRefreshControl/UIRefreshComponent.h>)

#import <SmartRefreshControl/UIRefreshFooter.h>
#import <SmartRefreshControl/UIRefreshHeader.h>
#import <SmartRefreshControl/UIRefreshComponent.h>

#import <SmartRefreshControl/UIRefreshClassicsHeader.h>
#import <SmartRefreshControl/UIRefreshTaurusHeader.h>
#import <SmartRefreshControl/UIRefreshPhoenixHeader.h>
#import <SmartRefreshControl/UIRefreshDropBoxHeader.h>
#import <SmartRefreshControl/UIRefreshDeliveryHeader.h>
#import <SmartRefreshControl/UIRefreshBezierRadarHeader.h>
#import <SmartRefreshControl/UIRefreshBezierCircleHeader.h>
#import <SmartRefreshControl/UIRefreshOriginalHeader.h>
#import <SmartRefreshControl/UIRefreshMaterialHeader.h>
#import <SmartRefreshControl/UIRefreshWaveSwipeHeader.h>
#import <SmartRefreshControl/UIRefreshStoreHouseHeader.h>
#import <SmartRefreshControl/UIRefreshGameHitBlockHeader.h>
#import <SmartRefreshControl/UIRefreshGameBattleCityHeader.h>
#import <SmartRefreshControl/UIRefreshFlyHeader.h>

#import <SmartRefreshControl/UIRefreshClassicsFooter.h>

#else

#import "UIRefreshHeader.h"
#import "UIRefreshComponent.h"

#import "UIRefreshClassicsHeader.h"
#import "UIRefreshTaurusHeader.h"
#import "UIRefreshPhoenixHeader.h"
#import "UIRefreshDropBoxHeader.h"
#import "UIRefreshDeliveryHeader.h"
#import "UIRefreshBezierRadarHeader.h"
#import "UIRefreshBezierCircleHeader.h"
#import "UIRefreshOriginalHeader.h"
#import "UIRefreshMaterialHeader.h"
#import "UIRefreshWaveSwipeHeader.h"
#import "UIRefreshStoreHouseHeader.h"
#import "UIRefreshGameHitBlockHeader.h"
#import "UIRefreshGameBattleCityHeader.h"
#import "UIRefreshFlyHeader.h"

#import "UIRefreshClassicsFooter.h"

#endif

