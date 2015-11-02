//
//  AudioWaveView.m
//  LCAudioWaveSample
//
//  Created by jiangliancheng on 15/11/2.
//  Copyright © 2015年 jiangliancheng. All rights reserved.
//

#import "AudioWaveView.h"
#import "CheckMacro.h"

@implementation AudioWaveView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGFloat waveWidth = rect.size.width - (_edgeInset.left + _edgeInset.right);
    CNRA(waveWidth > 0);
    CGFloat waveHeight = rect.size.height - (_edgeInset.top + _edgeInset.bottom);
    CNRA(waveHeight > 0);
    
    CNRA(self.wavePoints.count);
    
    CGFloat pointGap = waveWidth / self.wavePoints.count;
    CGFloat midY = _edgeInset.top + waveHeight/2;

    CGContextRef context = UIGraphicsGetCurrentContext();

    CGMutablePathRef halfPath = CGPathCreateMutable();
    
    CGFloat originX = _edgeInset.left;
    CGPathMoveToPoint(halfPath, NULL, originX, midY);
    
    for (int i = 0; i < self.wavePoints.count; i++) {
        float pointHeight = [self.wavePoints[i] floatValue] * waveHeight/2;
        CGPathAddLineToPoint(halfPath, NULL, originX + i*pointGap, midY - pointHeight);
    }

    CGPathAddLineToPoint(halfPath, NULL, originX + waveWidth, midY);

    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddPath(path, NULL, halfPath);
    
    CGAffineTransform transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, midY * 2);
    transform = CGAffineTransformScale(transform, 1, -1);
    CGPathAddPath(path, &transform, halfPath);
    
    CGContextAddPath(context, path);
    CGContextSetFillColorWithColor(context, self.waveColor.CGColor);
    CGContextDrawPath(context, kCGPathFill);
    
    CGPathRelease(halfPath);
    CGPathRelease(path);


}

@end
