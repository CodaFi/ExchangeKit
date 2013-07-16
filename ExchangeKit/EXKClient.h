//
//  EXKClient.h
//  ExchangeKit
//
//  Created by Robert Widmann on 6/19/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "AFHTTPClient.h"
#import "EXKConstants.h"

@class EXKUser;

@interface EXKClient : AFHTTPClient

@property (readonly, strong) EXKUser *authenticatedUser;
@property (strong) NSString *accessToken; // access token acquired by auth or persisted across launches and set directly
@property (strong) NSString *apiKey; // access token acquired by auth or persisted across launches and set directly

+ (NSURL *)APIBaseURL; // defaults to @"https://api.stackexchange.com/2.1/" -- subclass and override to change it
+ (instancetype)sharedClient;

- (NSURLRequest *)webAuthRequestForClientID:(NSString *)clientID authScopes:(EXKAuthScope)authScopes state:(NSString *)state;
- (void)authenticateUserWithAccessToken:(NSString *)accessToken ClientID:(NSString *)clientID key:(NSString *)key;

@property (copy) EXKWebAuthCompletionHandler webAuthCompletionHandler; // set as completion block for oauth authentication

@end
