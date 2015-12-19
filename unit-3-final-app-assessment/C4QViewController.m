//
//  ViewController.m
//  unit-3-final-assessment
//
//  Created by Michael Kavouras on 11/30/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QViewController.h"

@interface C4QViewController ()

@property (weak, nonatomic) IBOutlet UIButton *onwardsButton;

@end

@implementation C4QViewController

- (void)didSelectColor:(UIColor *)color {
    self.view.backgroundColor = color;
    if (color == [UIColor greenColor]) {
        self.onwardsButton.hidden = NO; 
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"coloPickerSegueIdentifier"]) {
        C4QColorPickerViewController *colorPickerVC = segue.destinationViewController;
        colorPickerVC.delegate = self;
    }
}

@end

