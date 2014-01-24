//
//  Product.h
// Glissando
//


@interface Product :  NSObject

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSNumber *margin;
@property (nonatomic) float sellersBasePrice;
@property (nonatomic, copy, readonly) NSNumber *adjustedPrice;
@property (nonatomic) NSDictionary* jsonResult;
@property BOOL haveResults;

- (NSString*)adjustedPriceFromSellersBasePrice:(float)sellersBasePrice markup:(float)markup andUserFactor:(int)userFactor;

@end
