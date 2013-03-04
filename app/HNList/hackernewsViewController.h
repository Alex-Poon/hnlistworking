//
//  hackernewsViewController.h
//  HNList
//
//  Created by Alex Poon on 2/20/13.
//  Copyright (c) 2013 Alex Poon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADTClient.h"
#import "MPHTMLBannerAdapter.h"
#import "MPAdView.h"

#define PUB_ID_320x50 @"agltb3B1Yi1pbmNyDAsSBFNpdGUYkaoMDA"
#define PUB_ID_300x250 @"agltb3B1Yi1pbmNyDAsSBFNpdGUYycEMDA"

@interface hackernewsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, ADTClientDelegate, MPAdViewDelegate> {
    ADTClient *_audioACR;
    MPAdView *_adView;
}

    @property (nonatomic, retain) ADTClient *audioACR;
    @property (nonatomic, retain) IBOutlet UIView *bottomview;
    @property (nonatomic, retain) IBOutlet UITableView *tableview;
@end