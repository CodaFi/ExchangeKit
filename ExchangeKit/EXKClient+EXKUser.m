//
//  EXKClient+EXKUser.m
//  ExchangeKit
//
//  Created by Robert Widmann on 6/19/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "EXKClient+EXKUser.h"
#import "EXKUser.h"
#import "EXKTag.h"

@implementation EXKClient (EXKUser)

- (EXKJSONRequestOperation *)fetchCurrentUserWithCompletion:(EXKClientCompletionBlock)completionHandler {
	return [self enqueueGETPath:@"me"
					 parameters:@{ @"site" : @"stackoverflow", @"access_token" : self.accessToken, @"key" : self.apiKey, @"order" : @"desc", @"sort" : @"reputation" }
						success:[self successHandlerForResourceClass:EXKUser.class clientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];
}

- (EXKJSONRequestOperation *)fetchCurrentUserTagsWithCompletion:(EXKClientCompletionBlock)completionHandler {
	return [self enqueueGETPath:@"me/tags"
					 parameters:@{ @"site" : @"stackoverflow", @"access_token" : self.accessToken, @"key" : self.apiKey, @"order" : @"desc", @"sort" : @"popular" }
						success:[self successHandlerForCollectionOfResourceClass:EXKTag.class clientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];

}

@end
