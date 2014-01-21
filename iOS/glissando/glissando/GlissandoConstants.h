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

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@end
