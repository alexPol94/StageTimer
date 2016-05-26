//
//  MyTimerData.m
//  TimerApp
//
//  Created by Alexandr Polukhin on 23.05.16.
//  Copyright © 2016 Alexandr Polukhin. All rights reserved.
//

#import "MyTimerData.h"

@implementation MyTimerData

@synthesize name;
@synthesize minutes;
@synthesize seconds;

- (id) initWithName:(NSString *)n Minutes:(int)m andSeconds:(int)s
{
    self = [super init];
    if (self != nil)
    {
        self->name = [NSString stringWithString:n];
        self->minutes = m;
        self->seconds = s;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self->name forKey:@"name"];
    [coder encodeInt:self->minutes forKey:@"minutes"];
    [coder encodeInt:self->seconds forKey:@"seconds"];
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self != nil)
    {
        self->name = (NSString *) [aDecoder decodeObjectForKey:@"name"];
        self->minutes = (int) [aDecoder decodeIntForKey:@"minutes"];
        self->seconds = (int) [aDecoder decodeIntForKey:@"seconds"];
    }
    return self;
}
@end
