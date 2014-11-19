//
//  SMViewController.m
//  RotaryWheelProject
//
//  Created by cesarerocchi on 2/10/12.
//  Copyright (c) 2012 studiomagnolia.com. All rights reserved.
//

#import "SMViewController.h"
#import "SMRotaryWheel.h"

@implementation SMViewController

@synthesize  valueLabel;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //ARRAY TEMPORARIO
    NSArray *arrayDeCompostos = [[NSArray alloc]initWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", nil];
    int numeroDeCompostos = arrayDeCompostos.count;
    NSLog(@"numero de compostos: %i", numeroDeCompostos);
    
//    valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 350, 120, 30)];
//    valueLabel.textAlignment = UITextAlignmentCenter;
//    valueLabel.backgroundColor = [UIColor lightGrayColor];
//    [self.view addSubview:valueLabel];
	
    SMRotaryWheel *wheel = [[SMRotaryWheel alloc] initWithFrame:CGRectMake(0, 0, 200, 200) andDelegate:self withSections:numeroDeCompostos eCompostos:arrayDeCompostos];
    
    wheel.center = CGPointMake(160, 240);
    [self.view addSubview:wheel];
    
    
    
}

- (void) wheelDidChangeValue:(NSString *)newValue {

    self.valueLabel.text = newValue;
    
}


@end
