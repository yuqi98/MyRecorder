//
//  Recording.h
//  Recording
//
//  Created by Yuqi Zhang on 7/6/16.
//  Copyright © 2016 Yuqi Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recording : NSObject <NSCoding>

@property (strong, nonatomic) NSDate* date;

//@property (strong, nonatomic) NSString *name;

@property (readonly, nonatomic) NSString* path;

@property (readonly, nonatomic) NSURL* url;

//@property (readonly, nonatomic) NSDateFormatter* realDate;


-(Recording*) initWithDate: (NSDate*) aDate;


@end
