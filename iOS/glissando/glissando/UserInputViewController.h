//
//  UserInputViewController.h
//  glissando
//
//  Created by tony atoms on 1/17/14.

//

#import <UIKit/UIKit.h>

@interface UserInputViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *errorLabel;
@property (strong, nonatomic) IBOutlet UIButton *userInputDoneButton;

@end
