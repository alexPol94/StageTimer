//
//  TimerThread.h
//  TimerApp
//
//  Created by Alexandr Polukhin on 22.05.16.
//  Copyright © 2016 Alexandr Polukhin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "MyTimerData.h"
#import "TimerWindowController.h"

@interface TimerThread : NSObject
{
    int minutes;
    int seconds;
    MyTimerData *timer;
    NSTextField *label;
    TimerWindowController *window;
}

- (id) initWithMinutes: (int)m Seconds:(int)s andLabel:(NSTextField*)l andWindow:(TimerWindowController *)w;
- (id) initWithTimer: (MyTimerData*)t andLabel:(NSTextField*)l andWindow:(TimerWindowController *)w;
- (void) runMethod: (NSObject *) obj;
@end
