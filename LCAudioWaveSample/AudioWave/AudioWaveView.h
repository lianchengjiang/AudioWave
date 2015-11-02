//
//  AudioWaveView.h
//  LCAudioWaveSample
//
//  Created by jiangliancheng on 15/11/2.
//  Copyright © 2015年 jiangliancheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AudioWaveView : UIView
@property(nonatomic, strong, nullable)NSArray<NSNumber*> *wavePoints;
@property(nonatomic, strong, nullable)UIColor *waveColor;

@property(nonatomic, assign)UIEdgeInsets edgeInset;
@end
