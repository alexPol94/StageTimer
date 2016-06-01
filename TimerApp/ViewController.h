//
//  ViewController.h
//  TimerApp
//
//  Created by Alexandr Polukhin on 22.05.16.
//  Copyright © 2016 Alexandr Polukhin. All rights reserved.
// 

#import <Cocoa/Cocoa.h>
#import "MyTableViewDataSource.h"
#import "TimerThread.h"
#import "MyModalViewController.h"
#import "TimerWindowController.h"


@interface ViewController : NSViewController
{
    IBOutlet NSTextField *minTimerField;
    IBOutlet NSTextField *secTimerField;
    
    IBOutlet NSTextField *timerLabel;
    IBOutlet NSTableView *tableView;
    
    BOOL isRuning;
    TimerWindowController *TimerWindow;
}

@property NSTextField *minTimerField;
@property NSTextField *secTimerField;
@property NSTableView *tableView;

- (IBAction)startBtnClicked:(id)sender;
- (IBAction)stopBtnClicked:(id)sender;
- (IBAction)addButtonClicked:(id)sender;
- (IBAction)deleteButtonClicked:(id)sender;
- (IBAction)editButtonClick:(id)sender;

- (IBAction)startSelectedButtonCkick:(id)sender;
- (void) save;

@end

