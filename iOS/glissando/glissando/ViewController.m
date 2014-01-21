//
//  ViewController.m
//  glissando
//
//  Created by Tony Adams on 1/17/14.
//

#import "ViewController.h"
#import "UserModel.h"
#import "UserInputViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

}
- (void)viewDidAppear:(BOOL)animated {
    
    NSDictionary* user;
    
    user = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"User"];
    
    if (user) {
       
        if ([user valueForKey:@"AdjustedGrossIncome"]) {
        
            NSNumber* AGI = [user valueForKey:@"AdjustedGrossIncome"];

            self.userModel = [[UserModel alloc] init];
            
            self.product = [[Product alloc] init];
            
            self.JSONSummaryLabel.text = [self calculatePriceWithAGI: [AGI floatValue ] andSellersBasePrice:self.product.sellersBasePrice];
            self.sellersBasePriceLabel.text =  [NSString stringWithFormat:@"$%.2f", self.product.sellersBasePrice ];
            

        } else {
        
            self.JSONSummaryLabel.text = @"enter yer details in my details";
        }
        
    }else { //TODO: this else will not be necessary 
        
        self.JSONSummaryLabel.text = @"enter yer detailses in my details";
        self.sellersBasePriceLabel.text =  @"";
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
   
    //TODO: validate input
    /*
    if (textField.tag == 1) {
        
        if ([self validateInput:textField.text]) {
            
            return YES;
        }
        else {
            
            textField.rightViewMode = UITextFieldViewModeWhileEditing;
        }
    }
    */
    NSLog(@"VC textFieldShouldEndEditing text: %@", textField.text);
    
    self.findButton.userInteractionEnabled = YES;
    
    //TODO: assuming valid
    
    [self displaySearchResults:textField.text];
    
    return YES;
}

-(void)displaySearchResults:(NSString*)search {
    
    [self.product productSearchWithSearchString:search  ];
}

// This is just a temporary calculation - many more factors will be taken into account.
- (NSString*)calculatePriceWithAGI:(float)AGI andSellersBasePrice:(float)price {

    //TODO: do the calculations in the price model, not here
    
    NSString* adjustedPrice;
    
    int userFactor = [self.userModel  userAdjustmentFactorFromAGI:AGI  ];
    
    if (price) {
        // in this example, we don't have margin information for the product
        adjustedPrice = [self.product  adjustedPriceFromSellersBasePrice:price markup:0.0f andUserFactor:userFactor];
        
    }

    return adjustedPrice;
}

// TODO: user can input a product query here - for now, the input panel is just showing one product as a placeholder.
- (IBAction)inputFindButtonAction:(id)sender {

    UIAlertView *obj_AlertView=[[UIAlertView alloc]initWithTitle:@""
                                                         message:@"Note that this app is for demonstraton purposes only. It is not possible to actually purchase anything through this app at this time."
                                                        delegate:self
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
    [obj_AlertView show];

}

- (void)showUserInputScreen {

    UserInputViewController *userInputViewController = [[UserInputViewController alloc]
                                                        init];
    
    // Create the navigation controller and present it.
    UINavigationController *navigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:userInputViewController];
    [self presentViewController:navigationController animated:YES completion: nil];

}
 
@end

