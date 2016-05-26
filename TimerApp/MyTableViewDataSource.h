//
//  MyTableViewDataSource.h
//  TimerApp
//
//  Created by Alexandr Polukhin on 23.05.16.
//  Copyright © 2016 Alexandr Polukhin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "MyTimerData.h"
#import "ViewController.h"

@interface MyTableViewDataSource : NSObject <NSTableViewDelegate, NSTableViewDataSource>
{
    NSMutableArray <MyTimerData *> *timerArray;
}
@property NSMutableArray <MyTimerData *> *timerArray;

- (id) init;

@end
