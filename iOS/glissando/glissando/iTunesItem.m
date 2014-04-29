//
//  iTunesItem.m
// Glissando
//

#import "iTunesItem.h"

@implementation iTunesItem

- (id)initWithJSONDictionary:(NSDictionary *)jsonDictionary {
 
    if(self = [self init]) {
        // Assign all properties with keyed values from the dictionary
        _artistName = [jsonDictionary objectForKey:@"artistName"];
        _trackId = [jsonDictionary objectForKey:@"trackId"];
        _trackPrice = [jsonDictionary objectForKey:@"trackPrice"];
        _artworkUrl30 = [jsonDictionary objectForKey:@"artworkUrl30"];
        _trackName = [jsonDictionary objectForKey:@"trackName"];
    }
    
    return self;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"<--trackID %@: trackPrice: %@, trackName: %@, artistName: %@>", self.trackId, self.trackPrice, self.trackName, self.artistName ];
}

@end
