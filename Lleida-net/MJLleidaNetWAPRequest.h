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

#import "MJLleidaNetRequest.h"

@interface MJLleidaNetWAPDeliveryReceipt : NSObject

+ (MJLleidaNetWAPDeliveryReceipt*)deliveryReceiptWithEmail:(NSString*)email;

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *certificateName;
@property (nonatomic, strong) NSString *certificateId;

- (NSString*)xml;

@end

@interface MJLleidaNetWAPRequest : MJLleidaNetRequest

+ (MJLleidaNetWAPRequest*)requestWithText:(NSString*)text url:(NSURL*)url recipients:(NSArray*)recipients;

@property (nonatomic, strong) MJLleidaNetWAPDeliveryReceipt *deliveryRecipt;
@property (nonatomic, strong) NSArray *recipients;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSURL *url;

@end
