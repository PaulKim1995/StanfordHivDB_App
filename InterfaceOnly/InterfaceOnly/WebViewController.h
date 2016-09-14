//
//  WebViewController.h
//  InterfaceOnly
//
//  Created by Paul Kim on 8/20/13.
//  Copyright (c) 2013 Paul Kim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIWebView *outputWebView;
@property (strong, nonatomic) NSString *rtText;
@property (strong, nonatomic) NSString *inText;
@property (strong, nonatomic) NSString *prText;

@end
