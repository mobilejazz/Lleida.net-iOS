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

@end
