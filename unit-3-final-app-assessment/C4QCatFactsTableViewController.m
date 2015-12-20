//
//  C4QCatsTableViewController.m
//  unit-3-final-assessment
//
//  Created by Michael Kavouras on 12/17/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QCatFactsTableViewController.h"
#import "C4QCatFactTableViewCell.h"
#import "C4QSavedCatFactsTableViewController.h"
#import "C4QCatFactsDetailViewController.h"

#define CAT_API_URL @"http://catfacts-api.appspot.com/api/facts?number=100"

@interface C4QCatFactsTableViewController ()

@property (nonatomic) NSMutableArray *catFacts;

@end

@implementation C4QCatFactsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self populateTableViewWithData];
}

# pragma mark - UI

- (void)setupUI {
    UINib *nib = [UINib nibWithNibName:@"C4QCatFactTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"C4QCatFactCustomTableViewCellIdentifier"];
    
    self.tableView.estimatedRowHeight = 44.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.navigationController.navigationBar setTintColor:[UIColor orangeColor]];
}

# pragma mark - populate with data 

- (void)populateTableViewWithData {
    
    self.catFacts = [[NSMutableArray alloc]init];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:CAT_API_URL
      parameters:nil
        progress:^(NSProgress * _Nonnull downloadProgress)
    {
        NSLog(@"Loading cat facts data");
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *error;
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
        
        NSArray *facts = [jsonDictionary objectForKey:@"facts"];
        
        for (NSString *fact in facts) {
            [self.catFacts addObject:fact];
        }
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
}

- (IBAction)saveFact:(UIButton *)sender {
    
}

/*     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
 NSArray *savedFactsArray = @[];
 [defaults setObject:savedFactsArray forKey:@"savedFacts"];
 
 NSMutableArray *meowArr = [savedFactsArray mutableCopy];
 // [meowArr addObject:catsTableVC.tableView[indexPath.row]];
 [defaults synchronize];
*/

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.catFacts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    C4QCatFactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"C4QCatFactCustomTableViewCellIdentifier" forIndexPath:indexPath];
    
    cell.catFactLabel.text = self.catFacts[indexPath.row];
    
    cell.saveFactButton.tag = indexPath.row;
    [cell.saveFactButton addTarget:self action:@selector(saveFact:)
             forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    C4QCatFactsDetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"C4QCatFactsDetailVC"];
    detailVC.catFact = self.catFacts[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}


@end
