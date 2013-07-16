//
//  EXKClient+EXKHandlerBlocks.h
//  ExchangeKit
//
//  Created by Robert Widmann on 6/19/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "EXKClient.h"
#import "EXKJSONRequestOperation.h"
#import "EXKAPIResponse.h"

static NSString *const kEXKAPIResponseKey = @"EXKAPIResponseKey";

@interface EXKClient (EXKHandlerBlocks)

- (NSArray *)unboxCollectionResponse:(EXKAPIResponse *)response ofResourceClass:(Class)resourceClass;
- (AFNetworkingSuccessBlock)successHandlerForClientHandler:(EXKClientCompletionBlock)handler unboxBlock:(id (^)(EXKAPIResponse *response, NSError **error))unboxBlock;
- (AFNetworkingSuccessBlock)successHandlerForResourceClass:(Class)resourceClass clientHandler:(EXKClientCompletionBlock)handler;
- (AFNetworkingSuccessBlock)successHandlerForCollectionOfResourceClass:(Class)resourceClass clientHandler:(EXKClientCompletionBlock)handler;
- (AFNetworkingSuccessBlock)successHandlerForPrimitiveResponseWithClientHandler:(EXKClientCompletionBlock)handler;

- (AFNetworkingFailureBlock)failureHandlerForClientHandler:(EXKClientCompletionBlock)handler;


- (EXKJSONRequestOperation *)enqueueRequestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters success:(AFNetworkingSuccessBlock)successBlock failure:(AFNetworkingFailureBlock)failureBlock;

- (EXKJSONRequestOperation *)enqueueGETPath:(NSString *)path parameters:(NSDictionary *)parameters success:(AFNetworkingSuccessBlock)successBlock failure:(AFNetworkingFailureBlock)failureBlock;

- (EXKJSONRequestOperation *)enqueuePOSTPath:(NSString *)path parameters:(NSDictionary *)parameters success:(AFNetworkingSuccessBlock)successBlock failure:(AFNetworkingFailureBlock)failureBlock;

- (EXKJSONRequestOperation *)enqueuePUTPath:(NSString *)path parameters:(NSDictionary *)parameters success:(AFNetworkingSuccessBlock)successBlock failure:(AFNetworkingFailureBlock)failureBlock;

- (EXKJSONRequestOperation *)enqueueDELETEPath:(NSString *)path parameters:(NSDictionary *)parameters success:(AFNetworkingSuccessBlock)successBlock failure:(AFNetworkingFailureBlock)failureBlock;


@end
