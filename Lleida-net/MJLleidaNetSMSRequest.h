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

typedef NSString MJLleidaNetLanguageCode;

extern MJLleidaNetLanguageCode * const MJLLeidaNetLanguageCodeUndefined;
extern MJLleidaNetLanguageCode * const MJLLeidaNetLanguageCodeCatalan;
extern MJLleidaNetLanguageCode * const MJLLeidaNetLanguageCodeGerman;
extern MJLleidaNetLanguageCode * const MJLLeidaNetLanguageCodeEnglish;
extern MJLleidaNetLanguageCode * const MJLLeidaNetLanguageCodeSpanish;
extern MJLleidaNetLanguageCode * const MJLLeidaNetLanguageCodeFrench;
extern MJLleidaNetLanguageCode * const MJLLeidaNetLanguageCodeItalian;
extern MJLleidaNetLanguageCode * const MJLLeidaNetLanguageCodeDutch;
extern MJLleidaNetLanguageCode * const MJLLeidaNetLanguageCodePortugese;

@interface MJLleidaNetSMSDeliveryRecipt : NSObject

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) MJLleidaNetLanguageCode *languageCode;
@property (nonatomic, assign) BOOL requestReciptCertificate;
@property (nonatomic, strong) NSString *certificateName;
@property (nonatomic, strong) NSString *certificateId;

- (NSString*)xml;

@end

@interface MJLleidaNetSMSRequest : MJLleidaNetRequest

@property (nonatomic, assign) BOOL allowAnswer;
@property (nonatomic, strong) NSString *dataCoding;
@property (nonatomic, strong) MJLleidaNetSMSDeliveryRecipt *deliveryRecipt;
@property (nonatomic, strong) NSArray *recipients;
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSDate *scheduleDate;
@property (nonatomic, strong) NSString *sourceName;
@property (nonatomic, strong) NSString *text;

@end
