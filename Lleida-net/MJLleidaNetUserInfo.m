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

#import "MJLleidaNetUserInfo.h"

#import "MJXMLObject+Debug.h"

@implementation MJLleidaNetUserInfo
{
    NSMutableString *_mutableString;
}

#pragma mark - Protocols
#pragma mark NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"phone_number"])
    {
        _phoneNumber = [[MJLleidaNetPhoneNumber alloc] initWithParent:self xmlKey:@"phone_number"];
        parser.delegate = _phoneNumber;
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
    if ([elementName isEqualToString:@"user"])
    {
        _name = [_mutableString copy];
    }
    else if ([elementName isEqualToString:@"credit"])
    {
        _credit = [[_mutableString copy] doubleValue];
    }
    else if ([elementName isEqualToString:@"status"])
    {
        _status = [_mutableString copy];
    }
    else if ([elementName isEqualToString:@"created"])
    {
        _created = [NSDate dateWithTimeIntervalSince1970:[[_mutableString copy] doubleValue]];
    }
    else if ([elementName isEqualToString:@"lastop"])
    {
        _lastOperation = [NSDate dateWithTimeIntervalSince1970:[[_mutableString copy] doubleValue]];
    }
    else if ([elementName isEqualToString:@"contact_name"])
    {
        _contactName = [_mutableString copy];
    }
    else if ([elementName isEqualToString:@"phone"])
    {
        _phone = [_mutableString copy];
    }
    else if ([elementName isEqualToString:@"email"])
    {
        _email = [_mutableString copy];
    }
    else if ([elementName isEqualToString:@"organization"])
    {
        _organization = [_mutableString copy];
    }
    else if ([elementName isEqualToString:@"cif"])
    {
        _cif = [_mutableString copy];
    }
    
    _mutableString = nil;
    
    [self parser:parser didEndElement:elementName];
}

- (NSString*)description
{
    #define key(key) NSStringFromSelector(@selector(key))
    NSDictionary *dictionary = [self dictionaryWithValuesForKeys:@[key(name),
                                                                   key(credit),
                                                                   key(status),
                                                                   key(created),
                                                                   key(lastOperation),
                                                                   key(contactName),
                                                                   key(phone),
                                                                   key(email),
                                                                   key(organization),
                                                                   key(cif),
                                                                   key(phoneNumber),
                                                                   ]];
    
    return [NSString stringWithFormat:@"%@", [dictionary description]];
}

- (NSArray*)apx_descriptionKeys
{
    return @[key(name),
             key(credit),
             key(status),
             key(created),
             key(lastOperation),
             key(contactName),
             key(phone),
             key(email),
             key(organization),
             key(cif),
             key(phoneNumber),
             ];
}

@end
