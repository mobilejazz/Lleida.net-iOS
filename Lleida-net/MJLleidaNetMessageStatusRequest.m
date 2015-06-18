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

#import "MJLleidaNetMessageStatusRequest.h"

@implementation MJLleidaNetMessageStatusRequest

- (NSString*)xmlWithUsername:(NSString *)username password:(NSString *)password
{
    if (_identifier == nil)
    {
        [[NSException exceptionWithName:NSInvalidArgumentException
                                 reason:@"A message state request requires a message identifier not nil."
                               userInfo:nil] raise];
    }
    
    NSMutableString *xmlBody = [NSMutableString string];
    
    [xmlBody appendString:@"<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>"];
    [xmlBody appendString:@"<query_mt_status>"];
    
    // Username & Password
    [xmlBody appendFormat:@"<user>%@</user>", username];
    [xmlBody appendFormat:@"<password>%@</password>", password];
    
    // Message identifier
    [xmlBody appendFormat:@"<mt_id>%@</mt_id>", _identifier];
    
    [xmlBody appendString:@"</query_mt_status>"];
    
    return [xmlBody copy];
}

@end
