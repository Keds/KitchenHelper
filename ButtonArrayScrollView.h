//
//  ButtonArrayScrollView.h
//  KitchenHelper
//
//  Created by Kate A. on 6/19/12.
//  Copyright (c) 2012 Kedsuda Apichonbancha. All rights reserved.
//

#import <Foundation/Foundation.h>


#define MILLILITER @"Milliliter"
#define TEASPOON @"Teaspoon"
#define TABLESPOON @"Tablespoon"
#define FLUID_OUNCE @"Fluid Ounce"
#define CUP @"Cup"
#define PINT @"Pint"
#define QUART @"Quart"
#define LITER @"Liter"
#define GALLON @"Gallon"

#define kScrollWidth 300.0
#define kScrollHeight 50.0
#define kButtonWidth 50.0
#define kButtonHeight 50.0
#define kTotalQuantityButtons 61




@interface ButtonArrayScrollView : UIScrollView {
       
    
}


@property (nonatomic, retain)NSMutableArray *unitButtonArray;
@property (nonatomic, retain)NSMutableArray *quantityButtonArray;



- (void)buildQuantityScrollViewWithButtonWidth:(CGFloat)buttonWidth buttonHeight:(CGFloat)buttonHeight totalButtons:(NSInteger)total;

- (void)buildUnitScrollViewWithButtonWidth:(CGFloat)buttonWidth buttonHeight:(CGFloat)buttonHeight;


@end
