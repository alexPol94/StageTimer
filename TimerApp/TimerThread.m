//
//  TimerThread.m
//  TimerApp
//
//  Created by Alexandr Polukhin on 22.05.16.
//  Copyright © 2016 Alexandr Polukhin. All rights reserved.
//

#import "TimerThread.h"

@implementation TimerThread

- (id) initWithMinutes:(int)m Seconds:(int)s andLabel:(NSTextField *)l andWindow:(TimerWindowController *)w
{
    self = [super init];
    if (self != nil)
    {
        self->minutes = m;
        self->seconds = s;
        self->label = l;
        self->window = w;
    }
    return self;
}

- (id) initWithTimer:(MyTimerData *)t andLabel:(NSTextField *)l andWindow:(TimerWindowController *)w
{
    self = [super init];
    if (self != nil)
    {
        self->minutes = t.minutes;
        self->seconds = t.seconds;
        self->label = l;
        self->window = w;
    }
    return self;
}

- (void) runMethod: (NSObject *) obj
{
    
    NSLog(@"Timer is started");
    int secondsTotal = self->minutes * 60 + self->seconds;
    for (int i = secondsTotal; i > 0; i--)
    {
        if ([NSThread currentThread].isCancelled == true)
        {
            NSLog(@"Timer is canceled");
            self->label.stringValue = @"";
            self->window.label.stringValue = self->label.stringValue;
            return;
        }
//        NSLog(@"%i:%i", i/60, i%60);
        NSString* minutesStr;
        NSString *secondsStr;
        if (i/60 < 10)
        {
            minutesStr = [NSString stringWithFormat:@"0%i", i/60];
        }
        else
        {
            minutesStr = [NSString stringWithFormat:@"%i", i/60];
        }
        if (i%60 < 10)
        {
            secondsStr = [NSString stringWithFormat:@"0%i", i%60];
        }
        else
        {
            secondsStr = [NSString stringWithFormat:@"%i", i%60];
        }
        self->label.stringValue = [NSString stringWithFormat:@"%@:%@", minutesStr, secondsStr];
        self->window.label.stringValue = self->label.stringValue;
        if (i/60 < 5)
        {
            [self->window.window setBackgroundColor:[NSColor orangeColor]];
        }
        [NSThread sleepForTimeInterval:1];
    }
    NSLog(@"Timer is completed");
    self->label.stringValue = @"00:00";
    self->window.label.stringValue = self->label.stringValue;
    [NSThread sleepForTimeInterval:5];
    self->label.stringValue = @"";
    self->window.label.stringValue = self->label.stringValue;
    
}
@end
