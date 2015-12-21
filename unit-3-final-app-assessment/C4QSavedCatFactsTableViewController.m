//
//  C4QSavedCatFactsTableViewController.m
//  unit-3-final-app-assessment
//
//  Created by Ayuna Vogel on 12/19/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QSavedCatFactsTableViewController.h"
#import "C4QCatFactTableViewCell.h"
#import "C4QCatFactsDetailViewController.h"

#define savedCatFactsKey @"savedFacts"

@interface C4QSavedCatFactsTableViewController ()

@property (nonatomic) NSMutableArray *savedCatFacts;

@end

@implementation C4QSavedCatFactsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupUI];
    
    NSArray *savedFacts = [[NSUserDefaults standardUserDefaults] objectForKey:savedCatFactsKey];
    self.savedCatFacts = [NSMutableArray arrayWithArray:savedFacts];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)doneButtonTapped:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

# pragma mark - UI

- (void)setupUI {
    [self.navigationController.navigationBar setTintColor:[UIColor orangeColor]];
    self.navigationController.navigationBarHidden = NO;
}

// http://stackoverflow.com/questions/9827126/change-the-uitableviewcell-height-according-to-amount-of-text

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.savedCatFacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SavedCatFactsCellIdentifier" forIndexPath:indexPath];
 
    cell.textLabel.text = self.savedCatFacts[indexPath.row];
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    if ([segue.identifier isEqualToString:@"C4QSavedCatFactsToDetailVCSegueIdentifier"]) {
        C4QCatFactsDetailViewController *detailVC = segue.destinationViewController;
        detailVC.catFact = self.savedCatFacts[indexPath.row];
    }
}

#pragma mark - delete row 

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
  
        [self.savedCatFacts removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:savedCatFactsKey];
        [[NSUserDefaults standardUserDefaults] setObject:self.savedCatFacts forKey:savedCatFactsKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
