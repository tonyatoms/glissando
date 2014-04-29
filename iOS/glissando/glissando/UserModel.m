//
//  UserModel.m
// Glissando
//


#import "UserModel.h"

@implementation UserModel


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
