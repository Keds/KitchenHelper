//
//  ViewController.h
//  Kitchenelper
//
//  Created by Kate A. on 5/28/12.
//  Copyright (c) 2012 Kedsuda Apichonbancha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIScrollViewDelegate>{
    

}

@property (weak, nonatomic) IBOutlet UIScrollView *quantityScrollView;

@property (weak, nonatomic) IBOutlet UIScrollView *menuFirstUnitScrollView;

@property (nonatomic, retain) IBOutlet UIScrollView *menuSecondUnitScrollView;

@property (weak, nonatomic) IBOutlet UILabel *convertedQuantityLabel;
@property (nonatomic, retain) IBOutlet UILabel *unitFormulaLabel;

@property (nonatomic, retain) NSMutableArray *unitButtonArray;
@property (nonatomic, retain) NSMutableArray *quantityButtonArray;

@end
