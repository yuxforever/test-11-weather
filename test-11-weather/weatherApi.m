//
//  weatherApi.m
//  test-11-weather
//
//  Created by Yu Ma on 7/13/16.
//  Copyright © 2016 Yu Ma. All rights reserved.
//

#import "weatherApi.h"
#import "DataModel.h"

@interface weatherApi ()

@property (nonatomic, strong) NSString *Url1;


@property (nonatomic, copy) void (^SuccessCallback)(NSArray <DataModel>*);


@end


@implementation weatherApi

-(instancetype)init {
    self = [super init];
    
    self.Url1 = @"http://api.openweathermap.org/data/2.5/forecast/city?id=4560349&units=metric&cnt=%ld&APPID=7af5ea3dcfa67987419392fafe2bc6ae";
    
    
    return self;
}

-(void)getWeatherResultsWithQueryandSuccessCallback:(void(^)(NSArray <DataModel> *response))onSuccessCallback
                        andError:(void(^)(NSError *errorResponse))onErrorCallback {
    NSLog(@"2222222");
    
    self.SuccessCallback = onSuccessCallback;
    NSString *urlString = self.Url1;
    NSString *escapedPath = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *nsurl = [[NSURL alloc] initWithString:escapedPath];
    NSLog(@"url send  %@", nsurl );
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:nsurl];
    
    NSOperation *backgroundOperation = [[NSOperation alloc] init];
    backgroundOperation.queuePriority = NSOperationQueuePriorityLow;
    backgroundOperation.qualityOfService = NSOperationQualityOfServiceBackground;
    
    NSOperationQueue *operationQueue = [NSOperationQueue new];
    [operationQueue addOperation:backgroundOperation];
    
    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                  delegate:nil
                             delegateQueue:operationQueue];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data,
                                                                NSURLResponse * _Nullable response,
                                                                NSError * _Nullable error) {
                                                if (!error) {
                                                    NSError *jsonError = nil;
                                                    NSDictionary *responseDictionary =
                                                    [NSJSONSerialization JSONObjectWithData:data
                                                                                    options:kNilOptions
                                                                                      error:&jsonError];
                                                    
                                                   
                                                    [self performSelectorInBackground:@selector(parseResultWithArrayOfDictionaries:) withObject:responseDictionary[@"list"]];
                                                    
                                                } else {
                                                    NSLog(@"An error occurred: %@", error.description);
                                                    
                                                    onErrorCallback (error);
                                                    
                                                }
                                            }];
    [task resume];
    
}

-(void)parseResultWithArrayOfDictionaries:(NSArray*)dictionaryArray {
    
    NSMutableArray <DataModel> *result = (NSMutableArray <DataModel> *) @[].mutableCopy;
    
    [dictionaryArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        DataModel *item = [[DataModel alloc] initWithDictionary:obj];
        
        [result addObject:item];
       
    }];
    
    self.SuccessCallback(result);
    
}

-(void)loadAsyncImageDataWithURL:(NSURL *)imageURL
              andSuccessCallback:(void(^)(NSData *imageData))onSuccessCallback {
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError * _Nullable error) {
        if (data) {
            onSuccessCallback(data);
        }
    }];
    
    [task resume];
}

@end

