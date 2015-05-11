//
//  InterfaceController.m
//  FirstWatchApp WatchKit Extension
//
//  Created by zhangjie on 15/4/30.
//  Copyright (c) 2015年 stack. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *label;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *clickButton;

@property (strong, nonatomic) WKInterfaceImage *image;
@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
    self.label.text = @"hello world";
    
    NSArray* initialPhrases = @[@"Let's do lunch.", @"Can we meet tomorrow?", @"When are you free?"];
    [self presentTextInputControllerWithSuggestions:initialPhrases
                                   allowedInputMode:WKTextInputModeAllowAnimatedEmoji
                                         completion:^(NSArray *results) {
                                             if (results && results.count > 0) {
                                                 id aResult = [results objectAtIndex:0];
                                                 // Use the string or image.
                                             }
                                             else {
                                                 // Nothing was selected.
                                             }
                                         }];

}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}
- (IBAction)clickButtonClick
{
    self.label.text = @"hello world ++";
}

@end



