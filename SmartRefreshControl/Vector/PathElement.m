//
//  PathElement.m
//  Refresh
//
//  Created by Teeyun on 2020/9/8.
//  Copyright © 2020 Teeyun. All rights reserved.
//

#import "PathElement.h"
#import "PathsParser.h"
#import "Utilities.h"

@interface PathElement ()

- (void) parseData:(NSString *)data;

@property (nonatomic, readwrite) CGPathRef pathForShape;

@end

@implementation PathElement

- (void)dealloc
{
    if (self.pathForShape) {
        CGPathRelease(self.pathForShape);
    }
}

+ (instancetype)newWith:(NSString *)data {
    PathElement* this = [self new];
    if (this) {
        [this parseData:data];
    }
    return this;
}

- (void)parseData:(NSString *)data
{
    CGMutablePathRef path = CGPathCreateMutable();
    NSScanner* dataScanner = [NSScanner scannerWithString:data];
    Curve lastCurve = [PathsParser startingCurve];
    BOOL foundCmd;
    
    NSCharacterSet *knownCommands = [NSCharacterSet characterSetWithCharactersInString:@"MmLlCcVvHhAaSsQqTtZz"];
    NSString* command;
    
    do {
        
        command = nil;
        foundCmd = [dataScanner scanCharactersFromSet:knownCommands intoString:&command];
        
        if (command.length > 1) {
            // Take only one char (it can happen that multiple commands are consecutive, as "ZM" - so we only want to get the "Z")
            const NSUInteger tooManyChars = command.length-1;
            command = [command substringToIndex:1];
            [dataScanner setScanLocation:([dataScanner scanLocation] - tooManyChars)];
        }
        
        if (foundCmd) {
            if ([@"z" isEqualToString:command] || [@"Z" isEqualToString:command]) {
                lastCurve = [PathsParser readCloseCommand:[NSScanner scannerWithString:command]
                                                                  path:path
                                                            relativeTo:lastCurve.p];
            } else {
                NSString* cmdArgs = nil;
                BOOL foundParameters = [dataScanner scanUpToCharactersFromSet:knownCommands
                                                                   intoString:&cmdArgs];
                
                if (foundParameters) {
                    NSString* cmdWithParams = [command stringByAppendingString:cmdArgs];
                    NSScanner* cmdScanner = [NSScanner scannerWithString:cmdWithParams];
                    
                    if ([@"m" isEqualToString:command]) {
                        lastCurve = [PathsParser readMovetoDrawToCmdGroups:cmdScanner
                                                                                       path:path
                                                                                 relativeTo:lastCurve.p
                                                                                 isRelative:TRUE];
                    } else if ([@"M" isEqualToString:command]) {
                        lastCurve = [PathsParser readMovetoDrawToCmdGroups:cmdScanner
                                                                                       path:path
                                                                                 relativeTo:CGPointZero
                                                                                 isRelative:FALSE];
                    } else if ([@"l" isEqualToString:command]) {
                        lastCurve = [PathsParser readLineToCmd:cmdScanner
                                                                           path:path
                                                                     relativeTo:lastCurve.p
                                                                     isRelative:TRUE];
                    } else if ([@"L" isEqualToString:command]) {
                        lastCurve = [PathsParser readLineToCmd:cmdScanner
                                                                           path:path
                                                                     relativeTo:CGPointZero
                                                                     isRelative:FALSE];
                    } else if ([@"v" isEqualToString:command]) {
                        lastCurve = [PathsParser readVerticalLineToCmd:cmdScanner
                                                                                   path:path
                                                                             relativeTo:lastCurve.p];
                    } else if ([@"V" isEqualToString:command]) {
                        lastCurve = [PathsParser readVerticalLineToCmd:cmdScanner
                                                                                   path:path
                                                                             relativeTo:CGPointZero];
                    } else if ([@"h" isEqualToString:command]) {
                        lastCurve = [PathsParser readHorizontalLineToCmd:cmdScanner
                                                                                     path:path
                                                                               relativeTo:lastCurve.p];
                    } else if ([@"H" isEqualToString:command]) {
                        lastCurve = [PathsParser readHorizontalLineToCmd:cmdScanner
                                                                                     path:path
                                                                               relativeTo:CGPointZero];
                    } else if ([@"c" isEqualToString:command]) {
                        lastCurve = [PathsParser readCurveToCmd:cmdScanner
                                                                            path:path
                                                                      relativeTo:lastCurve.p
                                                                      isRelative:TRUE];
                    } else if ([@"C" isEqualToString:command]) {
                        lastCurve = [PathsParser readCurveToCmd:cmdScanner
                                                                            path:path
                                                                      relativeTo:CGPointZero
                                                                      isRelative:FALSE];
                    } else if ([@"s" isEqualToString:command]) {
                        lastCurve = [PathsParser readSmoothCurveToCmd:cmdScanner
                                                                                  path:path
                                                                            relativeTo:lastCurve.p
                                                                         withPrevCurve:lastCurve
                                                                            isRelative:TRUE];
                    } else if ([@"S" isEqualToString:command]) {
                        lastCurve = [PathsParser readSmoothCurveToCmd:cmdScanner
                                                                                  path:path
                                                                            relativeTo:CGPointZero
                                                                         withPrevCurve:lastCurve
                                                                            isRelative:FALSE];
                    } else if ([@"q" isEqualToString:command]) {
                        lastCurve = [PathsParser readQuadraticCurveToCmd:cmdScanner
                                                                                     path:path
                                                                               relativeTo:lastCurve.p
                                                                               isRelative:TRUE];
                    } else if ([@"Q" isEqualToString:command]) {
                        lastCurve = [PathsParser readQuadraticCurveToCmd:cmdScanner
                                                                                     path:path
                                                                               relativeTo:CGPointZero
                                                                               isRelative:FALSE];
                    } else if ([@"t" isEqualToString:command]) {
                        lastCurve = [PathsParser readSmoothQuadraticCurveToCmd:cmdScanner
                                                                                           path:path
                                                                                     relativeTo:lastCurve.p
                                                                                  withPrevCurve:lastCurve];
                    } else if ([@"T" isEqualToString:command]) {
                        lastCurve = [PathsParser readSmoothQuadraticCurveToCmd:cmdScanner
                                                                                           path:path
                                                                                     relativeTo:CGPointZero
                                                                                  withPrevCurve:lastCurve];
                    } else if ([@"a" isEqualToString:command]) {
                        lastCurve = [PathsParser readEllipticalArcArguments:cmdScanner
                                                                                    path:path
                                                                              relativeTo:lastCurve.p
                                                                              isRelative:TRUE];
                    }  else if ([@"A" isEqualToString:command]) {
                        lastCurve = [PathsParser readEllipticalArcArguments:cmdScanner
                                                                                    path:path
                                                                              relativeTo:CGPointZero
                                                                              isRelative:FALSE];
                    } else  {
                        //SVGKitLogWarn(@"unsupported command %@", command);
                    }
                }
            }
        }
        
    } while (foundCmd);
    
    
    self.pathForShape = path;
    self.viewport = CGPathGetBoundingBox(path);
    self.changed = TRUE;
    //CGPathRelease(path);
}

- (CALayer *) newLayer
{
    NSAssert(self.pathForShape != NULL, @"Requested a CALayer for SVG shape that never initialized its own .pathForShapeInRelativeCoords property. Shape class = %@. Shape instance = %@", [self class], self );
    
    return [Utilities newLayerForElement:self withPath:self.pathForShape];
}

@end
