//
//  MJLleidaNetIncomingMessage.m
//  Lleida.net
//
//  Created by Joan Martin on 18/06/15.
//  Copyright (c) 2015 Mobile Jazz. All rights reserved.
//

#import "MJLleidaNetIncomingMessage.h"

@implementation MJLleidaNetIncomingMessage
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
    if ([elementName isEqualToString:@"identifier"])
    {
        _identifier = [_mutableString copy];
    }
    else if ([elementName isEqualToString:@"tm_rec"])
    {
        _date = [NSDate dateWithTimeIntervalSince1970:[[_mutableString copy] doubleValue]];
    }
    else if ([elementName isEqualToString:@"src"])
    {
        _source = [_mutableString copy];
    }
    else if ([elementName isEqualToString:@"dst"])
    {
        _recipient = [_mutableString copy];
    }
    else if ([elementName isEqualToString:@"txt"])
    {
        _text = [_mutableString copy];
    }
    
    _mutableString = nil;
    
    [self parser:parser didEndElement:elementName];
}

- (NSString*)description
{
#define key(key) NSStringFromSelector(@selector(key))
    NSDictionary *dictionary = [self dictionaryWithValuesForKeys:@[key(identifier),
                                                                   key(date),
                                                                   key(source),
                                                                   key(recipient),
                                                                   key(text),
                                                                   ]];
    
    return [NSString stringWithFormat:@"%@", [dictionary description]];
}

@end
