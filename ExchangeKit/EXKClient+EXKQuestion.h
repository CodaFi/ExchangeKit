//
//  EXKClient+EXKQuestion.h
//  ExchangeKit
//
//  Created by Robert Widmann on 6/19/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import <ExchangeKit/ExchangeKit.h>

@class EXKTag;

EXCHANGE_EXTERN EXKSortingCriterion const EXKActivitySortingCriterion; //last_activity_date
EXCHANGE_EXTERN EXKSortingCriterion const EXKCreationDateSortingCriterion; //creation_date
EXCHANGE_EXTERN EXKSortingCriterion const EXKVotesSortingCriterion; //score
EXCHANGE_EXTERN EXKSortingCriterion const EXKHotSortingCriterion; //by the formula ordering the hot tab;  Does not accept min or max
EXCHANGE_EXTERN EXKSortingCriterion const EXKWeekCriterion; //by the formula ordering the week tab;  Does not accept min or max
EXCHANGE_EXTERN EXKSortingCriterion const EXKMonthCriterion; //by the formula ordering the month tab; Does not accept min or max

@interface EXKClient (EXKQuestion)

- (EXKJSONRequestOperation *)fetchAllQuestionsUsingSortingCriterion:(EXKSortingCriterion)criterion completion:(EXKClientCompletionBlock)completionHandler;
- (EXKJSONRequestOperation *)fetchAllQuestionsTaggedWith:(EXKTag *)tag usingSortingCriterion:(EXKSortingCriterion)criterion completion:(EXKClientCompletionBlock)completionHandler;
- (EXKJSONRequestOperation *)fetchAllQuestionsWithTagName:(NSString *)tag usingSortingCriterion:(EXKSortingCriterion)criterion completion:(EXKClientCompletionBlock)completionHandler;

@end
