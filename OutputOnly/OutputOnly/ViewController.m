//
//  ViewController.m
//  OutputOnly
//
//  Created by Paul Kim on 8/20/13.
//  Copyright (c) 2013 Paul Kim. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog (@"web request started");
    NSString *post = [NSString stringWithFormat: @"program=hivdb&jspPage=hivdb_output.jsp&previousState=showMutationForm&RT_mutation_text=M41L,M184V&OutputAnalysis=Mutation Comments&action=ANALYZEM"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://sierra2.stanford.edu/sierra/servlet/JSierra"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(theConnection)
    {
        [_outputWebView loadRequest: request];
        
    }
    
    
	/*// Do any additional setup after loading the view, typically from a nib.
    NSString *fullURL = @"http://hivdb.stanford.edu";
    NSURL *url = [NSURL URLWithString: fullURL];
    NSURLRequest *requestObject = [NSURLRequest requestWithURL:url];
    [_outputWebView loadRequest: requestObject];
    */
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
