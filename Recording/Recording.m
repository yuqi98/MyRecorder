//
//  Recording.m
//  Recording
//
//  Created by Yuqi Zhang on 7/6/16.
//  Copyright © 2016 Yuqi Zhang. All rights reserved.
//

#import "Recording.h"

@implementation Recording

@synthesize date;

- (Recording*)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if(self){
        self.date = [decoder decodeObjectOfClass: [Recording class] forKey: @"date"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject: self.date forKey: @"date"];
}


-(Recording*) initWithDate: (NSDate*) aDate;
{
    //aDate.locale = [NSLocale currentLocale];
    self = [super init];
    if(self){
        self.date = aDate;
    }
    return self;
}

/*int a=0;
-(NSString*) name
{
    
    a=a+1;
    return [NSString stringWithFormat:@"%d",a];
}*/


-(NSString*) path
{
    NSString* home= NSHomeDirectory();
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString* dateString=[formatter stringFromDate: self.date];
    return [NSString stringWithFormat: @"%@/Documents/%@.caf", home, dateString];
}

-(NSURL*) url
{
    NSString* urlString = self.path;
    return[NSURL URLWithString: urlString];
}

-(NSString*) description
{
    return[NSString stringWithFormat: @"%@ %@ %@", self.date,self.path,self.url];
}


@end
