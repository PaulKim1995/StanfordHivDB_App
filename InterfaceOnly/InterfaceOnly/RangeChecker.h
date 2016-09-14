//
//  RangeChecker.h
//  InterfaceOnly
//
//  Created by Paul Kim on 8/18/13.
//  Copyright (c) 2013 Paul Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RangeChecker : NSObject

-(NSMutableArray*) checkRangeWithMax: (int)max FromArray: (NSArray*) theArrayToBeChecked;

@end
