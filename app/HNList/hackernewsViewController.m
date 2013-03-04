//
//  hackernewsViewController.m
//  HNList
//
//  Created by Alex Poon on 2/20/13.
//  Copyright (c) 2013 Alex Poon. All rights reserved.
//

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1

#define HNUrl [NSURL URLWithString: @"http://api.ihackernews.com/page"] //2

#import "hackernewsViewController.h"
#import "webViewController.h"

@implementation hackernewsViewController

    NSMutableArray *storiesList;
    NSMutableArray *storiesWithData;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self tableview] setDelegate:self];
    [[self tableview] setDataSource:self];
    
    ADTClient *newAudioACR = [[ADTClient alloc] initWithDelegate:self doRefresh:YES andAppID:@"ADTDemoApp" andAppSecret:@"ADTDemoApp"];
    self.audioACR = newAudioACR;
    [self.audioACR start];
    
    storiesList = [NSMutableArray array];
    [storiesList addObject:@"Loading..."];
    [self fire_dispatch];
    
    _adView = [[MPAdView alloc] initWithAdUnitId:PUB_ID_320x50 size:MOPUB_BANNER_SIZE];
    
    // Register your view controller as the MPAdView's delegate.
    _adView.delegate = self;
    [_adView loadAd];
    
    // Set the ad view's frame (in our case, to occupy the bottom of the screen).
    CGRect frame = _adView.frame;
    CGSize size = [_adView adContentViewSize];
    frame.origin.y = self.view.bounds.size.height - size.height - 43;
    _adView.frame = frame;
    
    // Add the ad view to your controller's view hierarchy.
    _adView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_adView];
    [self.view bringSubviewToFront:_adView];
    
    
  //  _adView.frame = CGRectMake(_adView.frame.origin.x, -_adView.frame.size.height, _adView.frame.size.width, _adView.frame.size.height);
//    [self.topview addSubview:_adView];
//    [self.tableView setContentInset:UIEdgeInsetsMake(_adView.frame.size.height, 0, 0, 0)];
    
    
}

/*
- (void)adViewDidLoadAd:(MPAdView *)view
{
    CGSize size = [view adContentViewSize];
    CGRect newFrame = view.frame;
    
    newFrame.size = size;
    newFrame.origin.x = (self.view.bounds.size.width - size.width) / 2;
    view.frame = newFrame;

}*/

- (void)fire_dispatch
{
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:HNUrl];
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
    });
}


- (void)fetchedData:(NSData *)responseData {
    @try {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
        NSMutableArray* stories = [json objectForKey:@"items"];
        [storiesList removeAllObjects];
        storiesWithData =   stories;
        NSLog(@"%@", storiesWithData);
        for(NSDictionary *key in stories) {
            NSLog(@"title: %@", [key objectForKey:@"title"]);
            [storiesList addObject:[key objectForKey:@"title"]];
        }
        
        NSLog(@"stories: %@", storiesList);
        [[self tableview] reloadData];
        //[self performSelectorOnMainThread:@selector(fetchedData:) withObject:nil waitUntilDone:NO];
    }
    @catch (NSException *exception) {
        NSLog(@"Sleeping");
        sleep(0.5);
        [self fire_dispatch];
    }
    
    
//    storiesList = stories;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [storiesList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"webCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [storiesList objectAtIndex:indexPath.row];
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"webSegue"]) {
        webViewController *detailViewController = [segue destinationViewController];
        detailViewController.story = [storiesWithData objectAtIndex:[self.tableview indexPathForSelectedRow].row];
        //detailViewController.treeData = [self.ds objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (indexPath.section == 0)
    [self performSegueWithIdentifier:@"webSegue" sender:self];
}

// Mandatory delegate methods
- (void) ADTClientDidReceiveMatch:(NSDictionary *)results
{
    NSLog(@"Received results %@", results);
}

- (void)ADTClientDidReceiveAd
{
    NSLog(@"AdTonik has ad for device");
}

// Optional delegate methods
- (void)ADTClientErrorDidOccur:(NSError *)error
{
    NSLog(@"ADTClient error occurred: %@", error);
}

- (void)ADTClientDidFinishSuccessfully
{
    NSLog(@"ADTClient Complete!");
}

#pragma mark MPAdViewDelegate Methods

// Implement MPAdViewDelegate's required method, -viewControllerForPresentingModalView.
- (UIViewController *)viewControllerForPresentingModalView {
    return self;
}

- (void)adViewDidFailToLoadAd:(MPAdView *)view {
    
}
- (void)adViewDidLoadAd:(MPAdView *)view {
    
}

@end
