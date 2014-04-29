//
//  ResultsTableViewController.m
//  glissando
//
//  Created by Tony Adams on 1/22/14.
//  Copyright (c) 2014 atoms.net. All rights reserved.
//
/*
 ArtistCarianiArtist InfoItalian, 1485/1490 - 1547 or afterTitleA ConcertDatedc. 1518-1520Mediumoil on canvasClassificationPaintingDimensionsoverall: 92 x 130 cm (36 1/4 x 51 3/16 in.) framed: 128.8 x 168.1 x 6.4 cm (50 11/16 x 66 3/16 x 2 1/2 in.)CreditBequest of Lore Heinemann in memory of her husband, Dr. Rudolf J. HeinemannAccession No.1997.57.2DigitizationDirect Digital CaptureImage UseOpen Access
*/

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
   
 // no joy
 //   UIImageView *productImageView = (UIImageView *)[cell viewWithTag:100];
 //   productImageView.image = [UIImage imageNamed:@"noArtAvailable.jpg"];
    
 // works but underlays the text (if going this route everything will have to be customized?)
  //  UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 40, 64, 64)];
 //   imageView.image = [UIImage imageNamed:@"noArtAvailable.jpg"];
 //   [cell.contentView addSubview:imageView];
    
    
    cell.imageView.image = [UIImage imageNamed:@"noArtAvailable.jpg"];
    
    iTunesItem *itunesItem = [_products objectAtIndex:indexPath.row];
    
   // NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"Using NSAttributed String"];
    
    
    NSString *trackName;
    
    if (itunesItem.trackName) {
        trackName = itunesItem.trackName;
    } else {
    
        trackName = @"[untitled]";
    }
    cell.textLabel.font = [UIFont boldSystemFontOfSize: 12.0];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",itunesItem.artistName ];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ price: $%@ adjustedPrice: %@", trackName,
                                 [NSString stringWithFormat:@"%.2f", [itunesItem.trackPrice floatValue] ],
                                 [self adjustedPriceFromBasePrice:itunesItem.trackPrice]
                                 ];
    
    UILabel *artistNameLabel = (UILabel *)[cell viewWithTag:101];
    artistNameLabel.text = itunesItem.artistName;
    
    cell.detailTextLabel.font = [UIFont systemFontOfSize: 10.0];
    
    //TODO: add lazy loading of artworkUrl30 via https://github.com/rs/SDWebImage or something like that
    //cell.imageView.image = [UIImage imageNamed:@"genericProduct.png"]; //artworkUrl30
    
    return cell;
}

// A fake reduction for working on the table output
-(NSString*)adjustedPriceFromBasePrice:(NSNumber *)basePrice {
 
    NSNumber *result;
    
    if (basePrice > 0) {
    
        result = [ NSNumber numberWithFloat: [basePrice floatValue]  * 0.8 ];
    
    } else {
    
        result = [ NSNumber numberWithFloat: [basePrice floatValue]];
    }
    
    return [NSString stringWithFormat:@"$%.2f", [result floatValue] ];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_products count];
}
@end
