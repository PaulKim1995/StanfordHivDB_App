//
//  WebViewController.m
//  InterfaceOnly
//
//  Created by Paul Kim on 8/20/13.
//  Copyright (c) 2013 Paul Kim. All rights reserved.
//

#import "WebViewController.h"
#import "ViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

@synthesize rtText;
@synthesize prText;
@synthesize inText;

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
    
    //perform the web request
    NSLog (@"web request started");
    NSString *post = [NSString stringWithFormat: @"program=hivdb&jspPage=hivdb_app.jsp&previousState=showMutationForm&RT_mutation_text=%@&PR_mutation_text=%@&IN_mutation_text=%@&OutputAnalysis=MutationScores&OutputAnalysis=Mutation Comments&action=ANALYZEM", rtText, prText, inText];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://sierra-mirr.stanford.edu/sierra/servlet/JSierra"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(theConnection)
    {
        [_outputWebView loadRequest: request];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
