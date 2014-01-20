//
//  ViewController.h
//  glissando
//
//  Created by Tony Adams on 1/17/14.
//  Copyright (c) 2014 AT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *humanReadableLabel;

@property (strong, nonatomic) IBOutlet UILabel *JSONSummaryLabel;
@property (strong, nonatomic) IBOutlet UIButton *inputWTFButton;
@property (nonatomic, copy) Product *product;

@end
