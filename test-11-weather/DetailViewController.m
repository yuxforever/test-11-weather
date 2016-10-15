//
//  DetailViewController.m
//  test-11-weather
//
//  Created by Yu Ma on 7/12/16.
//  Copyright © 2016 Yu Ma. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(DataModel*)newDetailItem {
    if (_detailDataModel != newDetailItem) {
        _detailDataModel = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailDataModel) {
        self.detailDescriptionLabel.text = self.detailDataModel.weather_description;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"uuuuuuuuu  %@", self.detailDataModel);
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
