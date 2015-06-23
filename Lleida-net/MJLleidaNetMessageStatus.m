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

#import "MJLleidaNetMessageStatus.h"
#import "MJXMLObject+Debug.h"

@implementation MJLleidaNetMessageStatus
{
    NSMutableString *_mutableString;
}

#pragma mark - Protocols
#pragma mark NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    _mutableString = [NSMutableString string];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [_mutableString appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"mt_id"])
    {
        _identifier = [_mutableString copy];
    }
    else if ([elementName isEqualToString:@"status_code"])
    {
        _status = [[_mutableString copy] integerValue];
    }
    else if ([elementName isEqualToString:@"status_desc"])
    {
        _statusDescription = [_mutableString copy];
    }
    else if ([elementName isEqualToString:@"tm_last_update"])
    {
        _lastUpdate = [NSDate dateWithTimeIntervalSince1970:[[_mutableString copy] doubleValue]];
    }
    else if ([elementName isEqualToString:@"credits"])
    {
        _credits = [[_mutableString copy] doubleValue];
    }
    else if ([elementName isEqualToString:@"num_parts"])
    {
        _parts = [[_mutableString copy] integerValue];
    }
    
    _mutableString = nil;
    
    [self parser:parser didEndElement:elementName];
}

- (NSString*)description
{
    #define key(key) NSStringFromSelector(@selector(key))
    NSDictionary *dictionary = [self dictionaryWithValuesForKeys:@[key(identifier),
                                                                   key(status),
                                                                   key(statusDescription),
                                                                   key(lastUpdate),
                                                                   key(credits),
                                                                   key(parts),
                                                                   ]];
    
    return [NSString stringWithFormat:@"%@", [dictionary description]];
}

- (NSArray*)apx_descriptionKeys
{
    return @[key(identifier),
             key(status),
             key(statusDescription),
             key(lastUpdate),
             key(credits),
             key(parts),
             ];
}

@end
