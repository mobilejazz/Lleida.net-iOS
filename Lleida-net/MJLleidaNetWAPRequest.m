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

#import "MJLleidaNetWAPRequest.h"

@implementation MJLleidaNetWAPDeliveryRecipt

- (NSString*)xml
{
    NSMutableString *xmlBody = [NSMutableString string];
    
    if (_email.length > 0)
    {
        NSMutableString *options = [NSMutableString string];
        
        if (_certificateName)
            [options appendFormat:@" cert_name=\"%@\"", _certificateName];
        
        if (_certificateId)
            [options appendFormat:@" cert_name_id=\"%@\"", _certificateId];
        
        
        [xmlBody appendFormat:@"<delivery_recipt%@>", options];
        [xmlBody appendFormat:@"%@", _email];
        [xmlBody appendString:@"</delivery_recipt>"];
    }
    else
    {
        [xmlBody appendString:@"<delivery_recipt/>"];
    }
    
    return [xmlBody copy];
}

@end

@implementation MJLleidaNetWAPRequest

- (NSString*)xmlWithUsername:(NSString*)username password:(NSString*)password
{
    NSMutableString *xmlBody = [NSMutableString string];
    
    // Begin WAP
    [xmlBody appendString:@"<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>"];
    [xmlBody appendString:@"<waplink>"];
    
    // Username
    [xmlBody appendFormat:@"<user>%@</user>", username];
    
    // Password
    [xmlBody appendFormat:@"<password>%@</password>", password];
    
    // Identifier
    if (_identifier.length > 0)
        [xmlBody appendFormat:@"<mt_id>%@</mt_id>", _identifier];
    
    // Recipients
    [xmlBody appendString:@"<dst>"];
    [_recipients enumerateObjectsUsingBlock:^(NSString *phone, NSUInteger idx, BOOL *stop) {
        [xmlBody appendFormat:@"<num>%@</num>", phone];
    }];
    [xmlBody appendString:@"</dst>"];
    
    // SMS body
    [xmlBody appendFormat:@"<txt encoding=\"base64\" charset=\"utf-16\">%@</txt>", [[_text dataUsingEncoding:NSUTF16StringEncoding] base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]];
    
    // Delivery recipt
    if (_deliveryRecipt)
        [xmlBody appendString:[_deliveryRecipt xml]];
    
    // End WAP
    [xmlBody appendString:@"</waplink>"];
    
    return [xmlBody copy];
}

@end
