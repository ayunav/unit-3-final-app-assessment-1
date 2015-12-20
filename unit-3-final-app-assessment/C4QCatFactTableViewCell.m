//
//  C4QCatFactTableViewCell.m
//  unit-3-final-app-assessment
//
//  Created by Ayuna Vogel on 12/19/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QCatFactTableViewCell.h"
#import "C4QSavedCatFactsTableViewController.h"

#define savedCatFactsKey @"savedFacts"

@implementation C4QCatFactTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)saveFactButtonTapped:(id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults objectForKey:savedCatFactsKey]) {
        NSArray *catFactsArray = [[NSArray alloc]initWithObjects:self.myFavCatFact, nil];
        [defaults setObject:catFactsArray forKey:savedCatFactsKey];
    }
    
    NSArray *catFactsArray = [defaults objectForKey:savedCatFactsKey];
    
    NSMutableArray *meowArr = [catFactsArray mutableCopy];
    [meowArr addObject:self.myFavCatFact];
    
    NSArray *catFactsArrayToSave = [meowArr copy];
    [defaults setObject:catFactsArrayToSave forKey:savedCatFactsKey];
    
    [defaults synchronize];
    
    [self showAlert];
   
}

- (void)showAlert {
    
    UIAlertController *alert= [UIAlertController alertControllerWithTitle:@"Saved"
                                                                  message:@"New cat fact saved!"
                                                           preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK"
                                                 style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction *action) {

                                                   C4QSavedCatFactsTableViewController *savedFactsTVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SavedCatFactsTableVC"];
                                                   UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:savedFactsTVC];
                                                   [self.window.rootViewController presentViewController:navigationController animated:YES completion:^{}];
                                               }];
    
    [alert addAction:ok];

    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

@end
