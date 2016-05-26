//
//  OnlyIntegerValueFormatter.m
//  TimerApp
//
//  Created by Alexandr Polukhin on 26.05.16.
//  Copyright © 2016 Alexandr Polukhin. All rights reserved.
//

#import "OnlyIntegerValueFormatter.h"

@implementation OnlyIntegerValueFormatter

- (BOOL)isPartialStringValid:(NSString *)partialString
            newEditingString:(NSString *__autoreleasing  _Nullable *)newString
            errorDescription:(NSString *__autoreleasing  _Nullable *)error
{
    if([partialString length] == 0)
    {
        return true;
    }
    
    NSScanner* scanner = [NSScanner scannerWithString:partialString];
    
    if(!([scanner scanInt:0] && [scanner isAtEnd]))
    {
        NSBeep();
        return false;
    }
//
    return true;
}



@end
