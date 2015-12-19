//
//  C4QSavedCatFactsTableViewController.m
//  unit-3-final-app-assessment
//
//  Created by Ayuna Vogel on 12/19/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QSavedCatFactsTableViewController.h"
#import "C4QCatFactTableViewCell.h"

@interface C4QSavedCatFactsTableViewController ()

@property (nonatomic) NSMutableArray *savedCatFacts;

@end

@implementation C4QSavedCatFactsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"C4QCatFactTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"C4QCatFactCustomTableViewCellIdentifier"];
    
    self.tableView.estimatedRowHeight = 44.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
  
    self.navigationItem.title = @"Saved Cat Facts";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    
    self.savedCatFacts = [[NSMutableArray alloc] init];
    
    self.savedCatFacts = [[NSUserDefaults standardUserDefaults] objectForKey:@"savedCatFactsArray"];
    

//    [self.navigationController.navigationBar setTintColor:[UIColor orangeColor]];
//    self.navigationController.navigationItem.title = @"Saved Cat Facts";
}

- (void)done {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.savedCatFacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    C4QCatFactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"C4QCatFactCustomTableViewCellIdentifier" forIndexPath:indexPath];
 
    cell.textLabel.text = self.savedCatFacts[indexPath.row];
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
