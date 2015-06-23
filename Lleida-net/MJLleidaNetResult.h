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

#import "MJXMLObject.h"

#import "MJLleidaNetUserInfo.h"
#import "MJLleidaNetMessageStatus.h"
#import "MJLleidaNetIncomingMessage.h"

typedef NS_ENUM(NSInteger, MJLleidaNetResultStatus)
{
    MJLleidaNetResultStatusCorrect              = 100,
    MJLleidaNetResultStatusUnknown              = 0,
    MJLleidaNetResultStatusInvalidXML           = -1,
    MJLleidaNetResultStatusInvalidUser          = -2,
    MJLleidaNetResultStatusNotEnoughCredit      = -3,
    MJLleidaNetResultStatusNoRecipients         = -4,
    MJLleidaNetResultStatusInvalidText          = -5,
    MJLleidaNetResultStatusTemporaryError       = -6,
    MJLleidaNetResultStatusDuplicatedSession    = -7,
    MJLleidaNetResultStatusInvalidEmail         = -8,
    MJLleidaNetResultStatusMTIDNotFound         = -9,
    MJLleidaNetResultStatusInvalidRecipient     = -10,
    MJLleidaNetResultStatusContactNotFound      = -11,
    MJLleidaNetResultStatusSocketError          = -12,
    MJLleidaNetResultStatusInvalidMTID          = -13,
    MJLleidaNetResultStatusInvalidSRC           = -14,
};

@interface MJLleidaNetResult : MJXMLObject

@property (nonatomic, strong) NSString *action;
@property (nonatomic, assign) MJLleidaNetResultStatus status;
@property (nonatomic, strong) NSString *message;

@property (nonatomic, strong) MJLleidaNetUserInfo *userInfo;
@property (nonatomic, strong) MJLleidaNetMessageStatus *messageStatus;
@property (nonatomic, strong) NSArray *incomingMessages;

@end
