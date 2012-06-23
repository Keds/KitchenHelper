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

@end

@implementation InfoViewController

@synthesize backgroundString = _backgroundString;




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
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:imageFileName]]];
} 


- (IBAction)firstBackgroundButton:(id)sender 
{
    [self setBackgroundString:@"Background-Wood.jpg"];
    [self setViewBackground:self.backgroundString];
}


- (IBAction)secondBackgroundButton:(id)sender 
{
    [self setBackgroundString:@"Background_Wood2.jpg"]; 
    [self setViewBackground:self.backgroundString];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ((ViewController *)segue.destinationViewController).backgroundString = self.backgroundString;
//    [((ViewController *)segue.destinationViewController) setViewBackground:self.backgroundString];
}


@end





