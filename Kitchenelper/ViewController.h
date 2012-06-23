//
//  ViewController.h
//  KitchenHelper
//
//  Created by Kate A. on 5/28/12.
//  Copyright (c) 2012 Kedsuda Apichonbancha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonArrayScrollView.h"

@interface ViewController : UIViewController <UIScrollViewDelegate>{
    

}

@property (weak, nonatomic) IBOutlet ButtonArrayScrollView *quantityScrollView;

@property (weak, nonatomic) IBOutlet ButtonArrayScrollView *menuFirstUnitScrollView;

@property (nonatomic, retain) IBOutlet ButtonArrayScrollView *menuSecondUnitScrollView;

@property (weak, nonatomic) IBOutlet UILabel *convertedQuantityLabel;
@property (nonatomic, retain) IBOutlet UILabel *unitFormulaLabel;

@property (nonatomic, retain) NSMutableArray *unitButtonArray;
@property (nonatomic, retain) NSMutableArray *quantityButtonArray;

@property (nonatomic, retain) NSString *backgroundString;

- (void)setViewBackground:(NSString *)imageFileName;
@end
