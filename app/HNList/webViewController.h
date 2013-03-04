//
//  webViewController.h
//  HNList
//
//  Created by Alex Poon on 2/23/13.
//  Copyright (c) 2013 Alex Poon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface webViewController : UIViewController <UIWebViewDelegate>
@property (strong, nonatomic) NSDictionary *story;
@property (strong, nonatomic) IBOutlet UIWebView *theWebView;
@end
