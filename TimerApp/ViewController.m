//
//  ViewController.m
//  TimerApp
//
//  Created by Alexandr Polukhin on 22.05.16.
//  Copyright © 2016 Alexandr Polukhin. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController
{
    MyTableViewDataSource *datasource;
    NSThread *Timer;
}

@synthesize minTimerField;
@synthesize secTimerField;
@synthesize tableView;


- (void)viewDidLoad
{
    [super viewDidLoad];
    OnlyIntegerValueFormatter *formatter = [[OnlyIntegerValueFormatter alloc] init];
    [minTimerField setFormatter:formatter];
    [secTimerField setFormatter:formatter];
    
    Timer.name = @"TimerThr";
    
    NSTableColumn *nameCol = [[NSTableColumn alloc] initWithIdentifier:@"Name"];
    [nameCol setTitle:@"Название"];
    [self->tableView addTableColumn:nameCol];
    
    NSTableColumn *timeCol = [[NSTableColumn alloc] initWithIdentifier:@"Time"];
    [timeCol setTitle:@"Время"];
    [self->tableView addTableColumn:timeCol];
    
    self->datasource = [[MyTableViewDataSource alloc] init];
    
    [self->tableView setDataSource:datasource];
    [self->tableView setEnabled:true];

    TimerWindow = [[TimerWindowController alloc] initWithWindowNibName:@"TimerWindowController"];
    [TimerWindow loadWindow];
    [TimerWindow showWindow:nil];

    if ([NSScreen screens].count > 1)
    {
//        NSScreen *screen = [NSScreen screens][1];
//        [self.view enterFullScreenMode:[NSScreen screens][0] withOptions:nil];
//        [TimerWindow.window.contentView enterFullScreenMode:[NSScreen screens][1] withOptions:nil];
    }
}

- (void) viewDidDisappear
{
    exit(0);
}

- (void)setRepresentedObject:(id)representedObject
{
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)startBtnClicked:(id)sender
{
    if ([self->Timer isExecuting])
    {
        [self->Timer cancel];
    }
    if (self->minTimerField.stringValue.length == 0 &&
        self->secTimerField.stringValue.length == 0)
    {
        return;
    }
    
    TimerThread *TT = [[TimerThread alloc] initWithMinutes:self->minTimerField.intValue
                                                   Seconds:self->secTimerField.intValue
                                                  andLabel:self->timerLabel
                                                 andWindow:TimerWindow];
     self->Timer = [[NSThread alloc] initWithTarget:TT
                                              selector:@selector(runMethod:)
                                                object:nil];

    [Timer start];
    
}

- (IBAction)startSelectedButtonCkick:(id)sender
{
    long numberOfSelectedRow = [self->tableView selectedRow];
    NSLog(@"numberOfSelectedRow: %li", numberOfSelectedRow);
    if ([self->tableView selectedRow] < 0)
    {
        return;
    }
    if ([self->Timer isExecuting])
    {
        [self->Timer cancel];
    }
    MyTimerData *t = self->datasource.timerArray[numberOfSelectedRow];
    TimerThread *TT = [[TimerThread alloc] initWithTimer:t
                                                andLabel:self->timerLabel
                                               andWindow:TimerWindow];
    self->Timer = [[NSThread alloc] initWithTarget:TT
                                          selector:@selector(runMethod:)
                                            object:nil];
    Timer.name = @"TimerThr";
    [Timer start];
    
}

- (IBAction)stopBtnClicked:(id)sender
{
    [self->Timer cancel];
}
- (IBAction)addButtonClicked:(id)sender
{
    MyModalViewController *MMVC = [[MyModalViewController alloc] initWithNibName:nil bundle:nil];
    NSWindow *wind = [NSWindow windowWithContentViewController:MMVC];
    wind.styleMask = NSTitledWindowMask;
    wind.title = @"Добавить новый таймер";
    wind.delegate = MMVC;
    [self.view.window beginSheet: wind completionHandler: (void (^)(NSModalResponse returnCode))
     ^(NSModalResponse returnCode)
     {
         NSLog(@"returnCode: %li", returnCode);
         if (returnCode == 50)
         {
            MyTimerData *t = [[MyTimerData alloc] initWithName:[MMVC.nameTextField.stringValue capitalizedString]
                                                       Minutes:MMVC.minutesTextField.intValue
                                                    andSeconds:MMVC.secondsTextField.intValue];

            [self->datasource.timerArray addObject:t];
            [self save];
            [self->tableView reloadData];
         }
             NSLog(@"Диалоговое окно закрылось с кодом: %li", returnCode);
     }];
}


- (IBAction)deleteButtonClicked:(id)sender
{
    long numberOfSelectedRow = self->tableView.selectedRow;
    if (numberOfSelectedRow != -1)
    {
        [self->datasource.timerArray removeObjectAtIndex:numberOfSelectedRow];
        [self save];
        [self->tableView reloadData];
    }
}

- (IBAction)editButtonClick:(id)sender
{
    long numberOfSelectedRow = self->tableView.selectedRow;
    if (numberOfSelectedRow < 0 || numberOfSelectedRow >= self->datasource.timerArray.count)
    {
        return;
    }
    NSLog(@"numberOfSelectedRow = %li", numberOfSelectedRow);
    MyModalViewController *MMVC = [[MyModalViewController alloc] initWithNibName:nil bundle:nil];
    NSWindow *wind = [NSWindow windowWithContentViewController:MMVC];
    wind.styleMask = NSTitledWindowMask;
    wind.title = @"Добавить новый таймер";
    wind.delegate = MMVC;
    
    NSLog(@"Выбрана строка: %li", numberOfSelectedRow);
    MyTimerData *t = [self->datasource.timerArray objectAtIndex:numberOfSelectedRow];
    MMVC.nameTextField.stringValue = t.name;
    MMVC.minutesTextField.intValue = t.minutes;
    MMVC.secondsTextField.intValue = t.seconds;
    
    [self.view.window beginSheet: wind completionHandler: (void (^)(NSModalResponse returnCode))
     ^(NSModalResponse returnCode)
     {
         NSLog(@"Диалоговое окно закрылось с кодом: %li", returnCode);
         if (returnCode == 50)
         {
            self->datasource.timerArray[numberOfSelectedRow].name = [MMVC.nameTextField.stringValue capitalizedString];
            self->datasource.timerArray[numberOfSelectedRow].minutes = MMVC.minutesTextField.intValue;
            self->datasource.timerArray[numberOfSelectedRow].seconds = MMVC.secondsTextField.intValue;
         }
     }];
    
    [self save];
    [self->tableView reloadData];
}


- (void) save
{
    NSMutableData *data = [NSMutableData dataWithCapacity:1024];
    NSKeyedArchiver *enc = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    NSEnumerator *prodEnum = [self->datasource.timerArray objectEnumerator];
    MyTimerData *t;
    while (t = (MyTimerData *)[prodEnum nextObject])
    {
        [enc encodeObject:t];
    }
    [enc finishEncoding];
    [data writeToFile: @"timers.dat" atomically:false];
}

@end
