//
//  ViewController.m
//  UITest
//
//  Created by Paul Kim on 8/10/13.
//  Copyright (c) 2013 Paul Kim. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.typeArray = [[NSArray alloc] initWithObjects: @"PR", @"TR", @"RT", nil];
    self.positionArray = [[NSArray alloc] initWithObjects: 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 3;
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    if (component == 0)
    {
        return [self.typeArray count];
    }
    else if (component == 1)
    {
        return [self.positionArray count];
    }
    else
    {
        return [self.mutationArray count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    return [self.typeArray objectAtIndex:row];

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
{
    
}


@end
