//
// Copyright 2015 Mobile Jazz SL
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "MJLleidaNetResult.h"

#import "MJLleidaNetUserDetailsRequest.h"
#import "MJLleidaNetSMSRequest.h"
#import "MJLleidaNetWAPRequest.h"
#import "MJLleidaNetMessageStatusRequest.h"
#import "MJLleidaNetIncomingMessagesRequest.h"

/**
 * Returns the concatenated string including the identifier and phone to use as message identifier.
 **/
inline NSString* MJLleidaNetMsgIdentifier(NSString *identifier, NSString *phone)
{
    return [NSString stringWithFormat:@"%@:%@", identifier, phone];
}

typedef void (^MJLleidaNetResultBlock)(MJLleidaNetResult *result, NSError *error);

/**
 * Lleida.net API interface for iOS.
 **/
@interface MJLleidaNetClient : NSObject

/** ************************************************************ **
 * @name Initializers
 ** ************************************************************ **/

/**
 * Default initializer.
 * @param username The Lleida.net username.
 * @param password The Lleida.net password.
 * @return An initialized instance.
 **/
- (id)initWithUsername:(NSString*)username password:(NSString*)password;

/** ************************************************************ **
 * @name Attributes
 ** ************************************************************ **/

/**
 * The username.
 **/
@property (nonatomic, readonly) NSString *username;

/**
 * The password.
 **/
@property (nonatomic, readonly) NSString *password;

/**
 * The host.
 **/
@property (nonatomic, strong, readonly) NSString *host;

/** ************************************************************ **
 * @name Generic API methods
 ** ************************************************************ **/

/**
 * Performs a generic Lleida.net request.
 **/
- (void)performRequest:(MJLleidaNetRequest*)request completionBlock:(MJLleidaNetResultBlock)completionBlock;

@end

@interface MJLleidaNetClient (API)

/** ************************************************************ **
 * @name Specific API methods
 ** ************************************************************ **/

/**
 * Fetches the user details of the current Lleida.net user.
 * @param completionBlock A completion block.
 * @discussion If success, the user details will be located in the `userInfo` property of the result.
 **/
- (void)api_userDetailsWithCompletionBlock:(MJLleidaNetResultBlock)completionBlock;

/**
 * Send a SMS message to multiple phones.
 * @param message The message to send.
 * @param phones An array of strings of phone numbers.
 * @param completionBlock A completion block.
 **/
- (void)api_sendSMS:(NSString*)message phones:(NSArray*)phones completionBlock:(MJLleidaNetResultBlock)completionBlock;

/**
 * Requests the state of a sent message.
 * @param identifier The identifier of the sent message.
 * @param completionBlock A completion block.
 **/
- (void)api_stateOfMessageWithIdentifier:(NSString*)identifier completionBlock:(MJLleidaNetResultBlock)completionBlock;

/**
 * Fetches the incoming messages since last fetch.
 * @param completionBlock A completion block.
 **/
- (void)api_incomingMessagesWithCompletionBlock:(MJLleidaNetResultBlock)completionBlock;

@end
