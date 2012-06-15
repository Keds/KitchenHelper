//
//  ViewController.m
//  Kitchenelper
//
//  Created by Kate A. on 5/28/12.
//  Copyright (c) 2012 Kedsuda Apichonbancha. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
- (NSString *)quantityLabel:(int)index;
@end

@implementation ViewController

@synthesize quantityScrollView;
@synthesize menuFirstUnitScrollView;
@synthesize menuSecondUnitScrollView;
@synthesize convertedQuantityLabel;
@synthesize unitFormulaLabel;
@synthesize unitButtonArray;
@synthesize quantityButtonArray;

const CGFloat kButtonWidth = 50.0;
const CGFloat kButtonHeight = 50.0;
const CGFloat kScrollWidth = 300.0;
const CGFloat kScrollHeight = 50.0;
const NSInteger kTotalQuantityButtons = 61;


float quantityInputOffset;
float firstUnitOffset;
float secondUnitOffset;
NSMutableDictionary *data;


- (NSMutableArray *)creatUnitArray
{
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:@"Milliliter"];
    [array addObject:@"Teaspoon"];
    [array addObject:@"Tablespoon"];
    [array addObject:@"Fluid Ounce"];
    [array addObject:@"Cup"];
    [array addObject:@"Pint"];
    [array addObject:@"Quart"];
    [array addObject:@"Liter"];
    [array addObject:@"Gallon"];
    
    self.unitButtonArray = [[NSMutableArray alloc] init];
    
    for (int i = 0 ; i < array.count; i++) 
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [btn setFrame:CGRectMake(0.0f, 0.0f, 2 * kButtonWidth, kButtonHeight)];
      
        NSString *btnTitle = [NSString stringWithFormat:@"%@",[array objectAtIndex:i]];
        
        [btn setTitle:btnTitle forState:UIControlStateNormal];
        btn.userInteractionEnabled = NO;
        [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [unitButtonArray addObject:btn];
        
    }
    return unitButtonArray;
}


- (NSMutableDictionary *)conversionDataTable
{
    NSMutableDictionary *dataTable = [[NSMutableDictionary alloc] init];
    
    NSArray *mlArray = [NSArray arrayWithObjects:@"1", @"0.20", @"0.0676280454", @"0.0338140227", @"0.00425", @"0.002125", @"0.0010625", @"0.001", @"0.000265625", nil];
    NSArray *tspArray = [NSArray arrayWithObjects:@"5", @"1", @"0.3333333333", @"0.16907", @"0.0208333333", @"0.00211", @"0.0052083333", @"0.0049289216", @"0.0013020833", nil];
    NSArray *tbspArray = [NSArray arrayWithObjects:@"14.7867648", @"3", @"1", @"0.50", @"0.06", @"0.03", @"0.02", @"0.01", @"0.004", nil];
    NSArray *ounceArray = [NSArray arrayWithObjects:@"29.57353", @"6", @"2", @"1", @"0.125", @"0.0625", @"0.03125", @"0.02957353", @"0.0078125", nil];
    NSArray *cupArray = [NSArray arrayWithObjects:@"236.5882375", @"48", @"16", @"8", @"1", @"0.5", @"0.25", @"0.23658824", @"0.0625", nil];
    NSArray *pintArray = [NSArray arrayWithObjects:@"473.176", @"96", @"32", @"16", @"2", @"1", @"0.5", @"0.47317647", @"0.125", nil];
    NSArray *quartArray = [NSArray arrayWithObjects:@"946.3529", @"192", @"64", @"32", @"4", @"2", @"1", @"0.94635295", @"0.25", nil];
    NSArray *literArray = [NSArray arrayWithObjects:@"1000", @"202.88414", @"67.628045", @"33.814023", @"4.2267528", @"2.1133764", @"1.0566882", @"1", @"0.26417205", nil];
    NSArray *gallonArray = [NSArray arrayWithObjects:@"3785.41178", @"768", @"256", @"128", @"16", @"8", @"4", @"3.7854118", @"1", nil];
    
    [dataTable setObject:mlArray forKey:@"Milliliter"];
    [dataTable setObject:tspArray forKey:@"Teaspoon"];
    [dataTable setObject:tbspArray forKey:@"Tablespoon"];
    [dataTable setObject:ounceArray forKey:@"Fluid Ounce"];
    [dataTable setObject:cupArray forKey:@"Cup"];
    [dataTable setObject:pintArray forKey:@"Pint"];
    [dataTable setObject:quartArray forKey:@"Quart"];
    [dataTable setObject:literArray forKey:@"Liter"];
    [dataTable setObject:gallonArray forKey:@"Gallon"];
    
    return dataTable;
}



/*
 - (NSMutableArray *)createUnitButtonArray {
 
 self.unitButtonArray = [[NSMutableArray alloc] init];
 
 for (int i = 0 ; i < self.unitButtonArray.count; i++) 
 {
 UIButton *btn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
 [btn setFrame:CGRectMake(0.0f, 0.0f, kButtonWidth, kButtonHeight)];
 
 NSString *fileName = [NSString stringWithFormat:@"%d_32.png", i+1];
 UIImage *image = [UIImage imageNamed:fileName];
 [btn setImage:image forState:UIControlStateNormal];
 btn.userInteractionEnabled = NO;
 [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
 
 [unitButtonArray addObject:btn];
 
 }
 
 return unitButtonArray;
 }
 */

- (NSMutableArray *)createQuantityButtonArray {
    
    self.quantityButtonArray = [[NSMutableArray alloc] initWithCapacity: kTotalQuantityButtons];
    
    for (int i = 0; i < kTotalQuantityButtons; i++) 
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        
        [btn setFrame:CGRectMake(0.0f, 0.0f, kButtonWidth, kButtonHeight)];
        
        [btn setTitle:[self quantityLabel:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:68.0/255.0 green:152.0/255.0 blue:180.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18.0]];
        btn.userInteractionEnabled = NO;
        [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        [quantityButtonArray addObject:btn];
    }
    return quantityButtonArray;
}


- (void)buttonPressed:(id)sender {
    
}

- (void)initializeQuantityScrollView {
    
    [quantityScrollView setScrollEnabled:YES];
    [quantityScrollView setContentSize:CGSizeMake( ((kTotalQuantityButtons - 1) * kButtonWidth) + kScrollWidth, kScrollHeight)];
//    [quantityScrollView setBackgroundColor:[UIColor grayColor]]
    
    quantityScrollView.showsVerticalScrollIndicator = FALSE;
    quantityScrollView.showsHorizontalScrollIndicator = FALSE;
    quantityScrollView.bounces = YES;
    
    quantityScrollView.delegate = self;
    
    [self createQuantityButtonArray];
    
    float totalButtonWidth = 0; // (quantityScrollView.frame.size.width / 20);
    
    for (int i = 0; i < kTotalQuantityButtons; i++) 
    {
        UIButton *btn = [quantityButtonArray objectAtIndex:i];
        
        CGRect btnRect = btn.frame;
        btnRect.origin.x = totalButtonWidth;
        [btn setFrame:btnRect];
        
        [quantityScrollView addSubview:btn];
        
        totalButtonWidth += btn.frame.size.width;
    }
}

- (void)createUnitScrollView:(UIScrollView *)scrollView
{
    [scrollView setScrollEnabled:YES];
    
    //  [scrollView setContentSize:CGSizeMake(((unitButtonArray.count - 1) * (2 * kButtonWidth) + kScrollWidth), kScrollHeight)];
    
    //    [scrollView setBackgroundColor:[UIColor orangeColor]];
    scrollView.showsHorizontalScrollIndicator = FALSE;
    scrollView.showsVerticalScrollIndicator = FALSE;
    scrollView.bounces = YES;
    
    scrollView.delegate = self;
    
    
    //[self createUnitButtonArray];
    [self creatUnitArray];
    
    float totalButtonWidth = 0.0; //(scrollView.frame.size.width / 20);
    
    for (int i = 0; i < [unitButtonArray count]; i++) 
    {
        UIButton *btn = [unitButtonArray objectAtIndex:i];
        
        // Move the buttons position in the x-demension (horizontal).
        CGRect btnRect = btn.frame;
        btnRect.origin.x = totalButtonWidth;
        [btn setFrame:btnRect];
        
        [btn setTitleColor:[UIColor colorWithRed:68.0/255.0 green:152.0/255.0 blue:180.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15.0]];

        
        // Add the button to the scrollview
        [scrollView addSubview:btn];
        
        // Add the width of the button to the total width.
        totalButtonWidth += btn.frame.size.width;
        
    }
    
    [scrollView setContentSize:CGSizeMake((totalButtonWidth - (kButtonWidth * 2) + kScrollWidth), kScrollHeight)];
}

- (void)initializeMenuFirstUnitScrollView {
    
    [self createUnitScrollView:menuFirstUnitScrollView];
    
}



- (void)initializeMenuSecondUnitScrollView 
{
    
    [self createUnitScrollView:menuSecondUnitScrollView];

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

- (float)convertInputNumber:(float)x
{
    float input = floorf(x/300.0);;
    int offset = (int)x % 300;
    switch (offset) {
        case 50:
            input += 0.25;
            break;
        case 100:
            input += .33;
            break;
        case 150:
            input += .50;
            break;
        case 200:
            input += .67;
            break;
        case 250:
            input += .75;
            break;
    }
    return input;
}

- (float)unitMenuContentOffset:(UIScrollView *)scrollView
{
    
    float xFirst = (floorf(scrollView.contentOffset.x / (2 * kButtonWidth)) * (2 * kButtonWidth)); 
    int mod = (int)scrollView.contentOffset.x % (int)(2 * kButtonWidth);
    if (mod >= 50) 
    {
        xFirst = xFirst + (2 * kButtonWidth);
    }
    
    [scrollView setContentOffset:CGPointMake(xFirst, scrollView.contentOffset.y) animated:YES];
    
    return xFirst;
}


- (NSString *)unitLabel:(float)offset
{
    NSString *label;
    
    switch ((int)offset) 
    {
        case 0:
            label = @"Milliliter";
            break;
        case 100:
            label = @"Teaspoon";
            break;
        case 200:
            label = @"Tablespoon";
            break;
        case 300:
            label = @"Fluid Ounce";
            break;
        case 400:
            label = @"Cup";
            break;
        case 500:
            label = @"Pint";
            break;
        case 600:
            label = @"Quart";
            break;
        case 700:
            label = @"Liter";
            break;
        case 800:
            label = @"Gallon";
            break;
    }
    return label;
}


- (void)textUnitFormulaLabel:(float)quantityOffset firstUnitOffset:(float)firstUnitOffset secondUnitOffset:(float)secondUnitOffset
{
    float firstQuantityInDigit = [self convertInputNumber:quantityOffset];
    
    NSString *firstUnitLabel = [self unitLabel:firstUnitOffset];
    NSString *secondUnitLabel = [self unitLabel:secondUnitOffset];
    
    NSInteger secondUnitIndex = secondUnitOffset/(2 * kButtonWidth);
    float secondQuantityInDigit = [[[data objectForKey:firstUnitLabel] objectAtIndex:secondUnitIndex] floatValue];

//    NSLog(@"dataArray = %@",[data objectForKey:firstUnitLabel]);
//    NSLog(@"first = %f, second = %f", firstQuantityInDigit, secondQuantityInDigit);
    
    float result = secondQuantityInDigit * firstQuantityInDigit;
    
    NSString *value = [NSString stringWithFormat:@"%.4f", result];
    
    if ([value hasSuffix:@".0000"]) {
        self.convertedQuantityLabel.text = [NSString stringWithFormat:@"%.0f", result];
    } else {
        self.convertedQuantityLabel.text = value;
    }
    
    NSString *secondQuantityInString = [NSString stringWithFormat:@"%.4f", secondQuantityInDigit];
    
    if ([secondQuantityInString hasSuffix:@".0000"]) {
        secondQuantityInString = [NSString stringWithFormat:@"%.0f", secondQuantityInDigit];
    }
    
    self.unitFormulaLabel.text = [NSString stringWithFormat:@"1 %@ = %@ %@",  firstUnitLabel, secondQuantityInString, secondUnitLabel];
}




- (void)handleScrollingEnd:(UIScrollView *)scrollView
{
    
    if (scrollView == self.quantityScrollView) {
   //     NSLog(@"quantity at %f, %f", scrollView.contentOffset.x, scrollView.contentOffset.y);
        float x = floorf((scrollView.contentOffset.x + 25.0) / 50.0f) * 50.0f;
        NSLog(@"quantity new = %f", x);
        [scrollView setContentOffset:CGPointMake(x, scrollView.contentOffset.y) animated:YES];
        quantityInputOffset = x;
        
        [self textUnitFormulaLabel:quantityInputOffset firstUnitOffset:firstUnitOffset secondUnitOffset:secondUnitOffset];
    }
    else if (scrollView == self.menuFirstUnitScrollView)
    {
        firstUnitOffset = [self unitMenuContentOffset:scrollView];
        
        [self textUnitFormulaLabel:quantityInputOffset firstUnitOffset:firstUnitOffset secondUnitOffset:secondUnitOffset];
        
    }
    else if (scrollView == self.menuSecondUnitScrollView)
    {
        secondUnitOffset = [self unitMenuContentOffset:scrollView];
        
        [self textUnitFormulaLabel:quantityInputOffset firstUnitOffset:firstUnitOffset secondUnitOffset:secondUnitOffset];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (decelerate == NO) {
        [self handleScrollingEnd:scrollView];
    }    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
 
{
    [self handleScrollingEnd:scrollView];
}


- (void)viewDidLoad
{
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background-Wood.jpg"]]];
    
    [self initializeQuantityScrollView];
    [self initializeMenuFirstUnitScrollView]; 
    [self initializeMenuSecondUnitScrollView];
    
    data = [self conversionDataTable];
    
    quantityInputOffset = 0;
    [self textUnitFormulaLabel:quantityInputOffset 
               firstUnitOffset:0 
              secondUnitOffset:0 ];
    
    
        
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    
}

- (void)viewDidUnload
{
    [self setMenuFirstUnitScrollView:nil];
    [self setUnitFormulaLabel:nil];
    [self setMenuSecondUnitScrollView:nil];
    [self setQuantityScrollView:nil];
    [self setConvertedQuantityLabel:nil];
    [self setMenuFirstUnitScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES; // (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
