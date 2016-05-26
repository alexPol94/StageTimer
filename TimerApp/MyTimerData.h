//
//  MyTimerData.h
//  TimerApp
//
//  Created by Alexandr Polukhin on 23.05.16.
//  Copyright © 2016 Alexandr Polukhin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyTimerData : NSObject <NSCoding>
{
    NSString *name;
    int minutes;
    int seconds;
}
@property NSString* name;
@property int minutes;
@property int seconds;

- (id) initWithName:(NSString*)n Minutes:(int)m andSeconds:(int)s;

@end
