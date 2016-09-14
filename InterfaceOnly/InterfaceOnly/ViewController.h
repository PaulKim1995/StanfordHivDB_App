//
//  ViewController.h
//  InterfaceOnly
//
//  Created by Paul Kim on 8/13/13.
//  Copyright (c) 2013 Paul Kim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewController.h"
@interface ViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIAlertViewDelegate>



@property (strong, nonatomic) IBOutlet UIPickerView *mutationPicker;
- (IBAction)addMutation:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *addMutation;


//Arrays
@property (strong, nonatomic) NSArray *typeArray;
@property (strong, nonatomic) NSArray *digitArray;
@property (strong, nonatomic) NSArray *mutationArray;
//Arrays

@property (strong, nonatomic) IBOutlet UITextField *proteaseField;
@property (strong, nonatomic) IBOutlet UITextField *integraseField;
@property (strong, nonatomic) IBOutlet UITextField *rtField;


@property (strong, nonatomic) NSString *proteaseConsensusString;
@property (strong, nonatomic) NSString *rtConsensusString;
@property (strong, nonatomic) NSString *integraseConsensusString;



@property (strong,nonatomic) NSString *theMutationToDisplay;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *analyzeButton;
- (IBAction)analyzeButton:(id)sender;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *myInfoButton;
- (IBAction)myInfoButton:(id)sender;


-(NSMutableString*) errorCheckingForInput: (NSString*) inputText withMaxPosition: (int) max andConsensusString: (NSString*) consensusString;
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

@end
