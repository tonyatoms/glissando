//
//  ViewController.h
//  glissando
//
//  Created by Tony Adams on 1/17/14.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "UserModel.h"
#import  "GlissandoConstants.h"  
#import "ResultsTableViewController.h"

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIButton *findButton;
@property (strong, nonatomic) IBOutlet UITextField *productSearchField;
@property (strong, nonatomic) IBOutlet UILabel *humanReadableLabel;
@property (strong, nonatomic) IBOutlet UILabel *JSONSummaryLabel;
@property (strong, nonatomic) IBOutlet UILabel *sellersBasePriceLabel;
@property (strong, atomic) Product *product;
@property (strong, atomic) UserModel *userModel;
@property (strong, atomic) ResultsTableViewController *resultsTableViewController;

@end
