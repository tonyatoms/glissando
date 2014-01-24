//
// JSONLoader.m
// Glissando
//

#import "JSONLoader.h"
#import "iTunesItem.h"

@implementation JSONLoader

- (NSArray *)itemsFromJSONFetch:(NSURL *)url withKey:(NSString*)key {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                         timeoutInterval:30.0];	
    NSURLResponse *response;
    
	NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSMutableArray *products = [[NSMutableArray alloc] init];

    NSArray *array = [jsonDictionary objectForKey:key];
 
    for(NSDictionary *dict in array) {

        iTunesItem *itunesItem = [[iTunesItem alloc] initWithJSONDictionary:dict];

        [products addObject:itunesItem];
    }
    
    return products;
}


@end
