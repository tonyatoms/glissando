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

// Just before showing the ProductDetailViewController, set the selected Product object
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 
    //   ProductDetailViewController *vc = segue.destinationViewController;
  //  NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
 //   vc.product = [_products objectAtIndex:indexPath.row];
}


#pragma mark - Table View Controller Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"Cell";

    // works, but want to set style
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //experimental
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];

    
    iTunesItem *itunesItem = [_products objectAtIndex:indexPath.row];

    
   // NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"Using NSAttributed String"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"artist:%@",itunesItem.artistName ];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ price: $%@ adjustedPrice: %@", itunesItem.trackName, itunesItem.trackPrice, [self adjustedPriceFromBasePrice:itunesItem.trackPrice]                    ];
    
    
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize: 14.0];
    
    cell.detailTextLabel.font = [UIFont boldSystemFontOfSize: 12.0];
    
    //TODO: add lazy loading of artworkUrl30 via https://github.com/rs/SDWebImage or something like that
    //cell.imageView.image = [UIImage imageNamed:@"genericProduct.png"]; //artworkUrl30
    
    return cell;
}

// A fake reduction for working on the table output
-(NSString*)adjustedPriceFromBasePrice:(NSNumber *)basePrice {

    NSNumber *result = [ NSNumber numberWithFloat: [basePrice floatValue]  * 0.8 ];

    return [NSString stringWithFormat:@"$%.2f", [result floatValue] ];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_products count];
}
@end
