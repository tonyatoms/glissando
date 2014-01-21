//
//  Product.m
// Glissando
//


#import "Product.h"
#import "GlissandoConstants.h"

@implementation Product

// This is just here for future reference.
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"features" : @"Features",
             @"ID": @"Id",
             @"lat" : @"Lat",
             @"lng" : @"Long",
             @"name" : @"Name",
             @"margin" : @"Margin",
             @"sellersBasePrice" : @"Sellers Base Price",
             @"adjustedPrice" : @"Adjusted Price"
             };
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"<%@: %p, ID: %@, name: %@, adjusted price: %@>", NSStringFromClass([self class]), self, self.ID, self.name, self.adjustedPrice];
}

-(id)init {
    if (self = [super init])  {
        self.sellersBasePrice = 10.00; // just for testing until we hook up to real (or sufficiently pretend) products
    }
    return self;
}

- (NSString*)adjustedPriceFromSellersBasePrice:(float)sellersBasePrice markup:(float)markup andUserFactor:(int)userFactor {
    
    if (!markup) {
    
        markup = 50; // just a sheer guess - and probably way high for most items even digital ones?
    }
    
    if (sellersBasePrice) {
    
        // This could be refactored at some point, but keeping the steps separate here for clarity and
        // ease of tweaking while in development.

        float preMarkupPrice = sellersBasePrice - (sellersBasePrice * (markup/100));
        
        float markupPortion = sellersBasePrice - preMarkupPrice;
        
        float userFactorAsPercentage = (userFactor * 0.01);
        
        float adjustedMargin = markupPortion * userFactorAsPercentage;
        
        float adjustedPrice = preMarkupPrice + adjustedMargin;

        NSLog(@"userFactor    : %d ",userFactor);
        NSLog(@"userFactorAsPercentage: %f ",userFactorAsPercentage);
        NSLog(@"premarkupprice: %f ",preMarkupPrice);
        NSLog(@"markup portion: %f ",markupPortion);
        NSLog(@"adjustedMargin: %f ",adjustedMargin); // for mid earners should be 50% of markup portion and 10% for
        NSLog(@"adjustedPrice : %f ",adjustedPrice);  // those with AGI < threshold (currently an arbitrary 36k) 
        
        return [NSString stringWithFormat:@"$%.2f", adjustedPrice ];
 
    }
    else {
    
         return @"sorry, this app cannot calculate a price without at least an MSRP";
    }
}

- (NSString*)productSearchWithSearchString:(NSString*)search {


    NSURL *searchURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&limit=5", search]];
    
    NSLog(@"searchURL: %@", searchURL );
    
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:
                        searchURL];
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
    });
      
    //TODO:
    NSError* error;
    
    return [NSString stringWithContentsOfURL:searchURL encoding:NSASCIIStringEncoding error:&error];

}
- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    
 //   NSArray* latestLoans = [json objectForKey:@"loans"]; //2
    
    NSLog(@"json: %@", json); //3
    
    
}


@end
