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

typedef NS_ENUM(NSInteger, MJLleidaNetMsgStatus)
{
    MJLleidaNetMsgStatusNew = 1,
    MJLleidaNetMsgStatusPending = 2,
    MJLleidaNetMsgStatusSent = 3,
    MJLleidaNetMsgStatusDelivered = 4,
    MJLleidaNetMsgStatusBuffered = 5,
    MJLleidaNetMsgStatusFailed = 6,
    MJLleidaNetMsgStatusInvalid = 7,
    MJLleidaNetMsgStatusCancelled = 8,
    MJLleidaNetMsgStatusScheduled = 9,
    MJLleidaNetMsgStatusExpired = 10,
    MJLleidaNetMsgStatusDeleted = 11,
    MJLleidaNetMsgStatusUndeliverable = 12,
    MJLleidaNetMsgStatusUnknown = 13,
};

@interface MJLleidaNetMessageStatus : MJXMLObject

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, assign) MJLleidaNetMsgStatus status;
@property (nonatomic, strong) NSString *statusDescription;
@property (nonatomic, strong) NSDate *lastUpdate;
@property (nonatomic, assign) double credits;
@property (nonatomic, assign) NSInteger parts;

@end
