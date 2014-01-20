//
//  UserModel.m
// Glissando
//


#import "UserModel.h"

@implementation UserModel

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

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p, ID: %@, name: %@, AGI: %@    >", NSStringFromClass([self class]), self, self.ID, self.name, self.adjustedGrossIncome];
}

@end
