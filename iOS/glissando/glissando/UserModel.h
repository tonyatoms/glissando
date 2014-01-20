//
//  UserModel.h
// Glissando
//

@interface UserModel : NSObject

@property (nonatomic, copy, readonly) NSString *address1;
@property (nonatomic, copy, readonly) NSString *address2;
@property (nonatomic, copy, readonly) NSString *features;
@property (nonatomic, copy, readonly) NSNumber *ID;
@property (nonatomic, copy, readonly) NSNumber *lat;
@property (nonatomic, copy, readonly) NSNumber *lng;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSNumber *adjustedGrossIncome;

- (int)userAdjustmentFactorFromAGI:(float)adjustedGrossIncome;

@end
