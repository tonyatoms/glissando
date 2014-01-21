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
    
    float userFactor = 100;
    
    if (adjustedGrossIncome) {
        
        if(adjustedGrossIncome < 12000) { // somewhat arbitrary floor
        
            adjustedGrossIncome = 12000;
        }
        
        if (adjustedGrossIncome < 80000) { // somewhat arbitrary ceiling
            
            userFactor =  (adjustedGrossIncome / 80000) * 100;
        }
    }
    
    return [[NSNumber numberWithFloat:userFactor] intValue ];
}


@end
