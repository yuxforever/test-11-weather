//
//  DataModel.m
//  test-11-weather
//
//  Created by Yu Ma on 7/13/16.
//  Copyright © 2016 Yu Ma. All rights reserved.
//

#import "DataModel.h"

@interface DataModel ()

@end

@implementation DataModel

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    if (self = [super init]) {
      //  self.city = dictionary[@"city"];
          self.dataTime = dictionary[@"dt_txt"];
          self.dtID = dictionary[@"dt"];
          self.humidity = dictionary[@"main"][@"humidity"];
          self.temp = dictionary[@"main"][@"temp"];
          self.weather_description = [dictionary[@"weather"] objectAtIndex:0][@"description"] ;
        
          self.weather_icon = [dictionary[@"weather"] objectAtIndex:0][@"icon"];
          self.weather_id = [dictionary[@"weather"] objectAtIndex:0][@"id"];
          self.weather_main = [dictionary[@"weather"] objectAtIndex:0][@"main"];
    }
    return self;
}


@end
