//
//  EXKDistantIncrementalStore.h
//  ExchangeKit
//
//  Created by Robert Widmann on 6/19/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import <Foundation/Foundation.h>

COREDATA_EXTERN NSString *const EXKDistantStoreType;

@class EXKFetchRequest;

@interface EXKDistantPersistentStore : NSIncrementalStore

- (BOOL)loadMetadata:(NSError **)error;

- (void)executeRequest:(EXKFetchRequest *)request completion:(void(^)(id responseObject))completion failure:(void(^)(NSError *error))failure;

@end

@interface EXKDistantPersistentStore (EXKClientSideFlow)

- (NSURLRequest *)webAuthRequestForClientID:(NSString *)clientID authScopes:(EXKAuthScope)authScopes state:(NSString *)state;
- (void)authenticateUserWithAccessToken:(NSString *)accessToken ClientID:(NSString *)clientID key:(NSString *)key;

@end
