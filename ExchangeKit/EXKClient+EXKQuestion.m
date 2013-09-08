//
//  EXKClient+EXKQuestion.m
//  ExchangeKit
//
//  Created by Robert Widmann on 6/19/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "EXKClient+EXKQuestion.h"
#import "EXKQuestion.h"
#import "EXKTag.h"

NSString *const EXKActivitySortingCriteria = @"activity";
NSString *const EXKCreationDateSortingCriteria = @"creation";
NSString *const EXKVotesSortingCriteria = @"votes";
NSString *const EXKHotSortingCriteria = @"hot";
NSString *const EXKWeekCriteria = @"week";
NSString *const EXKMonthCriteria = @"month";

@implementation EXKClient (EXKQuestion)

- (EXKJSONRequestOperation *)fetchAllQuestionsUsingSortingCriterion:(NSString *)criteria completion:(EXKClientCompletionBlock)completionHandler {
	NSParameterAssert(criteria != nil);
	return [self enqueueGETPath:@"questions"
					 parameters:@{ @"site" : @"stackoverflow", @"access_token" : self.accessToken, @"key" : self.apiKey, @"order" : @"desc", @"sort" : criteria,  @"filter" : @"withbody" }
						success:[self successHandlerForCollectionOfResourceClass:EXKQuestion.class clientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];
	
}

- (EXKJSONRequestOperation *)fetchAllQuestionsTaggedWith:(EXKTag *)tag usingSortingCriterion:(NSString *)criteria completion:(EXKClientCompletionBlock)completionHandler {
	return [self fetchAllQuestionsWithTagName:tag.name usingSortingCriterion:criteria completion:completionHandler];
}

- (EXKJSONRequestOperation *)fetchAllQuestionsWithTagName:(NSString *)tag usingSortingCriterion:(NSString *)criteria completion:(EXKClientCompletionBlock)completionHandler {
	NSParameterAssert(criteria != nil);
	NSParameterAssert(tag != nil);
	return [self enqueueGETPath:@"questions"
					 parameters:@{ @"site" : @"stackoverflow", @"access_token" : self.accessToken, @"key" : self.apiKey, @"order" : @"desc", @"sort" : criteria,  @"filter" : @"withbody", @"tagged" : tag }
						success:[self successHandlerForCollectionOfResourceClass:EXKQuestion.class clientHandler:completionHandler]
						failure:[self failureHandlerForClientHandler:completionHandler]];

}

@end
