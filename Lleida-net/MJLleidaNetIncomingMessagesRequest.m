//
//  MJLleidaNetIncomingMessagesRequest.m
//  Lleida.net
//
//  Created by Joan Martin on 18/06/15.
//  Copyright (c) 2015 Mobile Jazz. All rights reserved.
//

#import "MJLleidaNetIncomingMessagesRequest.h"

@implementation MJLleidaNetIncomingMessagesRequest

- (NSString*)xmlWithUsername:(NSString*)username password:(NSString*)password
{
    NSMutableString *xmlBody = [NSMutableString string];
    
    [xmlBody appendString:@"<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>"];
    [xmlBody appendString:@"<get_new_incoming_mo>"];
    [xmlBody appendFormat:@"<user>%@</user>", username];
    [xmlBody appendFormat:@"<password>%@</password>", password];
    [xmlBody appendString:@"</get_new_incoming_mo>"];
    
    return [xmlBody copy];
}

@end
