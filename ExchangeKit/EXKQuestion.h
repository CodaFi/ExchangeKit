//
//  EXKQuestion.h
//  ExchangeKit
//
//  Created by Robert Widmann on 6/19/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import <ExchangeKit/ExchangeKit.h>

@class EXKUser;

@interface EXKQuestion : EXKObject

@property (nonatomic, copy) NSNumber *questionID;
@property (nonatomic, copy) NSDate *lastEditDate;
@property (nonatomic, copy) NSDate *creationDate;
@property (nonatomic, copy) NSDate *lastActivityDate;
@property (nonatomic, copy) NSNumber *answerCount;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray *tags;

@property (nonatomic, copy) NSNumber *score;
@property (nonatomic, copy) NSNumber *upvoteCount;
@property (nonatomic, copy) NSNumber *downvoteCount;
@property (nonatomic, copy) NSNumber *favoriteCount;
@property (nonatomic, copy) NSNumber *viewCount;

@property (nonatomic, strong) EXKUser *owner;

@property (nonatomic, copy) NSURL *link;
@property (nonatomic) BOOL isAnswered;

@end
