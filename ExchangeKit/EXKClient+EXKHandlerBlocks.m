//
//  EXKClient+EXKHandlerBlocks.m
//  ExchangeKit
//
//  Created by Robert Widmann on 6/19/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "EXKClient+EXKHandlerBlocks.h"
#import <Mantle/Mantle.h>

@implementation EXKClient (EXKHandlerBlocks)

- (EXKJSONRequestOperation *)enqueueRequestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters success:(AFNetworkingSuccessBlock)successBlock failure:(AFNetworkingFailureBlock)failureBlock {
	NSURLRequest *request = [self requestWithMethod:method path:path parameters:parameters];
    EXKJSONRequestOperation *operation = (EXKJSONRequestOperation *)[self HTTPRequestOperationWithRequest:request success:successBlock failure:failureBlock];
    [self enqueueHTTPRequestOperation:operation];
	return operation;
}


- (EXKJSONRequestOperation *)enqueueGETPath:(NSString *)path parameters:(NSDictionary *)parameters success:(AFNetworkingSuccessBlock)successBlock failure:(AFNetworkingFailureBlock)failureBlock {
	return [self enqueueRequestWithMethod:@"GET" path:path parameters:parameters success:successBlock failure:failureBlock];
}


- (EXKJSONRequestOperation *)enqueuePOSTPath:(NSString *)path parameters:(NSDictionary *)parameters success:(AFNetworkingSuccessBlock)successBlock failure:(AFNetworkingFailureBlock)failureBlock {
	return [self enqueueRequestWithMethod:@"POST" path:path parameters:parameters success:successBlock failure:failureBlock];
}


- (EXKJSONRequestOperation *)enqueuePUTPath:(NSString *)path parameters:(NSDictionary *)parameters success:(AFNetworkingSuccessBlock)successBlock failure:(AFNetworkingFailureBlock)failureBlock {
	return [self enqueueRequestWithMethod:@"PUT" path:path parameters:parameters success:successBlock failure:failureBlock];
}


- (EXKJSONRequestOperation *)enqueueDELETEPath:(NSString *)path parameters:(NSDictionary *)parameters success:(AFNetworkingSuccessBlock)successBlock failure:(AFNetworkingFailureBlock)failureBlock {
	return [self enqueueRequestWithMethod:@"DELETE" path:path parameters:parameters success:successBlock failure:failureBlock];
}

- (NSArray *)unboxCollectionResponse:(EXKAPIResponse *)response ofResourceClass:(Class)resourceClass {
	id unboxedObject = nil;
	if ([resourceClass isSubclassOfClass:[EXKObject class]] && [response.data isKindOfClass:[NSArray class]]) {
		NSValueTransformer *arrayTransformer = [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:resourceClass];
		unboxedObject = [arrayTransformer transformedValue:response.data];
	}
	return unboxedObject;
}


- (AFNetworkingSuccessBlock)successHandlerForClientHandler:(EXKClientCompletionBlock)handler unboxBlock:(id (^)(EXKAPIResponse *response, NSError **error))unboxBlock {
	return ^(AFHTTPRequestOperation *operation, EXKAPIResponse *responseWrapper) {
		id finalObject = responseWrapper.data;
		NSError *error = nil;
		
		if (unboxBlock) {
			finalObject = unboxBlock(responseWrapper, &error);
		}
		
		if (handler) {
			handler(finalObject, error);
		}
	};
}


- (AFNetworkingSuccessBlock)successHandlerForResourceClass:(Class)resourceClass clientHandler:(EXKClientCompletionBlock)handler {
	return [self successHandlerForClientHandler:handler unboxBlock:^id(EXKAPIResponse *response, NSError *__autoreleasing *error) {
		id unboxedObject = nil;
		if ([resourceClass isSubclassOfClass:[EXKObject class]] && [response.data isKindOfClass:[NSDictionary class]]) {
			unboxedObject = [MTLJSONAdapter modelOfClass:resourceClass fromJSONDictionary:response.data error:nil];
		}
		return unboxedObject;
	}];
}


- (AFNetworkingSuccessBlock)successHandlerForCollectionOfResourceClass:(Class)resourceClass clientHandler:(EXKClientCompletionBlock)handler {
	return [self successHandlerForClientHandler:handler unboxBlock:^id(EXKAPIResponse *response, NSError *__autoreleasing *error) {
		return [self unboxCollectionResponse:response ofResourceClass:resourceClass];
	}];
}

- (AFNetworkingSuccessBlock)successHandlerForPrimitiveResponseWithClientHandler:(EXKClientCompletionBlock)handler {
	return ^(AFHTTPRequestOperation *operation, id responseObject) {
		EXKAPIResponse *response = (EXKAPIResponse *)responseObject;
		if (handler) {
			handler(response.data, nil);
		}
	};
}


- (AFNetworkingFailureBlock)failureHandlerForClientHandler:(EXKClientCompletionBlock)handler {
	return ^(AFHTTPRequestOperation *operation, NSError *error) {
		if (handler) {
			handler(nil, error);
		}
	};
}


@end
