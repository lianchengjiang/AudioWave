//
//  SampleStrategy.m
//  LcAudioWaveSample
//
//  Created by jiangliancheng on 15/11/2.
//  Copyright © 2015年 jiangliancheng. All rights reserved.
//

#import "SampleStrategy.h"
#import "CheckMacro.h"

@implementation SampleStrategy

- (NSArray *)samplingWithOriginalData:(NSData *)data;
{
    CNRNA(self.sampleCount);
    
    NSMutableArray *originSampleArray = [NSMutableArray array];
    
    NSUInteger totalCount = data.length/sizeof(SInt16);
    NSUInteger binSize = ceil(totalCount*1.0/self.sampleCount);
    
    SInt16 *sample = (SInt16 *)data.bytes;

    for (NSUInteger i = 0; i < totalCount; i=i+binSize) {
        SInt16 sampleBin[binSize];
        
        for (int j = 0; j < binSize; j++) {
            sampleBin[j] = CFSwapInt16LittleToHost(sample[i+j]);
        }
        
        SInt16 value = [self sampingValueFromArray:sampleBin ofCount:binSize];
        [originSampleArray addObject:@(value)];
    }
    
    NSArray *sampleArry = [self compressSampleFromArray:originSampleArray];
    return sampleArry;
}

- (NSArray *)compressSampleFromArray:(NSArray *)array;
{
    float compressRatio = [self compressRatioWithDataArray:array];
    
    NSMutableArray *results = [NSMutableArray array];
    for (NSNumber *value in array) {
        [results addObject:@([value floatValue]*compressRatio)];
    }
    return results;

}

#pragma mark - sampling Strategy

- (SInt16)sampingValueFromArray:(SInt16[])array ofCount:(NSUInteger)count
{
    if (self.sampleType == sampleTypeMax) {
        return [self maxValueInArray:array ofCount:count];
    }
    
    return [self averageValueInArray:array ofCount:count];
}

- (SInt16)maxValueInArray:(SInt16[])array ofCount:(NSUInteger)count
{
    SInt16 maxValue = 0;
    for (int i = 0; i < count; i++) {
        SInt16 currentValue = abs(array[i]);
        if (currentValue > maxValue) {
            maxValue = currentValue;
        }
    }
    return maxValue;
}

- (SInt16)averageValueInArray:(SInt16[])array ofCount:(NSUInteger)count
{
    SInt64 totalValue = 0;
    for (int i = 0; i < count; i++) {
        SInt16 currentValue = abs(array[i]);
        totalValue += currentValue;
    }
    
    return totalValue/count;
}


#pragma mark - compress Strategy

- (float)compressRatioWithDataArray:(NSArray *)array;
{
    if (self.compressType == compressTypeConstant) {
        return self.compressRatio;
    }
    
    if (self.compressType == compressTypeFlexible) {
        return 1.0/[self maxValueInArray:array];
    }
    
    return 1.0;
}

- (SInt16)maxValueInArray:(NSArray *)array
{
    SInt16 maxValue = 0;
    for (NSNumber *valueNum in array) {
        SInt16 value = [valueNum intValue];
        if (value > maxValue) {
            maxValue = value;
        }
    }
    
    return maxValue;
}

@end
