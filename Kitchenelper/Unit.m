//
//  Unit.m
//  KitchenHelper
//

#import "Unit.h"

static NSDictionary *CONVERSION() {
    static NSDictionary *conversion = nil;
    if (conversion == nil) {
        conversion = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                      [NSNumber numberWithFloat:1.0], MILLILITER, 
                      [NSNumber numberWithFloat:5.0],TEASPOON,
                      [NSNumber numberWithFloat:14.7867648], TABLESPOON, 
                      [NSNumber numberWithFloat:29.57353], FLUID_OUNCE,
                      [NSNumber numberWithFloat:236.5882375], CUP, 
                      [NSNumber numberWithFloat:473.176], PINT,
                      [NSNumber numberWithFloat:946.3529], QUART, 
                      [NSNumber numberWithFloat:1000.0], LITER,
                      [NSNumber numberWithFloat:3785.41178], GALLON,
                      nil];
    }
    return conversion;
}

@interface Unit()

@property (nonatomic, strong) NSString *unit;
- (BOOL)isPlural;

@end

@implementation Unit
@synthesize amount=_amount;
@synthesize unit=_unit;

+ (Unit *)unitFrom:(NSString *)unit amount:(float)amount
{
    Unit *object = [[Unit alloc] init];
    object.amount = [NSNumber numberWithFloat:amount];
    object.unit = unit;
    return object;
}

- (float)amountIn:(NSString *)targetUnit
{
    NSNumber *conversionToMilliliter = [CONVERSION() objectForKey:self.unit];
    NSNumber *conversionFromMilliliter = [CONVERSION() objectForKey:targetUnit];
    return [self.amount floatValue] * [conversionToMilliliter floatValue] / [conversionFromMilliliter floatValue];
}

- (NSString *)formattedAmount
{
    float floatAmount = [self.amount floatValue];
    NSString *amountString = [NSString stringWithFormat:@"%.4f", floatAmount];
    if ([amountString hasSuffix:@".0000"]) {
        amountString = [NSString stringWithFormat:@"%.0f", floatAmount];
    }
    return amountString;
}

- (NSString *)description
{
    NSString *plural = [self isPlural] ? @"" : @"s";
    return [NSString stringWithFormat:@"%@ %@%@",  [self formattedAmount], self.unit, plural];
}

- (BOOL)isPlural
{
    float floatAmount = [self.amount floatValue];
    return !floatAmount == 0 && !floatAmount == 1;
}

@end
