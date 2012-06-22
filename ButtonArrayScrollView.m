//
//  ButtonArrayScrollView.m
//  KitchenHelper
//
//  Created by Kate A. on 6/19/12.
//  Copyright (c) 2012 Kedsuda Apichonbancha. All rights reserved.
//

#import "ButtonArrayScrollView.h"


@interface ButtonArrayScrollView ()

- (NSString *)quantityLabel:(int)index;
- (UIColor *)titleColor;


@end


@implementation ButtonArrayScrollView


@synthesize quantityButtonArray = _quantityButtonArray;
@synthesize unitButtonArray = _unitButtonArray;



- (NSMutableArray *)createQuantityButtonArrayWithButtonWidth:(CGFloat)buttonWidth buttonHeight:(CGFloat)buttonHeight totalButtons:(NSInteger)total 
{
    
    NSMutableArray *quantityButtonArray = [[NSMutableArray alloc] initWithCapacity: total];
    
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
        
        [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [btn setTitleColor:[self titleColor] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15.0]];
        
        [self.unitButtonArray addObject:btn];
        
    }
    return self.unitButtonArray;
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


- (void)setupPropertyToScrollView
{
    [self setScrollEnabled:YES];
    
    self.showsVerticalScrollIndicator = FALSE;
    self.showsHorizontalScrollIndicator = FALSE;
    self.bounces = YES;
    
    //quantityScrollView.delegate = self;
}


- (void)addButtonArrayToSubview:(NSMutableArray *)buttonArrayType
{
    float totalButtonWidth = 0;
    
    for (int i = 0; i < buttonArrayType.count; i++) 
    {
        UIButton *btn = [buttonArrayType objectAtIndex:i];
        
        // Move the buttons position in the x-demension (horizontal).
        CGRect btnRect = btn.frame;
        btnRect.origin.x = totalButtonWidth;
        [btn setFrame:btnRect];
        
        // Add the button to the scrollview
        [self addSubview:btn];
        
        // Add the width of the button to the total width.
        totalButtonWidth += btn.frame.size.width;
    }
}


- (void)buildQuantityScrollViewWithButtonWidth:(CGFloat)buttonWidth buttonHeight:(CGFloat)buttonHeight totalButtons:(NSInteger)total {

    [self setupPropertyToScrollView];

////////////////////////////////////////////////////    
//    ButtonArray *quantityButtons = [[ButtonArray alloc] init];
//    self.quantityButtonArray = [quantityButtons createQuantityButtonArrayWithButtonWidth:kButtonWidth buttonHeight:kButtonHeight totalButtons:kTotalQuantityButtons];

    self.quantityButtonArray = [self createQuantityButtonArrayWithButtonWidth:buttonWidth buttonHeight:buttonHeight totalButtons:total];
    
    [self addButtonArrayToSubview: self.quantityButtonArray];
       
    [self setContentSize:CGSizeMake( ((total - 1) * buttonWidth) + kScrollWidth, kScrollHeight)];
}


- (void)buildUnitScrollViewWithButtonWidth:(CGFloat)buttonWidth buttonHeight:(CGFloat)buttonHeight
{
    [self setupPropertyToScrollView];
        
//    ButtonArrayScrollView *unitButtons = [[ButtonArrayScrollView alloc] init];
//    self.unitButtonArray = [unitButtons creatUnitArrayWithButtonWidth: buttonWidth buttonHeight:kButtonHeight];
        
    [self creatUnitArrayWithButtonWidth: buttonWidth buttonHeight:buttonHeight];
    
    [self addButtonArrayToSubview: self.unitButtonArray];
    
    [self setContentSize:CGSizeMake((([self.unitButtonArray count]*buttonWidth) - buttonWidth + kScrollWidth), kScrollHeight)];
}


@end






