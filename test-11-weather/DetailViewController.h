//
//  DetailViewController.h
//  test-11-weather
//
//  Created by Yu Ma on 7/12/16.
//  Copyright © 2016 Yu Ma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic)DataModel *detailDataModel;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
-(void)setDetailItem:(DataModel*)newDetailItem;

@end

