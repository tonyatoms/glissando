//
//  GlissandoConstants.h
//  glissando
//
//  Created by tony atoms on 1/18/14.
//

#import <Foundation/Foundation.h>

@interface GlissandoConstants : NSObject

extern NSString *const kNegativeNumberErrorMessage;
extern NSString *const kWholeNumberErrorMessage;
extern NSString *const kSearchCompleteNotification;

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define kFgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)

@end
