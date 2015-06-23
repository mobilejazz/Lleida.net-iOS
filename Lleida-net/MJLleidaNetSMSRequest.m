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

#import "MJLleidaNetSMSRequest.h"

MJLleidaNetLanguageCode * const MJLLeidaNetLanguageCodeUndefined = nil;
MJLleidaNetLanguageCode * const MJLLeidaNetLanguageCodeCatalan = @"CA";
MJLleidaNetLanguageCode * const MJLLeidaNetLanguageCodeGerman = @"DE";
MJLleidaNetLanguageCode * const MJLLeidaNetLanguageCodeEnglish = @"EN";
MJLleidaNetLanguageCode * const MJLLeidaNetLanguageCodeSpanish = @"ES";
MJLleidaNetLanguageCode * const MJLLeidaNetLanguageCodeFrench = @"FR";
MJLleidaNetLanguageCode * const MJLLeidaNetLanguageCodeItalian = @"IT";
MJLleidaNetLanguageCode * const MJLLeidaNetLanguageCodeDutch = @"NL";
MJLleidaNetLanguageCode * const MJLLeidaNetLanguageCodePortugese = @"PT";


NSString* NSStringFromMJLleidaNetScheduleDate(NSDate *date)
{
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyyMMddHHmm";
    });
    
    return [dateFormatter stringFromDate:date];
}

@implementation MJLleidaNetSMSDeliveryReceipt

+ (MJLleidaNetSMSDeliveryReceipt*)deliveryReceiptWithEmail:(NSString*)email
{
    MJLleidaNetSMSDeliveryReceipt *instance = [MJLleidaNetSMSDeliveryReceipt new];
    instance.email = email;
    return instance;
}

+ (MJLleidaNetSMSDeliveryReceipt*)deliveryReceiptWithEmail:(NSString*)email language:(MJLleidaNetLanguageCode*)language
{
    MJLleidaNetSMSDeliveryReceipt *instance = [MJLleidaNetSMSDeliveryReceipt new];
    instance.email = email;
    instance.languageCode = language;
    return instance;
}

- (NSString*)xml
{
    NSMutableString *xmlBody = [NSMutableString string];
    
    if (_email.length > 0)
    {
        NSMutableString *options = [NSMutableString string];
        
        if (_languageCode.length > 0)
            [options appendFormat:@" lang=\"%@\"", _languageCode];
        
        if (_requestReceiptCertificate)
            [options appendFormat:@" cert_type=\"D\""];
        
        if (_certificateName)
            [options appendFormat:@" cert_name=\"%@\"", _certificateName];
        
        if (_certificateId)
            [options appendFormat:@" cert_name_id=\"%@\"", _certificateId];
        
        
        [xmlBody appendFormat:@"<delivery_receipt%@>", options];
        [xmlBody appendFormat:@"%@", _email];
        [xmlBody appendString:@"</delivery_receipt>"];
    }
    else
    {
        [xmlBody appendString:@"<delivery_receipt/>"];
    }
    
    return [xmlBody copy];
}

@end

@implementation MJLleidaNetSMSRequest

+ (MJLleidaNetSMSRequest*)requestWithText:(NSString*)text recipients:(NSArray*)recipients
{
    MJLleidaNetSMSRequest *instance = [MJLleidaNetSMSRequest new];
    instance.text = text;
    instance.recipients = recipients;
    return instance;
}

- (NSString*)xmlWithUsername:(NSString*)username password:(NSString*)password
{
    NSMutableString *xmlBody = [NSMutableString string];
    
    // Begin SMS
    [xmlBody appendString:@"<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>"];
    [xmlBody appendString:@"<sms>"];
    
    // Username
    [xmlBody appendFormat:@"<user>%@</user>", username];
    
    // Password
    [xmlBody appendFormat:@"<password>%@</password>", password];
    
    // Source Name or allow anaswer
    if (_sourceName.length > 0)
        [xmlBody appendFormat:@"<src>%@</src>", _sourceName];
    else if (_allowAnswer)
        [xmlBody appendFormat:@"<allow_answer/>"];
    
    // Data coding
    if (_dataCoding.length > 0)
        [xmlBody appendFormat:@"<data_coding>%@</data_coding>", _dataCoding];
    
    // Identifier
    if (_identifier.length > 0)
        [xmlBody appendFormat:@"<mt_id>%@</mt_id>", _identifier];
    
    // Recipients
    [xmlBody appendString:@"<dst>"];
    [_recipients enumerateObjectsUsingBlock:^(NSString *phone, NSUInteger idx, BOOL *stop) {
        NSString *fixedPhone = [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
        [xmlBody appendFormat:@"<num>%@</num>", fixedPhone];
    }];
    [xmlBody appendString:@"</dst>"];
    
    // SMS body
    [xmlBody appendFormat:@"<txt encoding=\"base64\" charset=\"utf-16\">%@</txt>", [[_text dataUsingEncoding:NSUTF16StringEncoding] base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]];
    
    // Delivery recipt
    if (_deliveryRecipt)
        [xmlBody appendString:[_deliveryRecipt xml]];
    
    // Schedule date
    if (_scheduleDate != nil)
        [xmlBody appendFormat:@"<schedule>%@</schedule>", NSStringFromMJLleidaNetScheduleDate(_scheduleDate)];
    
    // End SMS
    [xmlBody appendString:@"</sms>"];
    
    return [xmlBody copy];
}

@end
