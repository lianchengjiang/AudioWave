//
//  AudioWave.m
//  LCAudioWaveSample
//
//  Created by jiangliancheng on 15/11/2.
//  Copyright © 2015年 jiangliancheng. All rights reserved.
//

#import "AudioWave.h"
#import "AudioWaveModel.h"
#import "AudioWaveView.h"
#import "SampleStrategy.h"

@interface AudioWave()
{
    CGRect _frame;
    UIEdgeInsets _edgeInset;
}
@property(nonatomic, strong, nonnull)AudioWaveModel *audioWaveModel;
@property(nonatomic, strong, nonnull)AudioWaveView *audioWaveView;


@end

@implementation AudioWave

- (instancetype)init
{
    if (!(self = [super init])) {
        return nil;
    }
    
    SampleStrategy *strategy = [[SampleStrategy alloc] init];
    self.audioWaveModel = [[AudioWaveModel alloc] initWithSampleStrategy:strategy];
    self.audioWaveView = [[AudioWaveView alloc] init];
    
    return self;
}

- (void)drawAudioWave;
{
    NSUInteger count = _frame.size.width - (_edgeInset.left + _edgeInset.right);
    self.audioWaveModel.sampleStrategy.sampleCount = count;
    
    NSArray *sampleArray = [self.audioWaveModel sampleArrayFromAsset];
    self.audioWaveView.wavePoints = sampleArray;
    
    [self.audioWaveView setNeedsDisplay];
}

#pragma mark - getter & setter
- (UIView *)waveView
{
    return self.audioWaveView;
}

- (void)setAssetURL:(NSURL *)assetURL
{
    self.audioWaveModel.assetURL = assetURL;
}

- (NSURL *)assetURL
{
    return self.audioWaveModel.assetURL;
}

- (void)setFrame:(CGRect)frame
{
    _frame = frame;
    self.audioWaveView.frame = frame;
}

- (void)setEdgeInset:(UIEdgeInsets)edgeInset
{
    _edgeInset = edgeInset;
    self.audioWaveView.edgeInset = edgeInset;
}

- (void)setViewColor:(UIColor *)viewColor
{
    self.audioWaveView.backgroundColor = viewColor;
}

- (UIColor *)viewColor
{
    return self.audioWaveView.backgroundColor;
}

- (void)setWaveColor:(UIColor *)waveColor
{
    self.audioWaveView.waveColor = waveColor;
}

- (UIColor *)waveColor
{
    return self.audioWaveView.waveColor;
}



@end
