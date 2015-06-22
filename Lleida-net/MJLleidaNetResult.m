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

#import "MJLleidaNetResult.h"

#import "MJLleidaNetXML.h"

@implementation MJLleidaNetResult
{
    NSMutableString *_mutableString;
    NSMutableArray *_array;
}

#pragma mark - Protocols
#pragma mark NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:kUserInfoKey])
    {
        _userInfo = [[MJLleidaNetUserInfo alloc] initWithParent:self xmlKey:kUserInfoKey];
        parser.delegate = _userInfo;
    }
    else if ([elementName isEqualToString:@"mt_status"])
    {
        _messageStatus = [[MJLleidaNetMessageStatus alloc] initWithParent:self xmlKey:@"mt_status"];
        parser.delegate = _messageStatus;
    }
    else if ([elementName isEqualToString:@"mo_list"])
    {
        _array = [NSMutableArray array];
    }
    else if ([elementName isEqualToString:@"mo"])
    {
        MJLleidaNetIncomingMessage *incomingMessage = [[MJLleidaNetIncomingMessage alloc] initWithParent:self xmlKey:@"mo"];
        parser.delegate = incomingMessage;
        [_array addObject:incomingMessage];
    }
    else
    {
        _mutableString = [NSMutableString string];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [_mutableString appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    // If finishing result, return to the previous delegate
    
    if ([elementName isEqualToString:kActionKey])
    {
        _action = [_mutableString copy];
    }
    else if ([elementName isEqualToString:kStatusKey])
    {
        _status = [[_mutableString copy] integerValue];
    }
    else if ([elementName isEqualToString:kMsgKey])
    {
        _message = [_mutableString copy];
    }
    else if ([elementName isEqualToString:@"mo_list"])
    {
        _incomingMessages = [_array copy];
    }
    
    _mutableString = nil;
    
    [self parser:parser didEndElement:elementName];
}

- (NSString*)description
{
    #define key(key) NSStringFromSelector(@selector(key))
    NSDictionary *dictionary = [self dictionaryWithValuesForKeys:@[key(action),
                                                                   key(status),
                                                                   key(message),
                                                                   key(userInfo),
                                                                   key(messageStatus),
                                                                   key(incomingMessages),
                                                                   ]];
    
    return [NSString stringWithFormat:@"%@", [dictionary description]];
}

- (NSArray*)apx_descriptionKeys
{
    return @[key(action),
             key(status),
             key(message),
             key(userInfo),
             key(messageStatus),
             key(incomingMessages),
             ];
}

@end
