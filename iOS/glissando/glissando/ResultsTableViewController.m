//
//  ResultsTableViewController.m
//  glissando
//
//  Created by Tony Adams on 1/22/14.
//  Copyright (c) 2014 atoms.net. All rights reserved.
//

#import "ResultsTableViewController.h"
#import "iTunesItem.h"
#import "JSONLoader.h"

@interface ResultsTableViewController ()

@end

@implementation ResultsTableViewController {
    NSArray *_products;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    // 
    JSONLoader *jsonLoader = [[JSONLoader alloc] init];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@", self.searchString]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        _products = [jsonLoader itemsFromJSONFetch:url withKey:@"results"];
        // Now that we have the data, reload the table data on the main UI thread
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    });
}

// Just before showing the ProductDetailViewController, set the selected Location object
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 
    //   ProductDetailViewController *vc = segue.destinationViewController;
  //  NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
 //   vc.product = [_products objectAtIndex:indexPath.row];
}


#pragma mark - Table View Controller Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    iTunesItem *itunesItem = [_products objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"artist:%@ track:%@ price:%@ ",itunesItem.artistName, itunesItem.trackName, itunesItem.trackPrice  ];
    cell.detailTextLabel.text = itunesItem.trackName;
    
    //TODO: add lazy loading of artworkUrl30 via https://github.com/rs/SDWebImage or something like that
    //cell.imageView.image = [UIImage imageNamed:@"genericProduct.png"]; //artworkUrl30
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_products count];
}
@end
