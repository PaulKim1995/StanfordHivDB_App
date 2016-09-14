//
//  ViewController.m
//  InterfaceOnly
//
//  Created by Paul Kim on 8/13/13.
//  Copyright (c) 2013 Paul Kim. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


//The code for the information that must be sent to the output window's view controller in preparation for the window switch/segue. 
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"segueToWebView"])
    {
        WebViewController *controller = (WebViewController *) segue.destinationViewController;
        controller.rtText = _rtField.text;
        controller.prText = _proteaseField.text;
        controller.inText = _integraseField.text;
    }
}

//the segue that activates when the info button is pressed
-(IBAction) myInfoButton:(id)sender
{
    [self performSegueWithIdentifier: @"segueToInfoView" sender: self];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //------------------THE ARRAYS------------------
    self.typeArray = @[@"PR", @"IN", @"RT"];
    self.digitArray = @[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9",@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9",@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9",@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9",@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"];
    self.mutationArray = @[@"A ", @"C ", @"D ", @"E ", @"F ", @"G ", @"H ", @"I ", @"K ", @"L ", @"M ", @"N ", @"P ", @"Q ", @"R ", @"S ", @"T ", @"V ", @"W ", @"Y ", @"ins ", @"del ", @"A ", @"C ", @"D ", @"E ", @"F ", @"G ", @"H ", @"I ", @"K ", @"L ", @"M ", @"N ", @"P ", @"Q ", @"R ", @"S ", @"T ", @"V ", @"W ", @"Y ", @"ins ", @"del ", @"A ", @"C ", @"D ", @"E ", @"F ", @"G ", @"H ", @"I ", @"K ", @"L ", @"M ", @"N ", @"P ", @"Q ", @"R ", @"S ", @"T ", @"V ", @"W ", @"Y ", @"ins ", @"del ", @"A ", @"C ", @"D ", @"E ", @"F ", @"G ", @"H ", @"I ", @"K ", @"L ", @"M ", @"N ", @"P ", @"Q ", @"R ", @"S ", @"T ", @"V ", @"W ", @"Y ", @"ins ", @"del ",];
    
    
    
    //---------------END OF THE ARRAYS--------------
    
    self.theMutationToDisplay = @"";
    
    self.mutationPicker.delegate = self;
}


//-----------------------------Private Methods For Use Elsewhere in Viewcontroller.m----------------------------------------------


//Main Error Checking Method:

-(NSMutableString*) errorCheckingForInput:(NSString *)inputText withMaxPosition:(int)max andConsensusString:(NSString *)consensusString
{
    
    NSMutableString* errorMessage = [NSMutableString stringWithCapacity: 100];
    
    if ([inputText length] != 0)
    {
        NSArray* arrayOfMutations = [inputText componentsSeparatedByString: @" "];
        
        //convert consensus string to consensus array for future comparison
        NSMutableArray* consensusArray = [NSMutableArray arrayWithCapacity: 100];
        for (int i = 0; i < [consensusString length]; i++)
        {
            NSRange range = NSMakeRange(i, 1);
            NSString* temp = [consensusString substringWithRange:range];
            [consensusArray addObject: temp];
        }
        
        for (int i = 0; i < arrayOfMutations.count; i++)
        {
            NSString* currentMutation = [arrayOfMutations objectAtIndex: i];
            if ([currentMutation isEqualToString: @""])
            {
            //do nothing because it's an empty string
            }
            else
            {
                NSCharacterSet *positionNumber = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
                NSCharacterSet *aminoAcids = [NSCharacterSet characterSetWithCharactersInString: @"ABCDEFGHIJKLMNOPQRSTUVWXYZ"];

                NSString *currentMutationPosition = @""; //temp holds mutation position
                NSString *currentAminoAcid = @""; //temp holds amino acid
                NSString *noPositionEntered;
            
                NSScanner *scanner = [NSScanner scannerWithString: currentMutation]; //preps the scanner to parse the current mutation
            
                [scanner scanUpToCharactersFromSet: positionNumber intoString: &noPositionEntered]; //throws out anything before the first number
                [scanner scanCharactersFromSet: positionNumber intoString: &currentMutationPosition];
                int positionInt = 0;
                positionInt= [currentMutationPosition intValue];
                [scanner scanCharactersFromSet: aminoAcids intoString: &currentAminoAcid];
            
                //handles entry errors
                if ([noPositionEntered length] > 0 && positionInt == 0)
                {
                    [errorMessage appendString: @"No position entered at: "];
                    [errorMessage appendString: noPositionEntered];
                    [errorMessage appendString: @";\n"];
                }
                
                //handles out of range mutations
                else if (positionInt > max)
                {
                    [errorMessage appendString: @"Out of range at: "];
                    [errorMessage appendString: currentMutationPosition];
                    [errorMessage appendString: currentAminoAcid];
                    [errorMessage appendString: @";\n"];
                }
            
                //handles consensus mutation errors. 
                else if ([currentAminoAcid isEqualToString: [consensusArray objectAtIndex: positionInt-1]])
                {
                    [errorMessage appendString: @"Consensus entered at: "];
                    [errorMessage appendString: currentMutationPosition];
                    [errorMessage appendString: currentAminoAcid];
                    [errorMessage appendString: @";\n"];

                }
            }
        }
    }
    return errorMessage;
}

//-----------------------------End of Private Methods For Use Elsewhere in Viewcontroller.m----------------------------------




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-----------------PICKER VIEW PROTOCOL METHODS-----------------
//--------------------------------------------------------------



-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 5;
}




-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
        return [self.typeArray count];
    
    else if (component == 4)
        return [self.mutationArray count];
    
    else
        return [self.digitArray count];
    
}




-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0)
        return [self.typeArray objectAtIndex:row];
    else if (component == 4)
        return [self.mutationArray objectAtIndex:row];
    else
        return [self.digitArray objectAtIndex: row];
}

//--------------------------------------------ADD MUTATION BUTTON IMPLEMENTATION-----------------------------------------------
//--------------------------------------------ADD MUTATION BUTTON IMPLEMENTATION-----------------------------------------------
//--------------------------------------------ADD MUTATION BUTTON IMPLEMENTATION-----------------------------------------------
//--------------------------------------------ADD MUTATION BUTTON IMPLEMENTATION-----------------------------------------------


- (IBAction)addMutation:(id)sender {
    NSString* mutationPosition = @""; //initializes an empty NSString object, later used to hold the mutation position selected. 
 
    
    //creates strings that hold the user's selections for the 100s digit, 10s digit, and 1s digit. 
    NSString* mutation100sDigit = [self.digitArray objectAtIndex: [self.mutationPicker selectedRowInComponent:1]];
    NSString* mutation10sDigit = [self.digitArray objectAtIndex:[self.mutationPicker selectedRowInComponent:2]];
    NSString* mutation1sDigit = [self.digitArray objectAtIndex:[self.mutationPicker selectedRowInComponent:3]];
    //end of strings. 
    //Logic to handle leading zeroes. The result of the user's input is eventually added to the previously created "mutationPosition" string
    if ([mutation100sDigit isEqual: @"0"] && [mutation10sDigit isEqual: @"0"] && [mutation1sDigit isEqual: @"0"])
        NSLog (@"000 selected. Nothing happens");
    else if ([mutation100sDigit isEqual: @"0"] && [mutation10sDigit isEqual: @"0"])
        mutationPosition = mutation1sDigit;
    else if ([mutation100sDigit isEqual: @"0"])
        mutationPosition = [mutation10sDigit stringByAppendingString: mutation1sDigit];
    else
    {
        mutationPosition = [mutation100sDigit stringByAppendingString: mutation10sDigit];
        mutationPosition = [mutationPosition stringByAppendingString: mutation1sDigit];
    }
    //end of leading zero logic. 
    
    //determines what letter mutation was selected by the user
    NSString* mutationLetterString = [self.mutationArray objectAtIndex:[self.mutationPicker selectedRowInComponent:4]];
    
    
    //determines what type of mutation was selected by the user. 
    int mutationType = [self.mutationPicker selectedRowInComponent:0];
    
    
    //initializes an empty NSString object, used in the next line to contain the mutationPosition and mutationLetterString strings in one string object
    NSString* theNewestMutation = @"";
    theNewestMutation = [mutationPosition stringByAppendingString: mutationLetterString];
    //logic to determine which text field the newest mutation should be put in. Also enters the newest mutation into the text field. 
    switch (mutationType)
    {
        case 0: //this means PR
            _proteaseField.text = [self.proteaseField.text stringByAppendingString:theNewestMutation];
            break;
            
        case 1: //this means IN
            _integraseField.text = [self.integraseField.text stringByAppendingString:theNewestMutation];
            break;
        case 2: //this means RT
            _rtField.text = [self.rtField.text stringByAppendingString:theNewestMutation];
            break;
    }
    //end of logic
    
    
}
//--------------------------------------------END ADD MUTATION BUTTON IMPLEMENTATION-----------------------------------------------
//--------------------------------------------END ADD MUTATION BUTTON IMPLEMENTATION-----------------------------------------------
//--------------------------------------------END ADD MUTATION BUTTON IMPLEMENTATION-----------------------------------------------
//--------------------------------------------END ADD MUTATION BUTTON IMPLEMENTATION-----------------------------------------------
    

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}


- (IBAction)analyzeButton:(id)sender {

    NSMutableString *errorMessage = [NSMutableString stringWithCapacity: 100]; //intializing error message string for future use
    
    //contain the consensus mutations
    self.proteaseConsensusString = @"PQITLWQRPLVTIKIGGQLKEALLDTGADDTVLEEMNLPGRWKPKMIGGIGGFIKVRQYDQILIEICGHKAIGTVLVGPTPVNIIGRNLLTQIGCTLNF";
    self.integraseConsensusString = @"FLDGIDKAQEEHEKYHSNWRAMASDFNLPPVVAKEIVASCDKCQLKGEAMHGQVDCSPGIWQLDCTHLEGKIILVAVHVASGYIEAEVIPAETGQETAYFLLKLAGRWPVKTIHTDNGSNFTSTTVKAACWWAGIKQEFGIPYNPQSQGVVESMNKELKKIIGQVRDQAEHLKTAVQMAVFIHNFKRKGGIGGYSAGERIVDIIATDIQTKELQKQITKIQNFRVYYRDSRDPLWKGPAKLLWKGEGAVVIQDNSDIKVVPRRKAKIIRDYGKQMAGDDCVASRQDED";
    self.rtConsensusString = @"PISPIETVPVKLKPGMDGPKVKQWPLTEEKIKALVEICTEMEKEGKISKIGPENPYNTPVFAIKKKDSTKWRKLVDFRELNKRTQDFWEVQLGIPHPAGLKKKKSVTVLDVGDAYFSVPLDKDFRKYTAFTIPSINNETPGIRYQYNVLPQGWKGSPAIFQSSMTKILEPFRKQNPDIVIYQYMDDLYVGSDLEIGQHRTKIEELRQHLLRWGFTTPDKKHQKEPPFLWMGYELHPDKWTVQPIVLPEKDSWTVNDIQKLVGKLNWASQIYAGIKVKQLCKLLRGTKALTEVIPLTEEAELELAENREILKEPVHGVYYDPSKDLIAEIQKQGQGQWTYQIYQEPFKNLKTGKYARMRGAHTNDVKQLTEAVQKIATESIVIWGKTPKFKLPIQKETWEAWWTEYWQATWIPEWEFVNTPPLVKLWYQLEKEPIVGAETFYVDGAANRETKLGKAGYVTDRGRQKVVSLTDTTNQKTELQAIHLALQDSGLEVNIVTDSQYALGIIQAQPDKSESELVSQIIEQLIKKEKVYLAWVPAHKGIGGNEQVDKLVSAGIRKVL";
    //end of consensus mutations
    
    //run error checking, returning a string that contains error, if any.
    NSString* RTErrorMessage = [self errorCheckingForInput: self.rtField.text withMaxPosition:560 andConsensusString: self.rtConsensusString];
    NSString* INErrorMessage = [self errorCheckingForInput: self.integraseField.text withMaxPosition: 288 andConsensusString: self.integraseConsensusString];
    NSString* PRErrorMessage = [self errorCheckingForInput: self.proteaseField.text withMaxPosition: 99 andConsensusString: self.proteaseConsensusString];
    //done with error checking
    
    //Making the error message
    if ([RTErrorMessage length] > 0)
    {
        [errorMessage appendString: @"RT: "];
        [errorMessage appendString: RTErrorMessage];
    }
    
    if ([PRErrorMessage length] > 0)
    {
        [errorMessage appendString: @"\nPR: "];
        [errorMessage appendString: PRErrorMessage];
    }
    
    if ([INErrorMessage length] > 0)
    {
        [errorMessage appendString: @"\nIN: "];
        [errorMessage appendString: INErrorMessage];
    }
    
    //end of error messages. 
    
    if ([errorMessage length] == 0) // if error message is empty, don't show the alert and perform the segue. This also sends the data to the WebViewController
        [self performSegueWithIdentifier: @"segueToWebView" sender:self];
    else // if there is an error, show the alert box. 
    {
        
        UIAlertView *Error = [[UIAlertView alloc] initWithTitle: @"Error:" message: errorMessage delegate: self cancelButtonTitle: @"Okay" otherButtonTitles: nil];
        
        for (UIView *view in Error.subviews)
        {
            if([[view class] isSubclassOfClass:[UILabel class]])
            {
                ((UILabel*)view).textAlignment = NSTextAlignmentLeft;
            }
        }
        [Error show];
    }
    
}

@end
