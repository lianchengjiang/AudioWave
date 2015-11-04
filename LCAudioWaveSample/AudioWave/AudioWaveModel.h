//
//  AudioWaveModel.h
//  LcAudioWaveSample
//
//  Created by jiangliancheng on 15/11/2.
//  Copyright © 2015年 jiangliancheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SampleStrategy.h"

@interface AudioWaveModel : NSObject
@property(nonatomic, strong, nonnull)NSURL *assetURL;

@property(nonatomic, strong, nonnull)SampleStrategy *sampleStrategy;

- (_Nullable instancetype)initWithSampleStrategy:(SampleStrategy * _Nonnull)SampleStrategy;

- (NSArray * _Nullable)sampleArrayFromAsset;

@end
