//
//  Product.h
// Glissando
//


@interface Product :  NSObject

@property (nonatomic, copy, readonly) NSString *features;
@property (nonatomic, copy, readonly) NSNumber *ID;
@property (nonatomic, copy, readonly) NSNumber *lat;
@property (nonatomic, copy, readonly) NSNumber *lng;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSNumber *MSRP;
@property (nonatomic, copy, readonly) NSNumber *adjustedPrice;



@end
