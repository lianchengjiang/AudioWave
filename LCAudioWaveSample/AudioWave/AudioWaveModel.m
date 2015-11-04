//
//  AudioWaveModel.m
//  LcAudioWaveSample
//
//  Created by jiangliancheng on 15/11/2.
//  Copyright © 2015年 jiangliancheng. All rights reserved.
//

#import "AudioWaveModel.h"
#import "CheckMacro.h"
#import <AVFoundation/AVFoundation.h>

@interface AudioWaveModel()
@property(nonatomic, strong, nullable)AVAsset *asset;

@end

@implementation AudioWaveModel
- (_Nullable instancetype)initWithSampleStrategy:(SampleStrategy * _Nonnull)SampleStrategy;
{
    if (!(self = [super init])) {
        return nil;
    }
    
    self.sampleStrategy = SampleStrategy;
    return self;
}


- (NSArray *)sampleArrayFromAsset
{
    CNRNA(self.asset);
    CNRNA(self.sampleStrategy);
    
    NSMutableData *sampleData = [self sampleDataFromAsset:self.asset];
    
    CNRNA(sampleData);
    
    NSArray *sampeArray = [self.sampleStrategy samplingWithOriginalData:sampleData];
    
    return sampeArray;
}

#pragma mark - Asset
- (NSMutableData *)sampleDataFromAsset:(AVAsset *)asset
{
    AVAssetReader *assetReader = [self assetReaderWithAsset:asset];
    
    CNRNA(assetReader.outputs.count);
    
    AVAssetReaderOutput *trackOutput = assetReader.outputs[0];
    BOOL start = [assetReader startReading];
    
    CNRNA(start);
    
    NSMutableData *sampleData = [NSMutableData data];
    
    while (assetReader.status == AVAssetReaderStatusReading) {
        CMSampleBufferRef sampleBuffer = [trackOutput copyNextSampleBuffer];
        
        if (!sampleBuffer) {
            continue;
        }
        
        CMBlockBufferRef blockBuffer = CMSampleBufferGetDataBuffer(sampleBuffer);
        
        size_t length = CMBlockBufferGetDataLength(blockBuffer);
        SInt16 sampleBitys[length];
        
        CMBlockBufferCopyDataBytes(blockBuffer, 0, length, sampleBitys);
        
        [sampleData appendBytes:sampleBitys length:length];
        
        CMSampleBufferInvalidate(sampleBuffer);
        CFRelease(sampleBuffer);
    }
    
    CNRNA(assetReader.status == AVAssetReaderStatusCompleted);

    return sampleData;
}

- (AVAssetReader *)assetReaderWithAsset:(nonnull AVAsset *)asset
{
    AVAssetReader *reader = [AVAssetReader assetReaderWithAsset:asset error:nil];

    CNRNA(reader);
    
    NSArray *trackList = [asset tracksWithMediaType:AVMediaTypeAudio];
    
    CNRNA(trackList.count);
    
    AVAssetTrack *track = trackList[0];
    
    NSDictionary *outputSetting = @{AVFormatIDKey:@(kAudioFormatLinearPCM),
                                    AVLinearPCMBitDepthKey:@(16),
                                    AVLinearPCMIsBigEndianKey:@(NO),
                                    AVLinearPCMIsFloatKey:@(NO)};
    
    AVAssetReaderTrackOutput *trackOutput = [[AVAssetReaderTrackOutput alloc] initWithTrack:track outputSettings:outputSetting];
    
    [reader addOutput:trackOutput];
    
    return reader;
}

#pragma mark - setter & getter
- (void)setAssetURL:(NSURL *)assetURL
{
    if ([assetURL isEqual:_assetURL]) {
        return;
    }
    _assetURL = assetURL;
    
    self.asset = [AVAsset assetWithURL:assetURL];
    [self.asset loadValuesAsynchronouslyForKeys:@[@"tracks"] completionHandler:^{ }];
}

@end
