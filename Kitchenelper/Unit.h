//
//  MilliliterUnit.h
//  KitchenHelper
//
#import <Foundation/Foundation.h>

#define MILLILITER  @"Milliliter"
#define TEASPOON    @"Teaspoon"
#define TABLESPOON  @"Tablespoon"
#define FLUID_OUNCE @"Fluid Ounce"
#define CUP         @"Cup"
#define PINT        @"Pint"
#define QUART       @"Quart"
#define LITER       @"Liter"
#define GALLON      @"Gallon"

@interface Unit : NSObject 

@property (nonatomic, strong) NSNumber *amount;

+ (Unit *)unitFrom:(NSString *)unit amount:(float)amount;
- (float)amountIn:(NSString *)unit;
- (NSString *)description;
- (NSString *)formattedAmount;
@end
