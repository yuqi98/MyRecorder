//
//  ViewController.h
//  Recording
//
//  Created by Yuqi Zhang on 7/6/16.
//  Copyright © 2016 Yuqi Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recording.h"
#import <AVFoundation/AVFoundation.h>


@interface ViewController : UIViewController <AVAudioRecorderDelegate>

@property (strong, nonatomic) NSMutableArray* allRecording;
@property (strong, nonatomic) Recording* currentRecording;
@property (strong, nonatomic) AVAudioRecorder* recorder;
@property (strong, nonatomic) NSTimer* timer;

@property (strong, nonatomic) IBOutlet UIProgressView *ProgressView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentTime;

- (IBAction)StartRecording:(id)sender;


- (IBAction)StopRecording:(id)sender;

@end

