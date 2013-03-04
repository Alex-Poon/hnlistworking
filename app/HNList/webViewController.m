//
//  webViewController.m
//  HNList
//
//  Created by Alex Poon on 2/23/13.
//  Copyright (c) 2013 Alex Poon. All rights reserved.
//

#import "webViewController.h"

@implementation webViewController
    @synthesize story;
    @synthesize theWebView;
    NSDictionary *story;

/*- (void)loadRequest:(NSURLRequest *)request {
    NSLog(@"%@", story);
//    [request initWithURL: [NSURL URLWithString:[story objectForKey:@"url"]]];
}*/

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"UIWEBVIEW");
    
    [self theWebView].delegate = self;
    [[self theWebView] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[story objectForKey:@"url"]]]];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"%s", __PRETTY_FUNCTION__);
//    [request loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://news.ycombinator.com"]]];
//    [request initWithURL:[NSURL URLWithString:@"http://news.ycombinator.com"]];
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
}
@end
