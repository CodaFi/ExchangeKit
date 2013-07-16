//
//  EXKClient+EXKQuestion.h
//  ExchangeKit
//
//  Created by Robert Widmann on 6/19/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import <ExchangeKit/ExchangeKit.h>

@class EXKTag;

EXCHANGE_EXTERN NSString *const EXKActivitySortingCriteria; //last_activity_date
EXCHANGE_EXTERN NSString *const EXKCreationDateSortingCriteria; //creation_date
EXCHANGE_EXTERN NSString *const EXKVotesSortingCriteria; //score
EXCHANGE_EXTERN NSString *const EXKHotSortingCriteria; //by the formula ordering the hot tab;  Does not accept min or max
EXCHANGE_EXTERN NSString *const EXKWeekCriteria; //by the formula ordering the week tab;  Does not accept min or max
EXCHANGE_EXTERN NSString *const EXKMonthCriteria; //by the formula ordering the month tab; Does not accept min or max

@interface EXKClient (EXKQuestion)

- (EXKJSONRequestOperation *)fetchAllQuestionsWithSortingCriteria:(NSString *)criteria completion:(EXKClientCompletionBlock)completionHandler;
- (EXKJSONRequestOperation *)fetchAllQuestionsTaggedWith:(EXKTag *)tag withSortingCriteria:(NSString *)criteria completion:(EXKClientCompletionBlock)completionHandler;
- (EXKJSONRequestOperation *)fetchAllQuestionsWithTagName:(NSString *)tag withSortingCriteria:(NSString *)criteria completion:(EXKClientCompletionBlock)completionHandler;

@end
