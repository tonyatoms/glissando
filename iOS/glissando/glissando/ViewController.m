//
//  ViewController.m
//  glissando
//
//  Created by Tony Adams on 1/17/14.
//


#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1

#define kLatestKivaLoansURL [NSURL URLWithString:@"http://api.kivaws.org/v1/loans/search.json?status=fundraising"] //2

#import "ViewController.h"

#import "UserModel.h"
#import "UserInputViewController.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    /*
    //example from wonderlich tutorial - works great, but no need to keep
    // tormenting poor kiva
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:
                        kLatestKivaLoansURL];
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
    });
    */
}
-(void)viewDidAppear:(BOOL)animated{

    
    //TODO: see if we hava a user with an AGI stored already
    // IF NOT show the user data input screen
    
    NSDictionary* user;
    
    user = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"User"];
    
    if (user) {
       
        if ([user valueForKey:@"AdjustedGrossIncome"]) {
        
            NSNumber* AGI = [user valueForKey:@"AdjustedGrossIncome"];
            
            
            self.JSONSummaryLabel.text = [self calculatePriceWithAGI:AGI andProductPrice:0.0];
            
            self.product = [[Product alloc] init];
            
            
        } else {
        
            self.JSONSummaryLabel.text = @"enter yer details in my details";
        }
        
        
        NSLog(@"VC viewDidAppear THERE IS A User in NSUserDefaults ##########  %@", user);
        
 
        
    }else { //TODO: this else will not be necessary 
        
        self.JSONSummaryLabel.text = @"enter yer detailses in my details";
    }
    
     NSLog(@"VC viewDidAppear ---------------");
}

// This is just a temporary calculation - many more factors will be taken into account.
//
-(NSString*)calculatePriceWithAGI:(NSNumber*)AGI andProductPrice:(double)price {

    //TODO: do the calculations in the price model, not here
    
    if (!price) {
        
        price = 10.00;
    }
    
    if (AGI > [NSNumber numberWithDouble: 50000] ) {
        
        price = price;
    } else {
    
        price *=  0.8;
    }
    
    NSString *output = [NSString stringWithFormat:@"$%f ", price ];
    
    return output;
}

// TODO: user can input a product query here - for now, the input panel is just showing one product as a placeholder.
-(IBAction)inputWTFButtonAction:(id)sender {

    UIAlertView *obj_AlertView=[[UIAlertView alloc]initWithTitle:@""
                                                         message:@"uh, you can't actually pick a product yet. Enjoy the Abba record!"
                                                        delegate:self
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
    [obj_AlertView show];


}

-(void)showUserInputScreen {

    UserInputViewController *userInputViewController = [[UserInputViewController alloc]
                                                        init];
    
    // Create the navigation controller and present it.
    UINavigationController *navigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:userInputViewController];
    [self presentViewController:navigationController animated:YES completion: nil];

}


- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    
    NSArray* latestLoans = [json objectForKey:@"loans"]; //2
    
    //NSLog(@"loans: %@", latestLoans); //3

    // 1) Get the latest loan
    NSDictionary* loan = [latestLoans objectAtIndex:0];
    
    // 2) Get the funded amount and loan amount
    NSNumber* fundedAmount = [loan objectForKey:@"funded_amount"];
    NSNumber* loanAmount = [loan objectForKey:@"loan_amount"];
    float outstandingAmount = [loanAmount floatValue] -
    [fundedAmount floatValue];
    
    // 3) Set the label appropriately
    self.humanReadableLabel.text = [NSString stringWithFormat:@"Latest loan: %@ from %@ needs another $%.2f to pursue their entrepreneural dream",
                         [loan objectForKey:@"name"],
                         [(NSDictionary*)[loan objectForKey:@"location"]
                          objectForKey:@"country"],
                         outstandingAmount];

    //build an info object and convert to json
    NSDictionary* info = [NSDictionary dictionaryWithObjectsAndKeys:
                          [loan objectForKey:@"name"],
                          @"who",
                          [(NSDictionary*)[loan objectForKey:@"location"]
                           objectForKey:@"country"],
                          @"where",
                          [NSNumber numberWithFloat: outstandingAmount],
                          @"what",
                          nil];
    
    //convert object to data
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:info 
                                                       options:NSJSONWritingPrettyPrinted error:&error];

    //print out the data contents
    self.JSONSummaryLabel.text = [[NSString alloc] initWithData:jsonData
                                             encoding:NSUTF8StringEncoding];
    
}

@end

