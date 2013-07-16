//
//  EXKClient+EXKUser.h
//  ExchangeKit
//
//  Created by Robert Widmann on 6/19/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "EXKClient+EXKHandlerBlocks.h"

@interface EXKClient (EXKUser)

- (EXKJSONRequestOperation *)fetchCurrentUserWithCompletion:(EXKClientCompletionBlock)completionHandler;
- (EXKJSONRequestOperation *)fetchCurrentUserTagsWithCompletion:(EXKClientCompletionBlock)completionHandler;

@end
