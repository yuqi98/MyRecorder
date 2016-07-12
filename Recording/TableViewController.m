//
//  TableViewController.m
//  Recording
//
//  Created by Yuqi Zhang on 7/8/16.
//  Copyright © 2016 Yuqi Zhang. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

@synthesize recordingsList;

/*-(instancetype) initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if(self)
    {
        self.recordingsList = [[NSMutableArray alloc] initWithCoder:aDecoder];
        [self.recordingsList addObject:@"hi"];
    }
    return self;
}*/

//long a;

- (void)viewDidLoad {
    [super viewDidLoad];
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error:nil];

    //NSLog(@"hi!");
    NSLog(@"number %lu",[self.recordingsList count]);
    
    //a=[self.recordingsList count];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}



-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"hi!");
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MyRecordings" forIndexPath:indexPath];
    
    //NSLog(@"hi!");
    
    //cell.textLabel.text = @"hi";
    //a=a+1;
    
    Recording* r = (Recording*)[self.recordingsList objectAtIndex:indexPath.row];
    
    NSLog(@"haha %@ (%lu recordings)",r.description, self.recordingsList.count);
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", r.date];
    
    //NSLog(@"hi!");
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //play the audio file that map onto the cell
    //Recording* r=[self.recordingsList objectAtIndex: indexPath.row];
    //[self play:r];
    //NSLog(@"hi!");
    
    Recording* r = (Recording*)[self.recordingsList objectAtIndex:indexPath.row];
    
    [self play: r];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    
    return [self.recordingsList count];
}

- (void) play: (Recording*) aRecording
{
    NSLog(@"Playing %@", aRecording.path);
    NSAssert([[NSFileManager defaultManager] fileExistsAtPath: aRecording.path], @"Doesn't exist");
    NSError *error;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL: aRecording.url error:&error];
    if(error){
        NSLog(@"playing audio: %@ %ld %@", [error domain], [error code], [[error userInfo] description]);
        return;
    }else{
        self.player.delegate = self;
    }
    if([self.player prepareToPlay] == NO){
        NSLog(@"Not prepared to play!");
        return;
    }
    [self.player play];
    NSLog(@"hello");
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player
                       successfully:(BOOL)flag
{
    NSLog(@"%d",flag);
    NSLog(@"done playing!!");
}

/*;;;;;;;;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
