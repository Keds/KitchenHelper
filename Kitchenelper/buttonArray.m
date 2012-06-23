//
//  buttonArray.m
//  KitchenHelper
//
//  Created by Kate A. on 6/19/12.
//  Copyright (c) 2012 Kedsuda Apichonbancha. All rights reserved.
//

#import "ButtonArray.h"

@interface ButtonArray()

- (NSString *)quantityLabel:(int)index;
- (UIColor *)titleColor;

@end

@implementation ButtonArray

#define MILLILITER @"Milliliter"
#define TEASPOON @"Teaspoon"
#define TABLESPOON @"Tablespoon"
#define FLUID_OUNCE @"Fluid Ounce"
#define CUP @"Cup"
#define PINT @"Pint"
#define QUART @"Quart"
#define LITER @"Liter"
#define GALLON @"Gallon"



@synthesize unitButtonArray;
@synthesize quantityButtonArray;


- (NSMutableArray *)createQuantityButtonArrayWithButtonWidth:(CGFloat)buttonWidth buttonHeight:(CGFloat)buttonHeight totalButtons:(NSInteger)total 
{
    
    self.quantityButtonArray = [[NSMutableArray alloc] initWithCapacity: total];
    
    for (int i = 0; i < total; i++) 
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        
        [btn setFrame:CGRectMake(0.0f, 0.0f, buttonWidth, buttonHeight)];
        
        [btn setTitle:[self quantityLabel:i] forState:UIControlStateNormal];
        [btn setTitleColor:[self titleColor] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18.0]];
        btn.userInteractionEnabled = NO;
        
        [quantityButtonArray addObject:btn];
    }
    return quantityButtonArray;
}



- (NSMutableArray *)creatUnitArrayWithButtonWidth:(CGFloat) buttonWidth buttonHeight:(CGFloat)buttonHeight
{
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:MILLILITER, TEASPOON, TABLESPOON,
                             FLUID_OUNCE, CUP, PINT, QUART, LITER, GALLON, nil];
    
    self.unitButtonArray = [NSMutableArray arrayWithCapacity:array.count];
    
    for (int i = 0 ; i < array.count; i++) 
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [btn setFrame:CGRectMake(0.0f, 0.0f, buttonWidth, buttonHeight)];
        
        NSString *btnTitle = [NSString stringWithFormat:@"%@",[array objectAtIndex:i]];
        
        [btn setTitle:btnTitle forState:UIControlStateNormal];
        btn.userInteractionEnabled = NO;
    //    [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [btn setTitleColor:[self titleColor] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15.0]];
                
        [unitButtonArray addObject:btn];
        
    }
    return unitButtonArray;
}


- (NSString *)quantityLabel:(int)index
{
    /* 0 = 0, 1 = 1/4, 2 = 1/3, 3 = 1/2, 4 = 2/3, 5 = 3/4  */
    /* index % 6 */
    /* 1, 1.5 2 2.5 ... */
    NSString *result = [NSString stringWithFormat:@"%d", index/6];
    NSString *suffix;
    switch (index % 6) {
        case 0:
            suffix = @""; break; // 0
        case 1:
            suffix = @" \u00BC"; break; // 1/4
        case 2:
            suffix = @" \u2153"; break; // 1/3
        case 3:
            suffix = @" \u00BD"; break; // 1/2
        case 4:
            suffix = @" \u2154"; break; // 2/3
        case 5:
            suffix = @" \u00BE"; break; // 3/4
    }
    
    if (index > 0 && index < 6) 
    {
        result = @"";
    }
    return [result stringByAppendingFormat:suffix];
}


- (UIColor *)titleColor {
    return [UIColor colorWithRed:68.0/255.0 green:152.0/255.0 blue:180.0/255.0 alpha:1.0];
}




@end
