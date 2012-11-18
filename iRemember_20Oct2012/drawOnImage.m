//
//  drawOnImage.m
//  iRemember
//
//  Created by Charles Shin on 11/17/12.
//  Copyright (c) 2012 Double One. All rights reserved.
//

#import "drawOnImage.h"

@implementation drawOnImage

@synthesize location;

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    self.location = [touch locationInView:self];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentLocation = [touch locationInView:self];
    
    UIGraphicsBeginImageContext(self.frame.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineWidth(ctx, 5.0);
    CGContextSetRGBStrokeColor(ctx, 1.0, 0.0, 0.0, 1.0);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, location.x, location.y);
    CGContextAddLineToPoint(ctx, currentLocation.x, currentLocation.y);
    CGContextStrokePath(ctx);
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    location = currentLocation;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentLocation = [touch locationInView:self];
    
    UIGraphicsBeginImageContext(self.frame.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineWidth(ctx, 5.0);
    CGContextSetRGBStrokeColor(ctx, 1.0, 0.0, 0.0, 1.0);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, location.x, location.y);
    CGContextAddLineToPoint(ctx, currentLocation.x, currentLocation.y);
    CGContextStrokePath(ctx);
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    location = currentLocation;
}

@end
