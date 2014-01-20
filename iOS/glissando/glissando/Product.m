//
//  Product.m
// Glissando
//


#import "Product.h"

@implementation Product

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"features" : @"Features",
             @"ID": @"Id",
             @"lat" : @"Lat",
             @"lng" : @"Long",
             @"name" : @"Name",
             @"open24HrsToday" : @"Open24HrsToday",
             @"openNow" : @"OpenNow",
             @"msrp" : @"MSRP",
             @"adjustedPrice" : @"adjustedPrice"
             };
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p, ID: %@, name: %@>", NSStringFromClass([self class]), self, self.ID, self.name];
}

@end
