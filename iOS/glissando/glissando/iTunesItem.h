//
//  iTunesItem.h
// Glissando
//

@interface iTunesItem :  NSObject

- (id)initWithJSONDictionary:(NSDictionary *)jsonDictionary;

@property (nonatomic, copy, readonly) NSString *artistName;
@property (nonatomic, copy, readonly) NSNumber *trackId;
@property (nonatomic, copy, readonly) NSNumber *trackPrice;
@property (nonatomic, copy, readonly) NSString *artworkUrl30;
@property (nonatomic, copy, readonly) NSString *trackName;


@end
