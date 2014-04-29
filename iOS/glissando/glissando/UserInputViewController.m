//
//  UserInputViewController.m
//  glissando
//
//  Created by tony atoms on 1/18/14.
//

#import "UserInputViewController.h"
#import "GlissandoConstants.h"

@interface UserInputViewController ()

@end

@implementation UserInputViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    if (textField.tag == 1) {
        
        if ([self validateInput:textField.text]) {
            
            return YES;
        }
        else {
        
            textField.rightViewMode = UITextFieldViewModeWhileEditing;
        }
    }
    return NO;
}

- (BOOL)validateInput:(NSString*)inputText {
    
    if (inputText.length < 1) {

        [self showValidationAlert:nil];
        
        return NO;
    }
    
    NSScanner *scan = [NSScanner scannerWithString:inputText];
    
    if (![scan scanInt:NULL] || ![scan isAtEnd]) {
        
        [self showValidationAlert:nil];
        
    } else  if ([inputText intValue] < 1) {
        
        [self showValidationAlert:kNegativeNumberErrorMessage];
    
    }
    else {
        
        [self addUserDataToStore:[inputText integerValue]];
    
        [self animateView:self.userInputDoneButton WithAlpha:1.0];
        
        self.userInputDoneButton.userInteractionEnabled = YES;
        
        return YES;
    }

    return NO;
}

- (void)showValidationAlert:(NSString*)errorMessage {

    
    if (!errorMessage) {
        errorMessage = kWholeNumberErrorMessage;
    }
    
    UIAlertView *obj_AlertView=[[UIAlertView alloc]initWithTitle:@""
        message:errorMessage
        delegate:self
        cancelButtonTitle:@"OK"
        otherButtonTitles:nil];
    
    [obj_AlertView show];

}

- (void)addUserDataToStore:(int)inputInt {
    
    NSDictionary *inputDict = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithInt:inputInt], @"AdjustedGrossIncome",
                               nil];
    
    NSData *inputData = [NSKeyedArchiver archivedDataWithRootObject:inputDict];
    
    NSError *error;
    
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:inputData options:NSJSONReadingMutableContainers error:&error];
    
    if (result) {
        [[NSUserDefaults standardUserDefaults] setObject:result forKey:@"User"];
   
    }else {
        [[NSUserDefaults standardUserDefaults] setObject:inputDict forKey:@"User"];
        NSLog(@"UIVC addUserDataToStore NO RESULT %@ ", error);
        NSLog(@"UIVC addUserDataToStore inputDict %@ ", inputDict);
        
    }
}

- (void)animateView:(UIView*)view WithAlpha:(float)targetAlpha {

    [UIView animateWithDuration:0.5
                 animations:^{
                     view.alpha = targetAlpha;
                 }
                 completion:^(BOOL finished){
                     
                 }];
}

@end
