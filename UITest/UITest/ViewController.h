//
//  ViewController.h
//  UITest
//
//  Created by Paul Kim on 8/10/13.
//  Copyright (c) 2013 Paul Kim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *protease;
@property (strong, nonatomic) IBOutlet UIPickerView *mutationPicker;

@property (strong, nonatomic) NSArray *typeArray;
@property (strong, nonatomic) NSArray *positionArray;
@property (strong, nonatomic) NSArray *mutationArray;

@end
