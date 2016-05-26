//
//  MyTableViewDataSource.m
//  TimerApp
//
//  Created by Alexandr Polukhin on 23.05.16.
//  Copyright © 2016 Alexandr Polukhin. All rights reserved.
//

#import "MyTableViewDataSource.h"

@implementation MyTableViewDataSource
@synthesize timerArray;

- (id) init
{
    self = [super init];
    if (self != nil)
    {
        NSFileManager *fm = [NSFileManager defaultManager];
        if ([fm fileExistsAtPath:@"timers.dat"])
        {
            NSData *data = [NSData dataWithContentsOfFile:@"timers.dat"];
            NSKeyedUnarchiver *dec = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
            NSMutableArray *tArray = [NSMutableArray arrayWithCapacity:1];
            while (true)
            {
                MyTimerData *t = [dec decodeObject];
                if (t == nil)
                {
                    break;
                }
                [tArray addObject:t];
            }
            [dec finishDecoding];
            self->timerArray = [NSMutableArray arrayWithArray:tArray];
        }
        else
        {
            self->timerArray = [NSMutableArray array];
        }
    }
    return self;
}

- (BOOL) tableView: (NSTableView *) tableView shouldEditTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    return false;
}

- (void) tableViewSelectionDidChange:(NSNotification *)notification
{
    
    ViewController *VC = [[ViewController alloc] init];
    MyTimerData *t = [timerArray objectAtIndex:[VC.tableView selectedRow]];
    VC.minTimerField.intValue = t.minutes;
    VC.secTimerField.intValue = t.seconds;
    
}
- (NSInteger) numberOfRowsInTableView:(NSTableView *)tableView
{
    NSLog(@"кол-во строк: %li", self->timerArray.count);
    return self->timerArray.count;
}

- (id) tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    MyTimerData *timer = [self->timerArray objectAtIndex:row];
    if ([tableColumn.identifier isEqualToString:@"Name"])
    {
        return timer.name;
    }
    else
    if ([tableColumn.identifier isEqualToString:@"Time"])
    {
        return [NSString stringWithFormat:@"%i:%i", timer.minutes, timer.seconds];
    }
    return @"----";
}




@end
