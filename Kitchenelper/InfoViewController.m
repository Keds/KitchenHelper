//
//  Info_ViewControllerViewController.m
//  KitchenHelper
//
//  Created by Kate A. on 6/15/12.
//  Copyright (c) 2012 Kedsuda Apichonbancha. All rights reserved.
//


#import "ViewController.h"
#import "InfoViewController.h"

@interface InfoViewController ()
- (IBAction)firstBackgroundButton:(id)sender;
- (IBAction)secondBackgroundButton:(id)sender;
@end

@implementation InfoViewController

@synthesize backgroundString = _backgroundString;
@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
  //  [self setViewBackground:@"Background-Wood.jpg"];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma added_Methods


- (void)setViewBackground:(NSString *)imageFileName
{
    self.backgroundString = imageFileName;
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:imageFileName]]];
} 


- (void)setBackground:(NSString *)fileName
{
    [self setViewBackground:fileName];
    [self.delegate noifyBackgroundFileName:fileName];
}

- (IBAction)firstBackgroundButton:(id)sender 
{
    [self setBackground:@"Background-Wood.jpg"];
}


- (IBAction)secondBackgroundButton:(id)sender 
{
    [self setBackground:@"Background_Wood2.jpg"];
}

@end





