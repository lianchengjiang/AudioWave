//
//  AudioWave.h
//  LCAudioWaveSample
//
//  Created by jiangliancheng on 15/11/2.
//  Copyright © 2015年 jiangliancheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AudioWave : NSObject
@property(nonatomic, strong, nonnull)NSURL *assetURL;

@end

@interface AudioWave(display)

//use after invoke -drawAudioWave.
@property(nonatomic, strong, readonly, nonnull)UIView *waveView;

//the frame of waveView. set this property before invoke -drawAudioWave.
@property(nonatomic, assign)CGRect frame;

//the edgeInset of waveView. set this property before invoke -drawAudioWave.
@property(nonatomic, assign)UIEdgeInsets edgeInset;

//the color of waveView.
@property(nonatomic, strong, nullable)UIColor *viewColor;

//the color of wave
@property(nonatomic, strong, nullable)UIColor *waveColor;

//draw audio wave base on assetURL and frame and edgeInset
- (void)drawAudioWave;
@end