//
//  EXKConstants.m
//  ExchangeKit
//
//  Created by Robert Widmann on 6/19/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "EXKConstants.h"

NSString * const EXKErrorDomain = @"EXKErrorDomain";
const NSInteger EXKErrorAuthenticationFailed = 666;
const NSInteger EXKErrorServiceRequestFailed = 667;
const NSInteger EXKErrorConnectionFailed = 668;
const NSInteger EXKErrorJSONParsingFailed = 669;
const NSInteger EXKErrorBadRequest = 670;

NSString * const EXKErrorRequestURLKey = @"EXKErrorRequestURLKey";
NSString * const EXKErrorHTTPStatusCodeKey = @"EXKErrorHTTPStatusCodeKey";

NSString *EXKScopeStringForAuthScopes(EXKAuthScope scopes) {
	if (scopes == EXKAuthScopeNone) return nil;
    
    NSMutableArray *scopeValues = [NSMutableArray array];
    if ((scopes & EXKAuthScopeReadInbox) == EXKAuthScopeReadInbox)		[scopeValues addObject:@"read_inbox"];
	if ((scopes & EXKAuthScopeNoExpiry) == EXKAuthScopeNoExpiry)			[scopeValues addObject:@"no_expiry"];
	if ((scopes & EXKAuthScopeWriteAccess) == EXKAuthScopeWriteAccess)	[scopeValues addObject:@"write_access"];
	if ((scopes & EXKAuthScopePrivateInfo) == EXKAuthScopePrivateInfo)	[scopeValues addObject:@"private_info"];
    
    return [scopeValues componentsJoinedByString:@","];
}
