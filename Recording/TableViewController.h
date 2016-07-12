//
//  TableViewController.h
//  Recording
//
//  Created by Yuqi Zhang on 7/8/16.
//  Copyright © 2016 Yuqi Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recording.h"
#import <AVFoundation/AVFoundation.h>

@interface TableViewController : UITableViewController <AVAudioPlayerDelegate>

@property (strong,nonatomic) NSMutableArray* recordingsList;
//@property (strong,nonatomic) Recording* currentRecording;
@property (strong,nonatomic) AVAudioPlayer* player;


@end
