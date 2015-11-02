//
//  AudioWaveModel.h
//  LcAudioWaveSample
//
//  Created by jiangliancheng on 15/11/2.
//  Copyright © 2015年 jiangliancheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseSampleCategory.h"

@interface AudioWaveModel : NSObject
@property(nonatomic, strong, nonnull)NSURL *assetURL;

@property(nonatomic, assign)NSUInteger sampleCount;

@property(nonatomic, strong, nonnull) BaseSampleCategory *sampleCategory;

- (_Nullable instancetype)initWithSampleCategory:(__kindof BaseSampleCategory * _Nonnull)sampleCategory;

- (NSArray *)SampleArrayFromAsset;

@end
