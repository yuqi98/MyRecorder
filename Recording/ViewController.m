//
//  ViewController.m
//  Recording
//
//  Created by Yuqi Zhang on 7/6/16.
//  Copyright © 2016 Yuqi Zhang. All rights reserved.
//

#import "ViewController.h"
//#import "Recording.h"
//#import <AVFoundation>
#import "TableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize allRecording;
@synthesize currentRecording;

NSString* archive;
bool Times=YES;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    archive = [NSString stringWithFormat:@"%@/Documents/AllRecordingArchive", NSHomeDirectory()];
    
    if([[NSFileManager defaultManager] fileExistsAtPath: archive])
    {
        self.allRecording=[NSKeyedUnarchiver unarchiveObjectWithFile:archive];
    }
    else{
        self.allRecording=[[NSMutableArray alloc] init];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)handleTimer
{
    self.ProgressView.progress += 0.04;
    if(self.ProgressView.progress == 1 )
    {
        [self.timer invalidate];
        [self.recorder stop];
        self.ProgressView.progress=0.0;
        self.currentRecording = nil;
          self.statusLabel.text = @"Stop";
        Times=YES;
        
    }
   
}



- (IBAction)StartRecording:(id)sender {
    //static bool times=YES;
    if(Times==NO)
    {
        self.statusLabel.text = @"HOW CAN YOU TAB START TWICE";
        [self.timer invalidate];
        [self.recorder stop];
        self.ProgressView.progress=0.0;
        self.currentRecording = nil;
        //self.statusLabel.text = @"Stop";
        Times=YES;
        
    }
    else{
        
    Times=!(Times);
    
    NSLog(@"Pressed!");
    
    AVAudioSession* audioSession = [AVAudioSession sharedInstance];
    
    NSError* err = nil;
    [audioSession setCategory: AVAudioSessionCategoryRecord error: &err];
    if(err){
        NSLog(@"audioSession: %@ %ld %@",
              [err domain], [err code], [[err userInfo] description]);
        return;
    }
    err = nil;
    [audioSession setActive:YES error:&err];
        
    
        
    if(err){
        NSLog(@"audioSession: %@ %ld %@",
              [err domain], [err code], [[err userInfo] description]);
        return;
    }
    
    NSMutableDictionary* recordingSettings = [[NSMutableDictionary alloc] init];
    
    [recordingSettings setValue:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    
    [recordingSettings setValue:@44100.0 forKey:AVSampleRateKey];
    
    [recordingSettings setValue:@1 forKey:AVNumberOfChannelsKey];
    
    [recordingSettings setValue:@16 forKey:AVLinearPCMBitDepthKey];
    
    [recordingSettings setValue:@(NO) forKey:AVLinearPCMIsBigEndianKey];
    
    [recordingSettings setValue:@(NO) forKey:AVLinearPCMIsFloatKey];
    
    [recordingSettings setValue:@(AVAudioQualityHigh)
                         forKey:AVEncoderAudioQualityKey];
    
    
    self.currentRecording = [[Recording alloc] initWithDate: [NSDate date]];
    
    [self.allRecording addObject: self.currentRecording];
    
    NSLog(@"%@",self.currentRecording);
    
    err = nil;
    
    self.recorder = [[AVAudioRecorder alloc]
                     initWithURL:self.currentRecording.url
                     settings:recordingSettings
                     error:&err];
    
    if(!self.recorder)
    {
        NSLog(@"recorder: %@ %ld %@",
              [err domain], [err code], [[err userInfo] description]);
        UIAlertController* alert = [UIAlertController
        alertControllerWithTitle:@"Warning"
                         message:[err localizedDescription]
                  preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction
                 actionWithTitle:@"OK"
                           style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    
    [self.recorder setDelegate: self]; 
    
    [self.recorder prepareToRecord];
    self.recorder.meteringEnabled = YES;
    
    BOOL audioHWAvailable = audioSession.inputAvailable;
    if( !audioHWAvailable ){
        UIAlertController* cantRecordAlert = [UIAlertController
        alertControllerWithTitle:@"Warning"
                         message:@"Audio input hardware not available."
                  preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction
                 actionWithTitle:@"OK"
                           style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action) {}];
        
        [cantRecordAlert addAction:defaultAction];
        [self presentViewController:cantRecordAlert animated:YES completion:nil];
        
        
        return;
    }
    
    // start recording
    [self.recorder recordForDuration:(NSTimeInterval)5];
    
    self.statusLabel.text = @"Recording...";
    self.ProgressView.progress = 0.0;
    self.timer = [NSTimer
                  scheduledTimerWithTimeInterval:0.2
                  target:self
                  selector:@selector(handleTimer)
                  userInfo:nil
                  repeats:YES];
        
      
    
    //NSString* p = r.path;
    
   // NSString* archive = [NSString stringWithFormat:@"%@/Documents/recordingArchive", NSHomeDirectory()];
    
    //[NSKeyedArchiver archiveRootObject: r toFile: archive];
    
    //assert([[NSFileManager defaultManager] fileExistsAtPath: archive]);
    
   //Users/yuqizhang/Documents/SCEHR-iOS-master/examples/MyRecording/Recording/Recording/Base.lproj/LaunchScreen.storyboard/ NSLog(@"%@",archive);
    
    //NSMutableArray* allRecording =  [[NSMutableArray alloc] init];
    
   // archive = [NSString stringWithFormat:@"%@/Documents/recordingArchive", NSHomeDirectory()];
    
    //allRecording = [NSKeyedUnarchiver unarchiveObjectWithFile:archive];
    
    //[allRecording addObject: r];
    
    //times=!(times)
    }
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    TableViewController* pvc=(TableViewController*)segue.destinationViewController;
    pvc.recordingsList = self.allRecording;
    
    
}

- (IBAction)StopRecording:(id)sender {
    [self.timer invalidate];
    self.ProgressView.progress=0.0;
    self.currentRecording = nil;
    [self.recorder stop];
    self.statusLabel.text = @"Stop";
    Times=YES;
    
}

-(void) viewWillDisappear:(BOOL)animated
{
    NSLog(@"HELLO%@",[[NSFileManager defaultManager] contentsAtPath:archive]);
    [NSKeyedArchiver archiveRootObject:self.allRecording  toFile: archive];
    NSLog(@"PLACE %@", archive);
}

@end
