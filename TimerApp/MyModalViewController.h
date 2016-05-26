//
//  MyModalViewController.h
//  Lesson 47
//
//  Created by Alexandr Polukhin on 20.04.16.
//  Copyright © 2016 Alexandr Polukhin. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MyTableViewDataSource.h"
#import "OnlyIntegerValueFormatter.h"


@interface MyModalViewController : NSViewController <NSWindowDelegate>
{
    
//    IBOutlet NSTextField *nameTextField;
//    IBOutlet NSTextField *priceTextField;
//    IBOutlet NSTextField *weightTextField;

    IBOutlet NSTextField *nameTextField;
    IBOutlet NSTextField *minutesTextField;
    IBOutlet NSTextField *secondsTextField;
    
    
}
//@property NSTextField *nameTextField;
//@property NSTextField *priceTextField;
//@property NSTextField *weightTextField;

@property NSTextField *nameTextField;
@property NSTextField *minutesTextField;
@property NSTextField *secondsTextField;


//- (IBAction)saveButtonClick:(id)sender;
//- (IBAction)cancelButtonClick:(id)sender;

- (IBAction)doneButtonClick:(id)sender;
- (IBAction)cancelButtonClick:(id)sender;





@end
