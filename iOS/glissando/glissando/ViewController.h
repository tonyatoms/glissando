//
//  ViewController.h
//  glissando
//
//  Created by Tony Adams on 1/17/14.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "UserModel.h"

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *humanReadableLabel;
@property (strong, nonatomic) IBOutlet UILabel *JSONSummaryLabel;
@property (strong, nonatomic) IBOutlet UILabel *sellersBasePriceLabel;
@property (strong, nonatomic) IBOutlet UIButton *inputWTFButton;
@property (strong, atomic) Product *product;
@property (strong, atomic) UserModel *userModel;

@end
