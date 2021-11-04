//
//  PointsAndPathsParser.h
//  Refresh
//
//  Created by Teeyun on 2020/9/8.
//  Copyright © 2020 Teeyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Partially spammy; not as spammy as DEBUG_PATH_CREATION
 */
#define VERBOSE_PARSE_SVG_COMMAND_STRINGS 0

/*! Very useful for debugging the parser - this will output one line of logging
 * for every CGPath command that's actually done; you can then compare these lines
 * to the input source file, and manually check what's being sent to the renderer
 * versus what was expected
 *
 * this is MORE SPAMMY than VERBOSE_PARSE_SVG_COMMAND_STRINGS
 */
#define DEBUG_PATH_CREATION 0

typedef NS_ENUM(NSUInteger, CurveType) {
    CurveTypePoint,
    CurveTypeCubic,
    CurveTypeQuadratic,
};

typedef struct Curve
{
    CurveType type;
    CGPoint c1;
    CGPoint c2;
    CGPoint p;
} Curve;

@interface PathsParser : NSObject

+ (Curve) startingCurve;

+ (Curve) readMovetoDrawToCmdGroups:(NSScanner*)scanner path:(CGMutablePathRef)path relativeTo:(CGPoint)origin isRelative:(BOOL) isRelative;
+ (Curve) readMovetoDrawto:(NSScanner*)scanner path:(CGMutablePathRef)path relativeTo:(CGPoint)origin isRelative:(BOOL) isRelative;
+ (Curve) readMoveto:(NSScanner*)scanner path:(CGMutablePathRef)path relativeTo:(CGPoint)origin isRelative:(BOOL) isRelative;
+ (Curve) readMovetoArgumentSequence:(NSScanner*)scanner path:(CGMutablePathRef)path relativeTo:(CGPoint)origin isRelative:(BOOL) isRelative;

+ (Curve) readLineToCmd:(NSScanner*)scanner path:(CGMutablePathRef)path relativeTo:(CGPoint)origin isRelative:(BOOL) isRelative;
+ (Curve) readLinetoArgumentSequence:(NSScanner*)scanner path:(CGMutablePathRef)path relativeTo:(CGPoint)origin isRelative:(BOOL) isRelative;
+ (Curve) readVerticalLineToCmd:(NSScanner*)scanner path:(CGMutablePathRef)path relativeTo:(CGPoint)origin;
+ (Curve) readVerticalLinetoArgumentSequence:(NSScanner*)scanner path:(CGMutablePathRef)path relativeTo:(CGPoint)origin;
+ (Curve) readHorizontalLinetoArgumentSequence:(NSScanner*)scanner path:(CGMutablePathRef)path relativeTo:(CGPoint)origin;
+ (Curve) readHorizontalLineToCmd:(NSScanner*)scanner path:(CGMutablePathRef)path relativeTo:(CGPoint)origin;

+ (Curve) readQuadraticCurveToCmd:(NSScanner*)scanner path:(CGMutablePathRef)path relativeTo:(CGPoint)origin isRelative:(BOOL) isRelative;
+ (Curve) readQuadraticCurvetoArgumentSequence:(NSScanner*)scanner path:(CGMutablePathRef)path relativeTo:(CGPoint)origin isRelative:(BOOL) isRelative;
+ (Curve) readQuadraticCurvetoArgument:(NSScanner*)scanner path:(CGMutablePathRef)path relativeTo:(CGPoint)origin;
+ (Curve) readSmoothQuadraticCurveToCmd:(NSScanner*)scanner path:(CGMutablePathRef)path relativeTo:(CGPoint)origin withPrevCurve:(Curve)prevCurve;
+ (Curve) readSmoothQuadraticCurvetoArgumentSequence:(NSScanner*)scanner path:(CGMutablePathRef)path relativeTo:(CGPoint)origin withPrevCurve:(Curve)prevCurve;
+ (Curve) readSmoothQuadraticCurvetoArgument:(NSScanner*)scanner path:(CGMutablePathRef)path relativeTo:(CGPoint)origin withPrevCurve:(Curve)prevCurve;

+ (Curve) readCurveToCmd:(NSScanner*)scanner path:(CGMutablePathRef)path relativeTo:(CGPoint)origin isRelative:(BOOL) isRelative;
+ (Curve) readCurvetoArgumentSequence:(NSScanner*)scanner path:(CGMutablePathRef)path relativeTo:(CGPoint)origin isRelative:(BOOL) isRelative;
+ (Curve) readCurvetoArgument:(NSScanner*)scanner path:(CGMutablePathRef)path relativeTo:(CGPoint)origin;
+ (Curve) readSmoothCurveToCmd:(NSScanner*)scanner path:(CGMutablePathRef)path relativeTo:(CGPoint)origin withPrevCurve:(Curve)prevCurve isRelative:(BOOL) isRelative;
+ (Curve) readSmoothCurvetoArgumentSequence:(NSScanner*)scanner path:(CGMutablePathRef)path relativeTo:(CGPoint)origin withPrevCurve:(Curve)prevCurve isRelative:(BOOL) isRelative;
+ (Curve) readSmoothCurvetoArgument:(NSScanner*)scanner path:(CGMutablePathRef)path relativeTo:(CGPoint)origin withPrevCurve:(Curve)prevCurve;

+ (Curve) readEllipticalArcArguments:(NSScanner*)scanner path:(CGMutablePathRef)path relativeTo:(CGPoint)origin isRelative:(BOOL) isRelative;

+ (Curve) readCloseCommand:(NSScanner*)scanner path:(CGMutablePathRef)path relativeTo:(CGPoint)origin;

@end

NS_ASSUME_NONNULL_END
