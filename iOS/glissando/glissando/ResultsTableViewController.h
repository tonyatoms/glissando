//
//  ResultsTableViewController.h
//  glissando
//
//  Created by Tony Adams on 1/22/14.
//  Copyright (c) 2014 atoms.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface ResultsTableViewController : UITableViewController <UITableViewDataSource>

@property (strong, nonatomic) NSArray *iTunesResultsArray;
@property (strong, nonatomic) NSDictionary *iTunesResultsDictionary;
@property (strong, nonatomic) NSArray *finishedITunesResultsArray;
@property (strong, nonatomic) NSString *searchString;
@property (strong, atomic) Product *product;

@end
