//
//  ViewController.m
//  Kitchen Helper
//
//  Created by Kate A. on 5/28/12.
//  Copyright (c) 2012 Kedsuda Apichonbancha. All rights reserved.
//

#import "ViewController.h"
#import "Unit.h"
#import "ButtonArrayScrollView.h"

@interface ViewController ()

@property (nonatomic, assign) float quantityInputOffset;
@property (nonatomic, assign) float firstUnitOffset;
@property (nonatomic, assign) float secondUnitOffset;
@property (nonatomic, strong) NSMutableDictionary *conversionDictionary;


@end

@implementation ViewController

@synthesize quantityScrollView = _quantityScrollView;
@synthesize menuFirstUnitScrollView = _menuFirstUnitScrollView;
@synthesize menuSecondUnitScrollView = _menuSecondUnitScrollView;
@synthesize convertedQuantityLabel = _convertedQuantityLabel;
@synthesize unitFormulaLabel = _unitFormulaLabel;
@synthesize unitButtonArray = _unitButtonArray;
@synthesize quantityButtonArray = _quantityButtonArray;
@synthesize quantityInputOffset = _quantityInputOffset;
@synthesize firstUnitOffset = _firstUnitOffset;
@synthesize secondUnitOffset = _secondUnitOffset;
@synthesize conversionDictionary = _conversionDictionary;
@synthesize backgroundString = _backgroundString;



- (NSMutableDictionary *)buildConversionTable
{
    NSMutableDictionary *conversionTable = [[NSMutableDictionary alloc] init];
    
    NSArray *mlArray = [NSArray arrayWithObjects:@"1", @"0.20", @"0.0676280454", @"0.0338140227", @"0.00425", @"0.002125", @"0.0010625", @"0.001", @"0.000265625", nil];
    NSArray *tspArray = [NSArray arrayWithObjects:@"5", @"1", @"0.3333333333", @"0.16907", @"0.0208333333", @"0.00211", @"0.0052083333", @"0.0049289216", @"0.0013020833", nil];
    NSArray *tbspArray = [NSArray arrayWithObjects:@"14.7867648", @"3", @"1", @"0.50", @"0.06", @"0.03", @"0.02", @"0.01", @"0.004", nil];
    NSArray *ounceArray = [NSArray arrayWithObjects:@"29.57353", @"6", @"2", @"1", @"0.125", @"0.0625", @"0.03125", @"0.02957353", @"0.0078125", nil];
    NSArray *cupArray = [NSArray arrayWithObjects:@"236.5882375", @"48", @"16", @"8", @"1", @"0.5", @"0.25", @"0.23658824", @"0.0625", nil];
    NSArray *pintArray = [NSArray arrayWithObjects:@"473.176", @"96", @"32", @"16", @"2", @"1", @"0.5", @"0.47317647", @"0.125", nil];
    NSArray *quartArray = [NSArray arrayWithObjects:@"946.3529", @"192", @"64", @"32", @"4", @"2", @"1", @"0.94635295", @"0.25", nil];
    NSArray *literArray = [NSArray arrayWithObjects:@"1000", @"202.88414", @"67.628045", @"33.814023", @"4.2267528", @"2.1133764", @"1.0566882", @"1", @"0.26417205", nil];
    NSArray *gallonArray = [NSArray arrayWithObjects:@"3785.41178", @"768", @"256", @"128", @"16", @"8", @"4", @"3.7854118", @"1", nil];
    
    [conversionTable setObject:mlArray forKey:MILLILITER];
    [conversionTable setObject:tspArray forKey:TEASPOON];
    [conversionTable setObject:tbspArray forKey:TABLESPOON];
    [conversionTable setObject:ounceArray forKey:FLUID_OUNCE];
    [conversionTable setObject:cupArray forKey:CUP];
    [conversionTable setObject:pintArray forKey:PINT];
    [conversionTable setObject:quartArray forKey:QUART];
    [conversionTable setObject:literArray forKey:LITER];
    [conversionTable setObject:gallonArray forKey:GALLON];
    
    return conversionTable;
}


- (void)initializeQuantityScrollView {
    

    [self.quantityScrollView buildQuantityScrollViewWithButtonWidth:kButtonWidth buttonHeight:kButtonHeight totalButtons:kTotalQuantityButtons];
    
    self.quantityScrollView.delegate = self;
}


- (void)initializeMenuFirstUnitScrollView
{
   // [self createUnitScrollView:menuFirstUnitScrollView];
    [self.menuFirstUnitScrollView buildUnitScrollViewWithButtonWidth:(kButtonWidth*2) buttonHeight:kButtonHeight];
    self.menuFirstUnitScrollView.delegate = self;
}


- (void)initializeMenuSecondUnitScrollView 
{
   // [self createUnitScrollView:menuSecondUnitScrollView];
    [self.menuSecondUnitScrollView buildUnitScrollViewWithButtonWidth:(kButtonWidth*2) buttonHeight:kButtonHeight];
    self.menuSecondUnitScrollView.delegate = self;
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
            label = MILLILITER;
            break;
        case 100:
            label = TEASPOON;
            break;
        case 200:
            label = TABLESPOON;
            break;
        case 300:
            label = FLUID_OUNCE;
            break;
        case 400:
            label = CUP;
            break;
        case 500:
            label = PINT;
            break;
        case 600:
            label = QUART;
            break;
        case 700:
            label = LITER;
            break;
        case 800:
            label = GALLON;
            break;
    }
    return label;
}

- (void)setUnitFormulaLabelFromQuantityOffset:(float)quantityContentOffset firstUnitOffset:(float)firstUnitContentOffset secondUnitOffset:(float)secondUnitContentOffset
{
    float firstQuantityInDigit = [self convertInputNumber:quantityContentOffset];
    
    NSString *firstUnitLabel = [self unitLabel:firstUnitContentOffset];
    NSString *secondUnitLabel = [self unitLabel:secondUnitContentOffset];
    
//    NSInteger secondUnitIndex = secondUnitContentOffset/(2 * kButtonWidth);
//    float secondQuantityInDigit = [[[conversionDictionary objectForKey:firstUnitLabel] objectAtIndex:secondUnitIndex] floatValue];
//
//    float result = secondQuantityInDigit * firstQuantityInDigit;
//    
//    NSString *value = [NSString stringWithFormat:@"%.4f", result];
//    
//    if ([value hasSuffix:@".0000"]) {
//        self.convertedQuantityLabel.text = [NSString stringWithFormat:@"%.0f", result];
//    } else {
//        self.convertedQuantityLabel.text = value;
//    }
//    NSString *secondQuantityInString;
//    secondQuantityInString = [NSString stringWithFormat:@"%.4f", secondQuantityInDigit];
//    if ([secondQuantityInString hasSuffix:@".0000"]) {
//        secondQuantityInString = [NSString stringWithFormat:@"%.0f", secondQuantityInString];
//    }
//    
//    NSString *plural = (secondQuantityInDigit == 0 || secondQuantityInDigit == 1) ? @"" : @"s";
//    self.unitFormulaLabel.text = [NSString stringWithFormat:@"1 %@ = %@ %@%@",  firstUnitLabel, secondQuantityInString, secondUnitLabel, plural];
    
    Unit *source = [Unit unitFrom:firstUnitLabel amount:1.0];
    float targetAmount = [source amountIn:secondUnitLabel];
    Unit *target = [Unit unitFrom:secondUnitLabel amount:targetAmount];
    self.unitFormulaLabel.text = [NSString stringWithFormat:@"%@ = %@", source, target];
    target.amount = [NSNumber numberWithFloat:[target.amount floatValue] * firstQuantityInDigit];
    
    self.convertedQuantityLabel.text = target.formattedAmount;
//
//    NSInteger secondUnitIndex = secondUnitContentOffset/(2 * kButtonWidth);
//    float secondQuantityInDigit = [[[self.conversionDictionary objectForKey:firstUnitLabel] objectAtIndex:secondUnitIndex] floatValue];
//
//    float result = secondQuantityInDigit * firstQuantityInDigit;
//    
//    NSString *value = [NSString stringWithFormat:@"%.4f", result];
//    
//    if ([value hasSuffix:@".0000"]) {
//        self.convertedQuantityLabel.text = [NSString stringWithFormat:@"%.0f", result];
//    } else {
//        self.convertedQuantityLabel.text = value;
//    }
//    NSString *secondQuantityInString;
//    secondQuantityInString = [NSString stringWithFormat:@"%.4f", secondQuantityInDigit];
//    if ([secondQuantityInString hasSuffix:@".0000"]) {
//        secondQuantityInString = [NSString stringWithFormat:@"%.0f", secondQuantityInString];
//    }
//    
//    NSString *plural = (secondQuantityInDigit == 0 || secondQuantityInDigit == 1) ? @"" : @"s";
//    self.unitFormulaLabel.text = [NSString stringWithFormat:@"1 %@ = %@ %@%@",  firstUnitLabel, secondQuantityInString, secondUnitLabel, plural];
}

- (void)handleScrollingEnd:(UIScrollView *)scrollView
{
    
    if (scrollView == self.quantityScrollView) {
        float x = floorf((scrollView.contentOffset.x + 25.0) / 50.0f) * 50.0f;
        NSLog(@"quantity new = %f", x);
        [scrollView setContentOffset:CGPointMake(x, scrollView.contentOffset.y) animated:YES];
        self.quantityInputOffset = x;
        
        [self setUnitFormulaLabelFromQuantityOffset:self.quantityInputOffset firstUnitOffset:self.firstUnitOffset secondUnitOffset:self.secondUnitOffset];
    }
    else if (scrollView == self.menuFirstUnitScrollView)
    {
        self.firstUnitOffset = [self unitMenuContentOffset:scrollView];
        
        [self setUnitFormulaLabelFromQuantityOffset:self.quantityInputOffset firstUnitOffset:self.firstUnitOffset secondUnitOffset:self.secondUnitOffset];
        
    }
    else if (scrollView == self.menuSecondUnitScrollView)
    {
        self.secondUnitOffset = [self unitMenuContentOffset:scrollView];
        
        [self setUnitFormulaLabelFromQuantityOffset:self.quantityInputOffset firstUnitOffset:self.firstUnitOffset secondUnitOffset:self.secondUnitOffset];
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


- (void)setBackgroundString:(NSString *)imageFileName
{
    _backgroundString = imageFileName;
    [self setViewBackground:imageFileName];
}

- (void)setViewBackground:(NSString *)imageFileName
{
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:imageFileName]]];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [segue.destinationViewController setBackgroundString:self.backgroundString];
    [segue.destinationViewController setViewBackground:self.backgroundString];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    if (self.backgroundString == nil) {
        self.backgroundString = @"Background-Wood.jpg";
    }
    
    [self initializeQuantityScrollView];
    [self initializeMenuFirstUnitScrollView]; 
    [self initializeMenuSecondUnitScrollView];
    
    self.conversionDictionary = [self buildConversionTable];
    
    self.quantityInputOffset = 0;
    [self setUnitFormulaLabelFromQuantityOffset:self.quantityInputOffset 
               firstUnitOffset:0 
                               secondUnitOffset:0 ];
    
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
    return NO; // interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}

@end
