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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //TODO: if a value(s) in defaults, prepopulate the relevant fields
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    NSLog(@"textFieldShouldReturn: %@", textField.text );
    
    [textField resignFirstResponder];
    
    return YES;
}


-(void)textFieldDidEndEditing:(UITextField *)textField {

      NSLog(@"textFieldDidEndEditing: %@", textField.text );
    

    
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    NSLog(@"textFieldShouldEND EDITING?   VALIDATE HERE: %@", textField.text );
    
    if (textField.tag == 1) {
        
        if ([self validateInput:textField.text]) {
            
            return YES;
        } else{
        
            textField.rightViewMode = UITextFieldViewModeWhileEditing;
        
        }
    }
    
    return NO;
}

-(BOOL)validateInput:(NSString*)inputText {

    
    if (inputText.length < 1) {

        [self showValidationAlert:nil];
        
        return NO;
        
    }
    
    NSScanner *scan = [NSScanner scannerWithString:inputText];
    
    if (![scan scanInt:NULL] || ![scan isAtEnd]) {
        NSLog (@"string exist like 'abbc','12ww','1.5w',' 5 ' etc");
        
        [self showValidationAlert:nil];
    } else  if ([inputText intValue] < 1) {
        
        NSLog (@"string is a negative number");
        
        [self showValidationAlert:kNegativeNumberErrorMessage];
    
    }
    else {
        
        [self addUserDataToStore:[inputText integerValue]];
        
        NSLog (@"only numeric value like '12','12.5','1.5' etc");
        
        [self animateView:self.userInputDoneButton WithAlpha:1.0];
        
        self.userInputDoneButton.userInteractionEnabled = YES;
        
        return YES;
    }
    
    return NO;
}

-(void)showValidationAlert:(NSString*)errorMessage {

    
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


-(void)addUserDataToStore:(int)inputInt {
    
    
    NSDictionary *inputDict = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithInt:inputInt], @"AdjustedGrossIncome",
                               nil];
                               
    //TODO: convert input data dictionary to NSData
    
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

-(void)animateView:(UIView*)view WithAlpha:(float)targetAlpha {

    [UIView animateWithDuration:0.5
                 animations:^{
                     view.alpha = targetAlpha;
                 }
                 completion:^(BOOL finished){
                     
                 }];
}
@end
