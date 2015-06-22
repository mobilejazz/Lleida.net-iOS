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

@implementation MJXMLObject

- (id)initWithParent:(id <NSXMLParserDelegate>)parent xmlKey:(NSString*)xmlKey
{
    self = [super init];
    if (self)
    {
        _parent = parent;
        _xmlKey = xmlKey;
    }
    return self;
}

- (void)parser:(NSXMLParser*)parser didEndElement:(NSString*)elementName
{
    // If finishing result, return to the previous delegate.
    if ([elementName isEqualToString:_xmlKey])
        parser.delegate = _parent;
}

- (NSArray*)apx_descriptionKeys
{
    return @[];
}

- (NSString*)apx_descriptionWithIndentationLevel:(NSInteger)indentation
{
    return [self apx_descriptionWithIndentationLevel:indentation object:self];
}

- (NSString*)apx_descriptionWithIndentationLevel:(NSInteger)indentation object:(id)object
{
    NSString* (^indentBlock)(NSInteger) = ^NSString*(NSInteger inde){
        NSMutableString *indent = [NSMutableString string];
        for (int i=0; i<=inde; ++i)
            [indent appendString:@"    "];
        return indent;
    };
    
    NSMutableString *string = [NSMutableString string];
    [string appendString:@"{\n"];
    
    if ([object isKindOfClass:MJXMLObject.class])
    {
        NSArray *keys = [object apx_descriptionKeys];
        
        [keys enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
            [string appendString:indentBlock(indentation)];
            [string appendFormat:@"%@: ", key];
            
            id value = [object valueForKey:key];
            
            if (value == nil)
            {
                [string appendString:@"null"];
            }
            else if ([value isKindOfClass:NSArray.class])
            {
                if ([value count] == 0)
                {
                    [string appendString:@"[ ]"];
                }
                else
                {
                    [string appendString:@"[\n"];
                    [(NSArray*)value enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                        [string appendString:[object apx_descriptionWithIndentationLevel:indentation+1 object:obj]];
                    }];
                    [string appendFormat:@"%@]",indentBlock(indentation)];
                }
            }
            else if ([value isKindOfClass:MJXMLObject.class])
            {
                [string appendString:[(MJXMLObject*)value apx_descriptionWithIndentationLevel:indentation+1]];
            }
            else
            {
                [string appendString:[value description]];
            }
            
            if (idx < keys.count-1)
                [string appendString:@",\n"];
        }];
    }
    else
    {
        [string appendString:[object description]];
    }
    
    [string appendFormat:@"\n%@}",indentBlock(indentation-1)];
    
    return [string copy];
}


@end
