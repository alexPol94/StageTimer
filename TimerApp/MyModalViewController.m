//
//  MyModalViewController.m
//  Lesson 47
//
//  Created by Alexandr Polukhin on 20.04.16.
//  Copyright © 2016 Alexandr Polukhin. All rights reserved.
//

#import "MyModalViewController.h"


@interface MyModalViewController ()

@end

@implementation MyModalViewController

@synthesize nameTextField;
@synthesize minutesTextField;
@synthesize secondsTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    OnlyIntegerValueFormatter *formatter = [[OnlyIntegerValueFormatter alloc] init];
    [minutesTextField setFormatter:formatter];
    [secondsTextField setFormatter:formatter];
}

- (IBAction)doneButtonClick:(id)sender
{
    if (self->nameTextField.stringValue.length > 0 &&
        (self->minutesTextField.stringValue.length > 0 ||
        self.secondsTextField.stringValue.length > 0))
    {
        if (self.view.window.sheet == true)
        {
            [self.view.window.sheetParent endSheet: self.view.window returnCode: 50];
        }
        else
        {
            [NSApp stopModalWithCode: 50];
            [self.view.window orderOut: nil];
        }
    }
    else
    {
        NSAlert *alert = [[NSAlert alloc] init];
        alert.alertStyle = NSCriticalAlertStyle;
        alert.informativeText = @"Ошибка";
        alert.messageText = @"Заполнены не все поля";

        [alert beginSheetModalForWindow:self.view.window completionHandler:nil];
        
        
    }
}

- (IBAction)cancelButtonClick:(id)sender
{
    if (self.view.window.sheet == true)
    {
        [self.view.window.sheetParent endSheet: self.view.window returnCode: 51];
    }
    else
    {
        [NSApp stopModalWithCode: 51];
        [self.view.window orderOut: nil];
    }
}
@end


