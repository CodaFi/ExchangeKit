//
//  EXKJSONRequestOperation.m
//  ExchangeKit
//
//  Created by Robert Widmann on 6/19/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "EXKJSONRequestOperation.h"
#import "EXKAPIResponse.h"
#import "EXKClient+EXKUser.h"

@implementation EXKJSONRequestOperation

- (void)setCompletionBlockWithSuccess:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
	[super setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
		EXKAPIResponse *response = [[EXKAPIResponse alloc] initWithResponseObject:responseObject];
		
		if (success) {
			success(operation, response);
		}
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		EXKAPIResponse *response = [[EXKAPIResponse alloc] initWithResponseObject:((AFJSONRequestOperation *)operation).responseJSON];
		
		NSMutableDictionary *modifiedUserInfo = [error.userInfo mutableCopy];
		modifiedUserInfo[kEXKAPIResponseKey] = response;
		NSError *modifiedError = [NSError errorWithDomain:error.domain code:error.code userInfo:modifiedUserInfo];
		
		if (failure) {
			failure(operation, modifiedError);
		}
    }];
}


@end
