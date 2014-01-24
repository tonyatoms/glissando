//
//  JSONLoader.h
// Glissando
//

#import <Foundation/Foundation.h>

@interface JSONLoader : NSObject

- (NSArray *)itemsFromJSONFetch:(NSURL *)url withKey:(NSString*)key;

@end
