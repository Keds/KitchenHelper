//
//  buttonArray.h
//  KitchenHelper
//
//  Created by Kate A. on 6/19/12.
//  Copyright (c) 2012 Kedsuda Apichonbancha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ButtonArray : NSObject

@property (nonatomic, retain)NSMutableArray *unitButtonArray;
@property (nonatomic, retain)NSMutableArray *quantityButtonArray;

- (NSMutableArray *)creatUnitArrayWithButtonWidth:(CGFloat) buttonWidth buttonHeight:(CGFloat)buttonHeight;
- (NSMutableArray *)createQuantityButtonArrayWithButtonWidth:(CGFloat)buttonWidth buttonHeight:(CGFloat)buttonHeight totalButtons:(NSInteger)total;

@end
