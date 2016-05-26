//
//  TimerWindowController.m
//  TimerApp
//
//  Created by Alexandr Polukhin on 26.05.16.
//  Copyright © 2016 Alexandr Polukhin. All rights reserved.
//

#import "TimerWindowController.h"

@interface TimerWindowController ()

@end

@implementation TimerWindowController
@synthesize label;

- (void)windowDidLoad {
    [super windowDidLoad];
    
    
}


- (void) mouseUp:(NSEvent *)theEvent
{
    NSArray *screens = [NSScreen screens];
    long x = [screens indexOfObject:self.window.screen];
    if (x != 0)
    {
        [self.window toggleFullScreen:nil];
    }
}

- (void) mouseDown:(NSEvent *)theEvent
{
    if ([theEvent clickCount] == 2)
    {
//        NSArray *screens = [NSScreen screens];
//        long x = [screens indexOfObject:self.window.screen];
//        if (x != 0)
//        {
//            NSScreen *screen = [[NSScreen screens] objectAtIndex:1];
//        }
        [self.window toggleFullScreen:nil];
    }
}
@end
