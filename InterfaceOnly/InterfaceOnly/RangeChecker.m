//
//  RangeChecker.m
//  InterfaceOnly
//
//  Created by Paul Kim on 8/18/13.
//  Copyright (c) 2013 Paul Kim. All rights reserved.
//

#import "RangeChecker.h"

@implementation RangeChecker

-(NSMutableArray*) checkRangeWithMax:(int)max FromArray:(NSArray *)theArrayToBeChecked
{
    NSMutableArray* incorrectIndices = [[NSMutableArray alloc] init];
    
    NSLog (@" The length of the array, theArrayToBeChecked (which is really RTMutationsArray) is %i", [theArrayToBeChecked count]);
    
    for (NSUInteger i=0; i < [theArrayToBeChecked count]; i++)
    {
        NSScanner* mutationScanner = [NSScanner scannerWithString: [theArrayToBeChecked objectAtIndex: i]];
        int checkingMutation;
        
        [mutationScanner scanInt: &checkingMutation];
        
        NSLog (@"I = %i", i);
        
        if (checkingMutation > max)
        {
            NSNumber *incorrectIndex = [NSNumber numberWithInt: i];
            [incorrectIndices addObject: incorrectIndex];
            NSLog (@"Incorrect index = %i", i);
        }
        
        
        
    }
    
    return incorrectIndices;
}

@end
