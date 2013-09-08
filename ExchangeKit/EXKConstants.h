//
//  EXKConstants.h
//  ExchangeKit
//
//  Created by Robert Widmann on 6/19/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EXKAPIResponse, AFHTTPRequestOperation;

#ifdef __cplusplus
	#define EXCHANGE_EXTERN		extern "C"
	#define EXCHANGE_PRIVATE_EXTERN	__attribute__((visibility("hidden"))) extern "C"
#else
	#define EXCHANGE_EXTERN		extern
	#define EXCHANGE_PRIVATE_EXTERN	__attribute__((visibility("hidden"))) extern
#endif

EXCHANGE_EXTERN NSString * const EXKErrorDomain;

EXCHANGE_EXTERN const NSInteger EXKErrorAuthenticationFailed;
EXCHANGE_EXTERN const NSInteger EXKErrorBadRequest;
EXCHANGE_EXTERN const NSInteger EXKErrorServiceRequestFailed;
EXCHANGE_EXTERN const NSInteger EXKErrorConnectionFailed;
EXCHANGE_EXTERN const NSInteger EXKErrorJSONParsingFailed;
EXCHANGE_EXTERN NSString * const EXKErrorRequestURLKey;
EXCHANGE_EXTERN NSString * const EXKErrorHTTPStatusCodeKey;

typedef NS_ENUM(NSUInteger, EXKAuthScope) {
    EXKAuthScopeNone            = 0,
    EXKAuthScopeReadInbox       = (1 << 0), // access a user's global inbox
    EXKAuthScopeNoExpiry        = (1 << 1), // access_token's with this scope do not expire
    EXKAuthScopeWriteAccess     = (1 << 2), // perform write operations as a user
    EXKAuthScopePrivateInfo     = (1 << 3), // access full history of a user's private actions on the site.
};

EXCHANGE_EXTERN NSString *EXKScopeStringForAuthScopes(EXKAuthScope scopes);

typedef void (^EXKWebAuthCompletionHandler)(BOOL success, NSError *error); // set as completion block for oauth authentication
typedef void (^EXKClientCompletionBlock)(id responseObject, NSError *error);
typedef void (^AFNetworkingSuccessBlock)(AFHTTPRequestOperation *operation, id responseObject);
typedef void (^AFNetworkingFailureBlock)(AFHTTPRequestOperation *operation, NSError *error);

typedef NSString* EXKSortingCriterion;
