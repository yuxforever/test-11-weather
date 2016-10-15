//
//  DataModel.h
//  test-11-weather
//
//  Created by Yu Ma on 7/13/16.
//  Copyright © 2016 Yu Ma. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataModel
@end

@interface DataModel : NSObject
//@property (nonatomic, strong) NSMutableArray *city;

@property (nonatomic, strong)NSData *dataTime;
@property (nonatomic, strong) NSString *dtID;
@property (nonatomic, strong) NSString *humidity;
@property (nonatomic, strong) NSString *temp;
//
//
@property (nonatomic, strong) NSString *weather_description;
@property (nonatomic, strong) NSString *weather_icon;
@property (nonatomic, strong) NSString *weather_id;
@property (nonatomic, strong) NSString *weather_main;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end
