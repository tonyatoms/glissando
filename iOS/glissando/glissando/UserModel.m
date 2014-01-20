//
//  UserModel.m
// Glissando
//


#import "UserModel.h"

@implementation UserModel

// This is just here for future reference.
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"address1" : @"Addr1",
             @"address2" : @"Addr2",
             @"features" : @"Features",
             @"ID": @"Id",
             @"lat" : @"Lat",
             @"lng" : @"Long",
             @"name" : @"Name",
             @"adjustedGrossIncome" : @"AdjustedGrossIncome",
             };
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, ID: %@, name: %@, AGI: %@    >", NSStringFromClass([self class]), self, self.ID, self.name, self.adjustedGrossIncome];
}

- (int)userAdjustmentFactorFromAGI:(float)adjustedGrossIncome {
    
    int userFactor = 100;
    
    if (adjustedGrossIncome) {
        
        if ( (adjustedGrossIncome < 70000) && (adjustedGrossIncome > 36000) ) {

            //TODO: a real calculation of course
            userFactor = 50;
        }
        else if(adjustedGrossIncome < 36000) {
            
            userFactor = 10;
        }
    }
    
    return userFactor ;
}

@end
