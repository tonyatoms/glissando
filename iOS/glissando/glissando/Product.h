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
@property (nonatomic, copy, readonly) NSNumber *margin;
@property (nonatomic) float sellersBasePrice;
@property (nonatomic, copy, readonly) NSNumber *adjustedPrice;


- (NSString*)adjustedPriceFromSellersBasePrice:(float)sellersBasePrice markup:(float)markup andUserFactor:(int)userFactor;

@end
