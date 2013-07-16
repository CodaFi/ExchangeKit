//
//  EXKDistantIncrementalStore.m
//  ExchangeKit
//
//  Created by Robert Widmann on 6/19/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "EXKDistantPersistentStore.h"
#import "EXKFetchRequest.h"
#import "EXKClient.h"
#import "EXKClient+EXKHandlerBlocks.h"

NSString *const EXKDistantStoreType = @"EXKDistantStoreType";


@implementation EXKDistantPersistentStore

+ (void)initialize {
	[NSPersistentStoreCoordinator registerStoreClass:self forStoreType:[self type]];
}

+ (NSString *)type {
	return EXKDistantStoreType;
}

- (BOOL)loadMetadata:(NSError *__autoreleasing *)error {
	NSMutableDictionary *mutableMetadata = [NSMutableDictionary dictionary];
	[mutableMetadata setValue:[[NSProcessInfo processInfo] globallyUniqueString] forKey:NSStoreUUIDKey];
	[mutableMetadata setValue:EXKDistantStoreType forKey:NSStoreTypeKey];
	[self setMetadata:mutableMetadata];
	return YES;
}

- (void)executeRequest:(EXKFetchRequest *)request completion:(void (^)(id))completion failure:(void (^)(NSError *))failure {
	NSParameterAssert([request isKindOfClass:EXKFetchRequest.class]);
	[EXKClient.sharedClient enqueueRequestWithMethod:request.method path:request.path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
		completion(responseObject);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		failure(error);
	}];
}

@end


@implementation EXKDistantPersistentStore (EXKClientSideFlow)

- (NSURLRequest *)webAuthRequestForClientID:(NSString *)clientID authScopes:(EXKAuthScope)authScopes state:(NSString *)state {
	return [EXKClient.sharedClient webAuthRequestForClientID:clientID authScopes:authScopes state:state];
}

- (void)authenticateUserWithAccessToken:(NSString *)accessToken ClientID:(NSString *)clientID key:(NSString *)key {
	return [EXKClient.sharedClient authenticateUserWithAccessToken:accessToken ClientID:clientID key:key];
}

@end