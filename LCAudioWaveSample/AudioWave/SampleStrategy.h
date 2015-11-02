//
//  SampleStrategy.h
//  LcAudioWaveSample
//
//  Created by jiangliancheng on 15/11/2.
//  Copyright © 2015年 jiangliancheng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, sampleTypes) {
    sampleTypeAverage,
    sampleTypeMax,
};

typedef NS_ENUM(NSUInteger, compressTypes) {
    compressTypeFlexible,
    compressTypeConstant,
};

@interface SampleStrategy : NSObject
@property(nonatomic, assign)NSUInteger sampleCount;

@property(nonatomic, assign)sampleTypes sampleType;

/**
 *  when value is compressTypeConstant, you must set compressRatio;
 *  when value is compressTypeFlexible, data will be compress with max value in array
 */
@property(nonatomic, assign)compressTypes compressType;

//useful only when compressType is compressTypeConstant, value can't be negative number or zero
@property(nonatomic, assign)float compressRatio;

- (NSArray *)samplingWithOriginalData:(NSData *)data;
@end


