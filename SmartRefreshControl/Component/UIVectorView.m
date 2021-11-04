//
//  UIVectorView.m
//  Refresh
//
//  Created by Teeyun on 2020/9/10.
//  Copyright © 2020 Teeyun. All rights reserved.
//

#import "UIVectorView.h"

@implementation UIVectorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)parserPaths:(NSArray<NSString *> *)paths {
    if (self.image == nil) {
        self.image = [VectorImage new];
    }
    [self.image parserPaths:paths];
}

- (void)parserColors:(NSArray<UIColor *> *)colors {
    if (self.image != nil) {
        [self.image parserColors:colors];
    }
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    if (self.image != NULL) {
        [self.image scaleToFitInside:frame.size];
    }
}

- (void)setTintColor:(UIColor *)tintColor {
    [super setTintColor:tintColor];
    
    VectorImage *image = self.image;
    if (image) {
        NSUInteger count = image.elements.count;
        NSMutableArray *colors = [NSMutableArray arrayWithCapacity:count];
        for (int i = 0; i < count; i++) {
            [colors addObject:tintColor];
        }
        [image parserColors:colors];
    }
}

- (void)setVectorImage:(VectorImage *)image {
    _image = image;
    
    CGSize size = self.frame.size;
    if (!CGSizeEqualToSize(CGSizeZero, size)) {
        [image scaleToFitInside:size];
    }
}

- (void)sizeToFit {
    VectorImage *image = self.image;
    if (image) {
        CGRect frame = self.frame;
        frame.size = image.viewport.size;
        self.frame = frame;
    } else {
        [super sizeToFit];
    }
}

- (CGSize)sizeThatFits:(CGSize)size {
    VectorImage *image = self.image;
    if (image) {
        CGSize sizeImage = image.viewport.size;
        if (sizeImage.width > size.width || sizeImage.height > size.height) {
            CGSize old = image.size;
            [image scaleToFitInside:size];
            size = image.size;
            image.size = old;
            return size;
        }
        return image.viewport.size;
    } else {
        return [super sizeThatFits:size];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    VectorImage *image = self.image;
    if (image) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        
        CGSize sizeImage = image.size;
        CGSize sizeCanvas = self.bounds.size;
        
        CGContextTranslateCTM(context, sizeCanvas.width/2-sizeImage.width/2, sizeCanvas.height/2-sizeImage.height/2 );
        
        [self.image renderInContext:context];
        
        CGContextRestoreGState(context);
    } else {
        [super drawRect:rect];
    }
}


@end
