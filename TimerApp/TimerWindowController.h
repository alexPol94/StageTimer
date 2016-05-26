//
//  TimerWindowController.h
//  TimerApp
//
//  Created by Alexandr Polukhin on 26.05.16.
//  Copyright © 2016 Alexandr Polukhin. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TimerWindowController : NSWindowController
{
    IBOutlet NSTextField *label;
    
}
@property NSTextField *label;

@end
