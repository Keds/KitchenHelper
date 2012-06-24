//
//  InfoViewController.h
//  KitchenHelper
//
//  Created by Kate A. on 6/15/12.
//  Copyright (c) 2012 Kedsuda Apichonbancha. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InfoViewDelegate <NSObject>

- (void)noifyBackgroundFileName:(NSString *)fileName;

@end

@interface InfoViewController : UIViewController

@property (nonatomic, strong) NSString *backgroundString;
@property (nonatomic, weak) id<InfoViewDelegate> delegate;
@end

