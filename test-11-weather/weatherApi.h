//
//  weatherApi.h
//  test-11-weather
//
//  Created by Yu Ma on 7/13/16.
//  Copyright © 2016 Yu Ma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModel.h"

@interface weatherApi : NSObject

-(void)getWeatherResultsWithQueryandSuccessCallback:(void(^)(NSArray <DataModel> *response))onSuccessCallback
                                           andError:(void(^)(NSError *errorResponse))onErrorCallback;

-(void)loadAsyncImageDataWithURL:(NSURL *)imageURL
              andSuccessCallback:(void(^)(NSData *imageData))onSuccessCallback;

@end
