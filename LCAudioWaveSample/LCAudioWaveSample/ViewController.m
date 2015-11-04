//
//  ViewController.m
//  LCAudioWaveSample
//
//  Created by jiangliancheng on 15/11/2.
//  Copyright © 2015年 jiangliancheng. All rights reserved.
//

#import "ViewController.h"
#import "AudioWave.h"

@interface ViewController ()
@property (nonatomic, strong)AudioWave *audioWave;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"夏洛特烦恼" ofType:@"mp3"];
    
    self.audioWave = [[AudioWave alloc] init];
    _audioWave.assetURL = [NSURL fileURLWithPath:path];
    _audioWave.frame = CGRectMake(0, 100, 320, 200);
    _audioWave.edgeInset = UIEdgeInsetsMake(10, 10, 50, 50);
    _audioWave.viewColor = [UIColor whiteColor];
    _audioWave.waveColor = [UIColor blackColor];
    [_audioWave drawAudioWave];
    [self.view addSubview:_audioWave.waveView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
